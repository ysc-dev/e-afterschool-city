package com.ysc.afterschool.controller;

import javax.servlet.http.Cookie;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import com.ysc.afterschool.domain.db.Student;
import com.ysc.afterschool.service.InvitationService;

/**
 * 안내장 관리 컨트롤러 클래스
 * 
 * @author hgko
 *
 */
@Controller
public class InvitationController {
	
	@Autowired
	private InvitationService invitationService;
	
	@GetMapping("info")
	public String home(@CookieValue(value = "cityId", required = false) Cookie cookie) {
		return "info/" + cookie.getValue();
	}
	
	/**
	 * 안내장 목록 화면
	 * @param model
	 */
	@GetMapping("info/{cityId}")
	public String info(Model model, @PathVariable int cityId, @AuthenticationPrincipal Student student) {
		model.addAttribute("invitations", invitationService.getList(cityId));
		model.addAttribute("student", student);
		return "info";
	}
}
