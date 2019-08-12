package com.ysc.afterschool.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ysc.afterschool.domain.db.Apply;
import com.ysc.afterschool.domain.db.Student;
import com.ysc.afterschool.domain.db.Subject;
import com.ysc.afterschool.service.ApplyService;
import com.ysc.afterschool.service.SubjectService;

@Controller
@RequestMapping("apply")
public class ApplyController {

	@Autowired
	private ApplyService applyService;
	
	@Autowired
	private SubjectService subjectService;
	
	/**
	 * 수강 신청 기능
	 * @param subjectId
	 * @param authentication
	 * @return
	 */
	@PostMapping("regist")
	public ResponseEntity<?> regist(int infoId, int subjectId, Authentication authentication) {
		Student student = (Student) authentication.getPrincipal();
		
		List<Apply> applies = applyService.getList(infoId, student.getId());
		if (applies.size() == 2) {
			return new ResponseEntity<String>("한 학생이 최대 2개 강좌까지<br> 신청 할 수 있습니다.", HttpStatus.BAD_REQUEST);
		}
		
		Subject subject = subjectService.get(subjectId);
		if (subject.getFixedNumber() <= subject.getApplyNumber()) {
			return new ResponseEntity<String>("정원 초과입니다.", HttpStatus.BAD_REQUEST);
		}
		
		if (applyService.regist(new Apply(infoId, student, subject))) {
			subject.setApplyNumber(subject.getApplyNumber() + 1);
			if (subjectService.update(subject)) {
				return new ResponseEntity<>(HttpStatus.OK);
			}
		}
		
		return new ResponseEntity<String>("수강신청 실패하였습니다.", HttpStatus.BAD_REQUEST);
	}
}
