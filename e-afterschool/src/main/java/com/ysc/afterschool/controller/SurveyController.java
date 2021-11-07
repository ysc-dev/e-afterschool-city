package com.ysc.afterschool.controller;

import java.util.ArrayList;
import java.util.List;

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
import com.ysc.afterschool.domain.db.Survey.SurveyType;
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
	 * 만족도 조사 및 설문조사 화면(학생용)
	 * 
	 * @param model
	 * @param cityId
	 */
	@GetMapping("student")
	private void student(Model model, int cityId) {
		model.addAttribute("city", cityService.get(cityId));
		model.addAttribute("cityId", cityId);
		model.addAttribute("subjects", subjectService.getListFromCity(cityId));
	}

	/**
	 * 만족도 조사 및 설문조사 화면(학부모용)
	 * 
	 * @param model
	 * @param cityId
	 */
	@GetMapping("parents")
	private void parents(Model model, int cityId) {
		model.addAttribute("city", cityService.get(cityId));
		model.addAttribute("cityId", cityId);
		model.addAttribute("subjects", subjectService.getListFromCity(cityId));
	}

	/**
	 * 설문 등록 기능(학생용)
	 * 
	 * @param survey
	 * @return
	 */
	@PostMapping("regist/student")
	@ResponseBody
	public ResponseEntity<?> registStudent(Survey survey) {

		survey.setSurveyType(SurveyType.Student);
		
		List<String> subjects = new ArrayList<String>();
		
		if (!survey.getSubject1().isEmpty()) {
			subjects.add(survey.getSubject1());
		}
		if (!survey.getSubject2().isEmpty()) {
			subjects.add(survey.getSubject2());
		}
		if (!survey.getSubject3().isEmpty()) {
			subjects.add(survey.getSubject3());
		}
		
		if (subjects.size() > 0) {
			survey.setSubjects(String.join(",", subjects));
		}

		if (surveyService.regist(survey)) {
			return new ResponseEntity<>(HttpStatus.OK);
		}

		return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
	}

	/**
	 * 설문 등록 기능(학부모용)
	 * 
	 * @param survey
	 * @return
	 */
	@PostMapping("regist/parents")
	@ResponseBody
	public ResponseEntity<?> registParents(Survey survey) {
		
		survey.setSurveyType(SurveyType.Parents);
		
		List<String> subjects = new ArrayList<String>();
		
		if (!survey.getSubject1().isEmpty()) {
			subjects.add(survey.getSubject1());
		}
		if (!survey.getSubject2().isEmpty()) {
			subjects.add(survey.getSubject2());
		}
		if (!survey.getSubject3().isEmpty()) {
			subjects.add(survey.getSubject3());
		}
		
		if (subjects.size() > 0) {
			survey.setSubjects(String.join(",", subjects));
		}

		if (surveyService.regist(survey)) {
			return new ResponseEntity<>(HttpStatus.OK);
		}

		return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
	}
}
