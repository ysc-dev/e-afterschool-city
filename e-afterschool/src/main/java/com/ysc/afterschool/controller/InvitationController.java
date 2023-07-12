package com.ysc.afterschool.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ysc.afterschool.domain.db.Student;
import com.ysc.afterschool.service.CityService;
import com.ysc.afterschool.service.InvitationService;

import reactor.core.publisher.Mono;

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
	
	@Autowired
	private CityService cityService;

	/**
	 * 안내장 목록 화면
	 * 
	 * @param model
	 * @param cityId
	 * @param student
	 * @param cookie
	 */
	@GetMapping("info")
	public void info(Model model, int cityId, @AuthenticationPrincipal Student student) {
		
		model.addAttribute("invitations", invitationService.getList(cityId).collectList().block());
		model.addAttribute("city", cityService.get(cityId));
		model.addAttribute("student", student);
	}

	/**
	 * 안내장 목록 화면
	 * 
	 * @param id
	 */
	@GetMapping("info/get")
	@ResponseBody
	public Mono<ResponseEntity<?>> get(int id) {
		return Mono.just(new ResponseEntity<>(invitationService.get(id), HttpStatus.OK));
	}
}
