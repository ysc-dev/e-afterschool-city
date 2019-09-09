package com.ysc.afterschool.controller;

import javax.servlet.http.Cookie;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ysc.afterschool.service.ClassContentsService;
import com.ysc.afterschool.service.SubjectService;

@Controller
@RequestMapping("subject/class")
public class ClassContentsController {
	
	@Autowired
	private SubjectService subjectService;
	
	@Autowired
	private ClassContentsService classContentsService;
	
	/**
	 * 횟수별 수업내용 화면
	 * @param model
	 * @param infoId
	 * @param id
	 * @param cookie
	 */
	@GetMapping("")
	public void classView(Model model, int infoId, int id, @CookieValue(value = "cityId", required = false) Cookie cookie) {
		model.addAttribute("cityId", cookie.getValue());
		model.addAttribute("infoId", infoId);
		model.addAttribute("subject", subjectService.get(id));
		model.addAttribute("classContents", classContentsService.getList(id));
	}
	
	@GetMapping("file/get")
	public ResponseEntity<?> getFile(int id) {
		return new ResponseEntity<>(classContentsService.get(id), HttpStatus.OK);
	}
}
