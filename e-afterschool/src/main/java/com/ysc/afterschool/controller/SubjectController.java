package com.ysc.afterschool.controller;

import java.util.List;
import java.util.stream.Collectors;

import javax.servlet.http.Cookie;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ysc.afterschool.domain.db.Apply;
import com.ysc.afterschool.domain.db.Student;
import com.ysc.afterschool.domain.db.Student.TargetType;
import com.ysc.afterschool.domain.db.Subject;
import com.ysc.afterschool.domain.db.Subject.ApplyType;
import com.ysc.afterschool.domain.db.Subject.GradeType;
import com.ysc.afterschool.service.ApplyService;
import com.ysc.afterschool.service.ApplyWaitService;
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
	 * @param model
	 * @param infoId
	 * @param cookie
	 */
	@GetMapping("group")
	public void group(Model model, int infoId, @CookieValue(value = "cityId", required = false) Cookie cookie) {
		model.addAttribute("invitation", invitationService.get(infoId));
		model.addAttribute("cityId", cookie.getValue());
		model.addAttribute("subjectGroups", subjectGroupService.getList());
	}
	
	/**
	 * 수강신청 확인 화면
	 * @param model
	 * @param infoId
	 * @param cookie
	 */
	@GetMapping("mylist")
	public void mylist(Model model, int infoId, Authentication authentication, 
			@CookieValue(value = "cityId", required = false) Cookie cookie) {
		model.addAttribute("cityId", cookie.getValue());
		model.addAttribute("invitation", invitationService.get(infoId));
		
		Student student = (Student) authentication.getPrincipal();
		List<Apply> applies = applyService.getList(infoId, student.getId()).stream().map(data -> {
			Subject subject = subjectService.get(data.getSubjectId());
			subject.setTarget(subject.getTargetType().getName() + " " + subject.getGradeType().getName());
			data.setSubject(subject);
			return data;
		}).collect(Collectors.toList());
		model.addAttribute("applies", applies);
	}
	
	/**
	 * 수강신청 하위 과목 리스트 화면
	 * @param model
	 * @param infoId
	 * @param groupId
	 * @param cookie
	 */
	@GetMapping("list")
	public void list(Model model, int infoId, int groupId, @CookieValue(value = "cityId", required = false) Cookie cookie) {
		model.addAttribute("cityId", cookie.getValue());
		model.addAttribute("infoId", infoId);
		model.addAttribute("subjectGroup", subjectGroupService.get(groupId));
		model.addAttribute("subjects", subjectService.getList(infoId, groupId));
	}
	
	/**
	 * 수강신청 하위 과목 마이크로 페이지 화면
	 * @param model
	 * @param infoId
	 * @param id
	 * @param cookie
	 */
	@GetMapping("micro")
	public void micro(Model model, int infoId, int id, Authentication authentication, 
			@CookieValue(value = "cityId", required = false) Cookie cookie) {
		model.addAttribute("cityId", cookie.getValue());
		model.addAttribute("invitation", invitationService.get(infoId));
		
		Student student = (Student) authentication.getPrincipal();
		
		Subject subject = subjectService.get(id);
		
//		long applyCount = applyService.count(infoId, student.getId());
//		if (applyCount > 2) {
//			subject.setApplyType(ApplyType.NOTAPPLY);
//		} 
			
		if (applyService.search(infoId, student.getId(), subject.getId())) {
			subject.setApplyType(ApplyType.APPLY);
		} else if (applyWaitService.search(infoId, student.getId(), subject.getId())) {
			subject.setApplyType(ApplyType.APPLYWAIT);
		} else if (subject.getWaitFixedNumber() <= subject.getWaitingNumber()) {
			subject.setApplyType(ApplyType.WAITING);
		} else if (subject.getFixedNumber() <= subject.getApplyNumber()) { // 정원초과 일 경우
			subject.setApplyType(ApplyType.FILL);
		} else {
			if (subject.getTargetType() == TargetType.전체) {
				if (student.getTargetType() == TargetType.초등) {
					if (subject.targetTrue(subject.getGradeType(), student.getGrade())) {
						subject.setApplyType(ApplyType.NONE);
					} else {
						subject.setApplyType(ApplyType.NOTAPPLY);
					}
				} else {
					subject.setApplyType(ApplyType.NONE);
				}
			} else if (subject.getTargetType() == student.getTargetType()) {
				if (subject.targetTrue(subject.getGradeType(), student.getGrade())) {
					subject.setApplyType(ApplyType.NONE);
				} else {
					subject.setApplyType(ApplyType.NOTAPPLY);
				}
			} else {
				subject.setApplyType(ApplyType.NOTAPPLY);
			}
		}
		model.addAttribute("subject", subject);
	}
	
	/**
	 * 과목정보 및 과목특징 화면
	 * @param model
	 * @param infoId
	 * @param id
	 * @param cookie
	 */
	@GetMapping("info")
	public void info(Model model, int infoId, int id, @CookieValue(value = "cityId", required = false) Cookie cookie) {
		model.addAttribute("cityId", cookie.getValue());
		model.addAttribute("infoId", infoId);
		
		Subject subject = subjectService.get(id);
		if (subject.getTargetType() == TargetType.전체) {
			if (subject.getGradeType() == GradeType.초_3_6_중등) {
				subject.setTarget(subject.getGradeType().getName());
			} else {
				subject.setTarget("전체");
			}
		} else {
			subject.setTarget(subject.getTargetType().getName() + " " + subject.getGradeType().getName());
		}
		model.addAttribute("subject", subject);
	}
}
