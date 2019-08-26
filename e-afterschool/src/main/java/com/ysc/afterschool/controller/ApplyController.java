package com.ysc.afterschool.controller;

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
import com.ysc.afterschool.domain.db.ApplyWait;
import com.ysc.afterschool.domain.db.Student;
import com.ysc.afterschool.domain.db.Subject;
import com.ysc.afterschool.domain.db.Apply.OrderType;
import com.ysc.afterschool.service.ApplyService;
import com.ysc.afterschool.service.ApplyWaitService;
import com.ysc.afterschool.service.SubjectService;

@Controller
@RequestMapping("apply")
public class ApplyController {

	@Autowired
	private ApplyService applyService;
	
	@Autowired
	private ApplyWaitService applyWaitService;
	
	@Autowired
	private SubjectService subjectService;
	
	/**
	 * 수강 신청 기능
	 * @param subjectId
	 * @param authentication
	 * @return
	 */
	@PostMapping("regist")
	public ResponseEntity<?> regist(int infoId, int subjectId, Authentication authentication) {
		Student student = (Student) authentication.getPrincipal();
		
		List<Apply> applies = applyService.getList(infoId, student.getId());
		if (applies.size() == 2) {
			return new ResponseEntity<String>("한 학생이 최대 2개 강좌까지<br> 신청 할 수 있습니다.", HttpStatus.BAD_REQUEST);
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
		
		return new ResponseEntity<String>("수강신청 실패하였습니다.", HttpStatus.BAD_REQUEST);
	}
	
	/**
	 * 수강 신청 대기 기능
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
		
		return new ResponseEntity<String>("수강신청 실패하였습니다.", HttpStatus.BAD_REQUEST);
	}
	
	
	/**
	 * 수강 취소 기능
	 * @param subjectId
	 * @param authentication
	 * @return
	 */
	@DeleteMapping("delete")
	public ResponseEntity<?> delete(int applyId) {
		Apply apply = applyService.get(applyId);
		if (applyService.delete(applyId)) {
			Subject subject = apply.getSubject();
			
			ApplyWait applyWait = applyWaitService.get(apply.getInvitationId(), subject.getId(), OrderType.오름차순);
			if (applyWait == null) {  // 대기 인원이 없을 경우
				subject.setApplyNumber(subject.getApplyNumber() - 1);
				if (subjectService.update(subject)) {
					return new ResponseEntity<>(HttpStatus.OK);
				}
			} else { // 대기 인원이 있을 경우
				List<Apply> applies = applyService.getList(applyWait.getInvitationId(), applyWait.getStudent().getId());
				if (applies.size() == 2) {
					return new ResponseEntity<String>("취소불가", HttpStatus.BAD_REQUEST);
				}
				
				if (applyService.regist(new Apply(applyWait.getInvitationId(), applyWait.getStudent(), subject))) {
					if (applyWaitService.delete(applyWait.getId())) {
						/***
						  형준이형 이 부분에 문자 서비스 넣어주세요!!!
						
						
						
						***/
						return new ResponseEntity<>(HttpStatus.OK);
					}
				}
			}
		}
		return new ResponseEntity<String>("수강취소 실패하였습니다.", HttpStatus.BAD_REQUEST);
	}
}
