package com.ysc.afterschool.controller;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ysc.afterschool.domain.db.Apply;
import com.ysc.afterschool.domain.db.Invitation;
import com.ysc.afterschool.domain.db.Student;
import com.ysc.afterschool.domain.db.Student.TargetType;
import com.ysc.afterschool.domain.db.Subject;
import com.ysc.afterschool.domain.db.Subject.ApplyType;
import com.ysc.afterschool.domain.db.Subject.GradeType;
import com.ysc.afterschool.service.ApplyService;
import com.ysc.afterschool.service.ApplyWaitService;
import com.ysc.afterschool.service.CityService;
import com.ysc.afterschool.service.InvitationService;
import com.ysc.afterschool.service.SubjectGroupService;
import com.ysc.afterschool.service.SubjectService;

/**
 * 과목 및 그룹 조회 컨트롤러 클래스
 * 
 * @author hgko
 *
 */
@Controller
@RequestMapping("subject")
public class SubjectController {
	
	@Autowired
	private CityService cityService;

	@Autowired
	private SubjectGroupService subjectGroupService;

	@Autowired
	private SubjectService subjectService;

	@Autowired
	private InvitationService invitationService;

	@Autowired
	private ApplyService applyService;

	@Autowired
	private ApplyWaitService applyWaitService;

	/**
	 * 수강신청 첫 화면 - 과목 리스트
	 * 
	 * @param model
	 * @param cityId
	 * @param infoId
	 * @return
	 */
	@GetMapping("group/{cityId}/{infoId}")
	public String group(Model model, @PathVariable int cityId, @PathVariable int infoId) {
		model.addAttribute("invitation", invitationService.get(infoId));
		model.addAttribute("subjectGroups", subjectGroupService.getList(infoId));
		model.addAttribute("city", cityService.get(cityId));
		
		return "subject/group";
	}

	/**
	 * 수강신청 확인 화면
	 * 
	 * @param model
	 * @param cityId
	 * @param infoId
	 * @param authentication
	 * @return
	 */
	@GetMapping("mylist/{cityId}/{infoId}")
	public String mylist(Model model, @PathVariable int cityId, @PathVariable int infoId,
			Authentication authentication) {
		
		model.addAttribute("city", cityService.get(cityId));
		model.addAttribute("invitation", invitationService.get(infoId));

		Student student = (Student) authentication.getPrincipal();
		List<Apply> applies = applyService.getList(infoId, student.getId()).stream().map(data -> {
			Subject subject = subjectService.get(data.getSubjectId());
			subject.setTarget(subject.getTargetType().getName() + " " + subject.getGradeType().getName());
			data.setSubject(subject);
			return data;
		}).collect(Collectors.toList());

		model.addAttribute("applies", applies);
		model.addAttribute("applyWaits", applyWaitService.getList(infoId, student.getId()));
		
		return "subject/mylist";
	}

	/**
	 * 수강신청 하위 과목 리스트 화면
	 * 
	 * @param model
	 * @param cityId
	 * @param infoId
	 * @param groupId
	 * @return
	 */
	@GetMapping("list/{cityId}/{infoId}/{groupId}")
	public String list(Model model, @PathVariable int cityId, @PathVariable int infoId, @PathVariable int groupId) {
		
		model.addAttribute("city", cityService.get(cityId));
		model.addAttribute("infoId", infoId);
		model.addAttribute("subjectGroup", subjectGroupService.get(groupId));
		model.addAttribute("subjects", subjectService.getList(infoId, groupId));
		
		return "subject/list";
	}

