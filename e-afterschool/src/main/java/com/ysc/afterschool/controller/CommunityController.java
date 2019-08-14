package com.ysc.afterschool.controller;

import java.text.SimpleDateFormat;

import javax.servlet.http.Cookie;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ysc.afterschool.domain.db.Student;
import com.ysc.afterschool.domain.db.SubjectNotice;
import com.ysc.afterschool.service.CommentService;
import com.ysc.afterschool.service.SubjectNoticeService;
import com.ysc.afterschool.service.SubjectService;

/**
 * 커뮤니티 관리 컨트롤러
 * 
 * @author hgko
 *
 */
@Controller
@RequestMapping("subject/community")
public class CommunityController {

	@Autowired
	private SubjectService subjectService;
	
	@Autowired
	private SubjectNoticeService subjectNoticeService;
	
	@Autowired
	private CommentService commentService;
	
	/**
	 * 커뮤니티 화면
	 * @param model
	 * @param infoId
	 * @param id
	 * @param cookie
	 */
	@GetMapping("list")
	public void list(Model model, int infoId, int id, @CookieValue(value = "cityId", required = false) Cookie cookie) {
		model.addAttribute("cityId", cookie.getValue());
		model.addAttribute("infoId", infoId);
		model.addAttribute("subject", subjectService.get(id));
		model.addAttribute("subjectNotices", subjectNoticeService.getList(id));
	}
	
	/**
	 * 글 등록 화면
	 * @param model
	 * @param infoId
	 * @param id
	 * @param cookie
	 */
	@GetMapping("regist")
	public void regist(Model model, int infoId, int subjectId, @CookieValue(value = "cityId", required = false) Cookie cookie) {
		model.addAttribute("cityId", cookie.getValue());
		model.addAttribute("infoId", infoId);
		model.addAttribute("subject", subjectService.get(subjectId));
	}
	
	/**
	 * 글 등록 기능
	 * @param subjectNotice
	 * @param authentication
	 * @return
	 */
	@PostMapping("regist")
	@ResponseBody
	public ResponseEntity<?> notice(SubjectNotice subjectNotice, Authentication authentication) {
		Student student = (Student) authentication.getPrincipal();
		subjectNotice.setUserId(student.getId());
		subjectNotice.setUserName(student.getName());
		
		if (subjectNoticeService.regist(subjectNotice)) {
			return new ResponseEntity<>(HttpStatus.OK);
		}
		
		return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
	}
	
	/**
	 * 커뮤니티 상세보기 화면
	 * @param model
	 * @param infoId
	 * @param id
	 * @param cookie
	 */
	@GetMapping("detail")
	public void detail(Model model, int infoId, int subjectId, int id, @CookieValue(value = "cityId", required = false) Cookie cookie) {
		model.addAttribute("cityId", cookie.getValue());
		model.addAttribute("infoId", infoId);
		model.addAttribute("subjectId", subjectId);
		
		SubjectNotice notice = subjectNoticeService.get(id);
		model.addAttribute("localDateTimeFormat", new SimpleDateFormat("yyyy-MM-dd'T'hh:mm:ss"));
		model.addAttribute("notice", notice);
		model.addAttribute("comments", commentService.getList(id));
		
		notice.setHit(notice.getHit() + 1);
		subjectNoticeService.update(notice);
	}
	
	/**
	 * 정보 삭제
	 * @param id
	 * @return
	 */
	@DeleteMapping("delete")
	@ResponseBody
	public ResponseEntity<?> delete(int id) {
		if (subjectNoticeService.delete(id)) {
			return new ResponseEntity<>(HttpStatus.OK);
		}
		
		return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
	}
}
