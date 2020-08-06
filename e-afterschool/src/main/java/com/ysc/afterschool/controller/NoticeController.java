package com.ysc.afterschool.controller;

import java.text.SimpleDateFormat;

import javax.servlet.http.Cookie;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ysc.afterschool.domain.db.Notice;
import com.ysc.afterschool.repository.UploadedFileRepository;
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
	
	@Autowired
	private UploadedFileRepository uploadedFileRepository;
	
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
	
	/**
	 * 전체 공지사항 상세보기 화면
	 * @param model
	 * @param infoId
	 * @param cookie
	 */
	@GetMapping("detail")
	public void detail(Model model, int infoId, int noticeId, @CookieValue(value = "cityId", required = false) Cookie cookie) {
		model.addAttribute("cityId", cookie.getValue());
		model.addAttribute("infoId", infoId);
		
		Notice notice = noticeService.get(noticeId);
		model.addAttribute("notice", notice);
		model.addAttribute("localDateTimeFormat", new SimpleDateFormat("yyyy-MM-dd'T'hh:mm"));
		
		notice.setHit(notice.getHit() + 1);
		noticeService.update(notice);
	}
	
	/**
	 * 공지사항 정보 가져오기
	 * @param id
	 * @return
	 */
	@GetMapping("get")
	public ResponseEntity<?> get(int id) {
		return new ResponseEntity<>(noticeService.get(id), HttpStatus.OK);
	}
	
	/**
	 * 공지사항 파일 가져오기
	 * @param id
	 * @return
	 */
	@GetMapping("get/file")
	public ResponseEntity<?> getFile(int id) {
		return new ResponseEntity<>(uploadedFileRepository.findById(id).get(), HttpStatus.OK);
	}
}
