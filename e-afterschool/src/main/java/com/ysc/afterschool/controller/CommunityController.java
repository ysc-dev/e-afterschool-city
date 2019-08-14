package com.ysc.afterschool.controller;

import java.text.SimpleDateFormat;

import javax.servlet.http.Cookie;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ysc.afterschool.domain.db.SubjectNotice;
import com.ysc.afterschool.service.CommentService;
import com.ysc.afterschool.service.SubjectNoticeService;
import com.ysc.afterschool.service.SubjectService;

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
}
