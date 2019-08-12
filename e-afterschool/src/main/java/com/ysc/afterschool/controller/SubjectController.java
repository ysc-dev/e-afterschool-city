package com.ysc.afterschool.controller;

import javax.servlet.http.Cookie;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ysc.afterschool.domain.db.Subject;
import com.ysc.afterschool.service.ApplyService;
import com.ysc.afterschool.service.ClassContentsService;
import com.ysc.afterschool.service.InvitationService;
import com.ysc.afterschool.service.SubjectGroupService;
import com.ysc.afterschool.service.SubjectNoticeService;
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
	private SubjectNoticeService subjectNoticeService;
	
	@Autowired
	private InvitationService invitationService;
	
	@Autowired
	private ClassContentsService classContentsService;
	
	@Autowired
	private ApplyService applyService;

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
	public void mylist(Model model, int infoId, @CookieValue(value = "cityId", required = false) Cookie cookie) {
		model.addAttribute("cityId", cookie.getValue());
		model.addAttribute("infoId", infoId);
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
		model.addAttribute("subjects", subjectService.getList(groupId));
	}
	
	/**
	 * 수강신청 하위 과목 마이크로 페이지 화면
	 * @param model
	 * @param infoId
	 * @param id
	 * @param cookie
	 */
	@GetMapping("micro")
	public void micro(Model model, int infoId, int id, @CookieValue(value = "cityId", required = false) Cookie cookie) {
		model.addAttribute("cityId", cookie.getValue());
		model.addAttribute("infoId", infoId);
		model.addAttribute("subject", subjectService.get(id));
	}
	
	/**
	 * 과목정보 및 과목특정 화면
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
		subject.setTarget(subject.getTargetType().getName() + " " + subject.getGradeType().getName());
		model.addAttribute("subject", subject);
	}
	
	/**
	 * 커뮤니티 화면
	 * @param model
	 * @param infoId
	 * @param id
	 * @param cookie
	 */
	@GetMapping("community")
	public void community(Model model, int infoId, int id, @CookieValue(value = "cityId", required = false) Cookie cookie) {
		model.addAttribute("cityId", cookie.getValue());
		model.addAttribute("infoId", infoId);
		model.addAttribute("subject", subjectService.get(id));
		model.addAttribute("subjectNotices", subjectNoticeService.getList(id));
	}
	
	/**
	 * 횟수별 수업내용 화면
	 * @param model
	 * @param infoId
	 * @param id
	 * @param cookie
	 */
	@GetMapping("class")
	public void classView(Model model, int infoId, int id, @CookieValue(value = "cityId", required = false) Cookie cookie) {
		model.addAttribute("cityId", cookie.getValue());
		model.addAttribute("infoId", infoId);
		model.addAttribute("subject", subjectService.get(id));
		model.addAttribute("classContents", classContentsService.getList(id));
	}
}
