package com.ysc.afterschool.controller;

import javax.servlet.http.Cookie;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ysc.afterschool.service.NoticeService;

/**
 * 공지사항 관리 컨트롤러 클래스
 * 
 * @author hgko
 *
 */
@Controller
@RequestMapping("notice")
public class NoticeController {
	
	@Autowired
	private NoticeService noticeService;
	
	/**
	 * 전체 공지사항 화면
	 * @param model
	 * @param infoId
	 * @param cookie
	 */
	@GetMapping("list")
	public void list(Model model, int infoId, @CookieValue(value = "cityId", required = false) Cookie cookie) {
		model.addAttribute("cityId", cookie.getValue());
		model.addAttribute("infoId", infoId);
		model.addAttribute("notices", noticeService.getList(Integer.parseInt(cookie.getValue())));
	}
}
