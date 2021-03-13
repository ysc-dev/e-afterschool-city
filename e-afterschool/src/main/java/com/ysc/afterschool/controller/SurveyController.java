package com.ysc.afterschool.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ysc.afterschool.domain.db.Survey;
import com.ysc.afterschool.service.CityService;
import com.ysc.afterschool.service.SubjectService;
import com.ysc.afterschool.service.SurveyService;

/**
 * 만족도 조사 및 설문조사 컨트롤러 클래스
 * 
 * @author hgko
 *
 */
@Controller
@RequestMapping("survey")
public class SurveyController {
	
	@Autowired
	private CityService cityService;
	
	@Autowired
	private SubjectService subjectService;
	
	@Autowired
	private SurveyService surveyService;

	/**
	 * 만족도 조사 및 설문조사 화면
	 * 
	 * @param model
	 * @param cityId
	 */
	@GetMapping("regist")
	private void info(Model model, int cityId) {
		model.addAttribute("city", cityService.get(cityId));
		model.addAttribute("cityId", cityId);
		model.addAttribute("subjects", subjectService.getListFromCity(cityId));
	}
	
	/**
	 * 설문 등록 기능
	 * @param survey
	 * @return
	 */
	@PostMapping(value = "regist")
	@ResponseBody
	public ResponseEntity<?> regist(Survey survey) {
		
		if (surveyService.regist(survey)) {
			return new ResponseEntity<>(HttpStatus.OK);
		}
		
		return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
	}
}
