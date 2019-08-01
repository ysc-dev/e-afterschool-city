package com.ysc.afterschool.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ysc.afterschool.domain.db.Student;

/**
 * 학생 관리 컨트롤러 클래스
 * 
 * @author hgko
 *
 */
@Controller
@RequestMapping("student")
public class StudentController {

	/**
	 * 학생 등록 화면
	 * @param model
	 */
	@GetMapping("regist")
	public void regist(Model model) { 
		
	}
	
	/**
	 * 학생 등록 기능
	 * @param student
	 */
	@PostMapping(value = "regist")
	@ResponseBody
	public ResponseEntity<?> regist(Student student) {
		
		return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
	}
}
