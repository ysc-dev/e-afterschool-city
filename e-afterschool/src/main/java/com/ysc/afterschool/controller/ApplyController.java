package com.ysc.afterschool.controller;

import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ysc.afterschool.domain.db.Apply;
import com.ysc.afterschool.domain.db.ApplyCancel;
import com.ysc.afterschool.domain.db.Apply.OrderType;
import com.ysc.afterschool.domain.db.ApplyWait;
import com.ysc.afterschool.domain.db.Invitation;
import com.ysc.afterschool.domain.db.Student;
import com.ysc.afterschool.domain.db.Subject;
import com.ysc.afterschool.service.ApplyCancelService;
import com.ysc.afterschool.service.ApplyService;
import com.ysc.afterschool.service.ApplyWaitService;
import com.ysc.afterschool.service.InvitationService;
import com.ysc.afterschool.service.SubjectService;
import com.ysc.afterschool.service.common.SmsService;

/**
 * 수강신청 기능 컨트롤러
 * 
 * @author hgko
 *
 */
@Controller
@RequestMapping("apply")
public class ApplyController {
	
	@Autowired
	private InvitationService invitationService;

	@Autowired
	private ApplyService applyService;
	
	@Autowired
	private ApplyWaitService applyWaitService;
	
	@Autowired
	private SubjectService subjectService;
	
	@Autowired
	private SmsService smsService;
	
	@Autowired
	private ApplyCancelService applyCancelService;
	
	/**
	 * 수강 신청 기능
	 * 
	 * @param infoId
	 * @param subjectId
	 * @param authentication
	 * @return
	 */
	@PostMapping("regist")
	public ResponseEntity<?> regist(int infoId, int subjectId, Authentication authentication) {
		
		Student student = (Student) authentication.getPrincipal();
		
		Invitation invitation = invitationService.get(infoId);
		if (!invitation.getCity().getName().equals("함양")) {
			List<Apply> applies = applyService.getList(infoId, student.getId());
			if (applies.size() == 2) {
				return new ResponseEntity<String>("한 학생이 최대 2개 강좌까지<br>신청 할 수 있습니다.", HttpStatus.BAD_REQUEST);
			}
		}
		
		Subject subject = subjectService.get(subjectId);
		if (subject.getFixedNumber() <= subject.getApplyNumber()) {
			return new ResponseEntity<String>("정원초과", HttpStatus.BAD_REQUEST);
		}
		
		if (applyService.regist(new Apply(infoId, student, subject))) {
			subject.setApplyNumber(subject.getApplyNumber() + 1);
			if (subjectService.update(subject)) {
				return new ResponseEntity<>(HttpStatus.OK);
			}
		}
		
		return new ResponseEntity<String>("수강 신청을 실패하였습니다.", HttpStatus.BAD_REQUEST);
	}
	
	/**
	 * 수강 신청 대기 기능
	 * 
	 * @param infoId
	 * @param subjectId
	 * @param authentication
	 * @return
	 */
	@PostMapping("wait/regist")
	public ResponseEntity<?> waitRegist(int infoId, int subjectId, Authentication authentication) {
		
		Student student = (Student) authentication.getPrincipal();
		
		Subject subject = subjectService.get(subjectId);
		if (subject.getWaitFixedNumber() <= subject.getWaitingNumber()) {
			return new ResponseEntity<String>("대기 인원이 꽉 찼습니다.", HttpStatus.BAD_REQUEST);
		}
		
		ApplyWait applyWait = applyWaitService.get(infoId, subject.getId(), OrderType.내림차순);
		int order = applyWait == null ? 1 : applyWait.getOrderNumber();
		
		if (applyWaitService.regist(new ApplyWait(infoId, student, subject, order + 1))) {
			subject.setWaitingNumber(subject.getWaitingNumber() + 1);
			if (subjectService.update(subject)) {
				return new ResponseEntity<>(HttpStatus.OK);
			}
		}
		
		return new ResponseEntity<String>("수강 신청을 실패하였습니다.", HttpStatus.BAD_REQUEST);
	}
	
	
	/**
	 * 수강 취소 기능
	 * 
	 * @param applyId
	 * @return
	 */
	@DeleteMapping("delete")
	public ResponseEntity<?> delete(int applyId) {
		
		Apply apply = applyService.get(applyId);
		Subject subject = subjectService.get(apply.getSubjectId());
		
		if (applyService.delete(applyId)) {
			applyCancelService.regist(new ApplyCancel(apply));
			
			//ApplyWait applyWait = applyWaitService.get(apply.getInvitationId(), subject.getId(), OrderType.오름차순);
			List<ApplyWait> applyWaits = applyWaitService.getList(subject.getId());
			if (applyWaits.size() == 0) {  // 대기 인원이 없을 경우
				subject.setApplyNumber(subject.getApplyNumber() - 1);
				
				if (subjectService.update(subject)) {
					return new ResponseEntity<>(HttpStatus.OK);
				}
			} else { // 대기 인원이 있을 경우
				for (ApplyWait applyWait : applyWaits) {
					
					List<Apply> applies = applyService.getList(applyWait.getInvitationId(), applyWait.getStudent().getId());
					if (applies.size() < 2) { // 수강대기 첫번째 학생의 수강신청 한 과목이 두개가 아닐 경우
						if (applyService.regist(new Apply(applyWait.getInvitationId(), applyWait.getStudent(), subject))) {
							if (applyWaitService.delete(applyWait.getId())) {
								subject.setWaitingNumber(subject.getWaitingNumber() - 1);
								
								if (subjectService.update(subject)) {
									try {
										smsService.send(applyWait.getStudent().getTel(), applyWait.getInvitationId());
									} catch (IOException e) {
										e.printStackTrace();
									}
									
									return new ResponseEntity<>(HttpStatus.OK);
								}
							}
						}
					}
				}
				 
				// 대기 인원은 있는데 수강대기 학생들이 최대로(2과목) 수강신청 한 경우
				subject.setApplyNumber(subject.getApplyNumber() - 1);
				
				if (subjectService.update(subject)) {
					return new ResponseEntity<>(HttpStatus.OK);
				}
			}
		}
		
//		if (applyService.delete(applyId)) {
//			ApplyWait applyWait = applyWaitService.get(apply.getInvitationId(), subject.getId(), OrderType.오름차순);
//			if (applyWait == null) {  // 대기 인원이 없을 경우
//				subject.setApplyNumber(subject.getApplyNumber() - 1);
//				if (subjectService.update(subject)) {
//					return new ResponseEntity<>(HttpStatus.OK);
//				}
//			} else { // 대기 인원이 있을 경우
//				List<Apply> applies = applyService.getList(applyWait.getInvitationId(), applyWait.getStudent().getId());
//				if (applies.size() < 3) { // 수강신청 한 과목이 두개가 아닐 경우
//					if (applyService.regist(new Apply(applyWait.getInvitationId(), applyWait.getStudent(), subject))) {
//						if (applyWaitService.delete(applyWait.getId())) {
//							subject.setWaitingNumber(subject.getWaitingNumber() - 1);
//							if (subjectService.update(subject)) {
//								try {
//									smsService.send(applyWait.getStudent().getTel());
//								} catch (IOException e) {
//									e.printStackTrace();
//								}
//								
//								return new ResponseEntity<>(HttpStatus.OK);
//							}
//						}
//					}
//				}
//			}
//		}
		
		return new ResponseEntity<String>("수강 취소를 실패하였습니다.", HttpStatus.BAD_REQUEST);
	}
}
