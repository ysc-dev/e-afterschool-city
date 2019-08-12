package com.ysc.afterschool.controller;

import javax.servlet.http.Cookie;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ysc.afterschool.service.InvitationService;
import com.ysc.afterschool.service.SubjectGroupService;

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
	private InvitationService invitationService;

	@GetMapping("group/{invitationId}")
	public String group(Model model, @PathVariable int invitationId, 
			@CookieValue(value = "cityId", required = false) Cookie cookie) {
		model.addAttribute("invitation", invitationService.get(invitationId));
		model.addAttribute("cityId", cookie.getValue());
		model.addAttribute("subjectGroups", subjectGroupService.getList());
		
		return "subject/group";
	}
	
	@GetMapping("list")
	public void list() {
		
	}
}