	/**
	 * 수강신청 하위 과목 마이크로 페이지 화면
	 * 
	 * @param model
	 * @param cityId
	 * @param infoId
	 * @param subjectId
	 * @param authentication
	 * @return
	 */
	@GetMapping("micro/{cityId}/{infoId}/{subjectId}")
	public String micro(Model model, @PathVariable int cityId, @PathVariable int infoId, @PathVariable int subjectId,
			Authentication authentication) {

		model.addAttribute("city", cityService.get(cityId));
		Invitation invitation = invitationService.get(infoId);
		model.addAttribute("invitation", invitation);

		Student student = (Student) authentication.getPrincipal();
		Subject subject = subjectService.get(subjectId);

		long applyCount = applyService.count(infoId, student.getId());
		
		if (applyService.search(infoId, student.getId(), subject.getId())) { // 신청 완료일 경우
			subject.setApplyType(ApplyType.APPLY);
		} else if (applyWaitService.search(infoId, student.getId(), subject.getId())) { // 신청 대기 중일 경우
			subject.setApplyType(ApplyType.APPLYWAIT);
		} else if (subject.getWaitFixedNumber() != 0 && subject.getWaitFixedNumber() <= subject.getWaitingNumber()) { // 대기인원 초과일 경우
			subject.setApplyType(ApplyType.WAITING);
		} else if (subject.getFixedNumber() <= subject.getApplyNumber()) { // 정원초과 일 경우
			subject.setApplyType(ApplyType.FILL);
		} else {
			if (subject.getTargetType() == TargetType.전체) {
				if (subject.getGradeType() == GradeType.초_3_6_중등 
						|| subject.getGradeType() == GradeType.초_5_6_중등
						|| subject.getGradeType() == GradeType.초_1_6_중등) {
					if (student.getTargetType() == TargetType.초등) {
						if (subject.targetTrue(subject.getGradeType(), student.getGrade())) {
							applyCheck(subject, applyCount, invitation.getApplyNumber());
						} else {
							subject.setApplyType(ApplyType.NOTAPPLY);
						}
					} else if (student.getTargetType() == TargetType.중등) {
						applyCheck(subject, applyCount, invitation.getApplyNumber());
					}
				} else {
					if (subject.targetTrue(subject.getGradeType(), student.getGrade())) {
						applyCheck(subject, applyCount, invitation.getApplyNumber());
					} else {
						subject.setApplyType(ApplyType.NOTAPPLY);
					}
				}
			} else if (subject.getTargetType() == student.getTargetType()) {
				if (subject.targetTrue(subject.getGradeType(), student.getGrade())) { // 학생의 학년이 과목의 학년 범위에 해당할 경우
					applyCheck(subject, applyCount, invitation.getApplyNumber());
				} else {
					subject.setApplyType(ApplyType.NOTAPPLY);
				}
			} else {
				subject.setApplyType(ApplyType.NOTAPPLY);
			}
		}
		
		model.addAttribute("subject", subject);
		
		return "subject/micro";
	}

	/**
	 * 수강 신청이 2개 등록이 완료된 학생은 수강신청을 못함
	 * 
	 * @param subject
	 * @param applyCount
	 * @param applyNumber 수강신청제한인원수
	 */
	private void applyCheck(Subject subject, long applyCount, int applyNumber) {

		if (applyCount >= applyNumber) {
			subject.setApplyType(ApplyType.NOTAPPLY);
		} else {
			subject.setApplyType(ApplyType.NONE);
		}
	}

	/**
	 * 과목정보 및 과목특징 화면
	 * 
	 * @param model
	 * @param cityId
	 * @param infoId
	 * @param subjectId
	 * @return
	 */
	@GetMapping("info/{cityId}/{infoId}/{subjectId}")
	public String info(Model model, @PathVariable int cityId, @PathVariable int infoId, @PathVariable int subjectId) {

		model.addAttribute("city", cityService.get(cityId));
		model.addAttribute("infoId", infoId);

		Subject subject = subjectService.get(subjectId);
		if (subject.getTargetType() == TargetType.전체) {
			if (subject.getGradeType() == GradeType.초_3_6_중등
					|| subject.getGradeType() == GradeType.초_5_6_중등
					|| subject.getGradeType() == GradeType.초_1_6_중등) {
				subject.setTarget(subject.getGradeType().getName());
			} else {
				subject.setTarget("전체");
			}
		} else {
			subject.setTarget(subject.getTargetType().getName() + " " + subject.getGradeType().getName());
		}

		model.addAttribute("subject", subject);
		
		return "subject/info";
	}
}
