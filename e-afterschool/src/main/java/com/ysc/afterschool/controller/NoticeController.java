package com.ysc.afterschool.controller;

import java.text.SimpleDateFormat;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ysc.afterschool.domain.db.Notice;
import com.ysc.afterschool.repository.UploadedFileRepository;
import com.ysc.afterschool.service.CityService;
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
	private CityService cityService;

	@Autowired
	private NoticeService noticeService;

	@Autowired
	private UploadedFileRepository uploadedFileRepository;

	/**
	 * 전체 공지사항 화면
	 * 
	 * @param model
	 * @param cityId
	 * @param infoId
	 * @return
	 */
	@GetMapping("list/{cityId}/{infoId}")
	public String list(Model model, @PathVariable("cityId") int cityId, @PathVariable("infoId") int infoId) {

		model.addAttribute("city", cityService.get(cityId));
		model.addAttribute("infoId", infoId);
		model.addAttribute("notices", noticeService.getList(cityId));
		
		return "notice/list";
	}

	/**
	 * 전체 공지사항 상세보기 화면
	 * 
	 * @param model
	 * @param cityId
	 * @param infoId
	 * @param noticeId
	 */
	@GetMapping("detail/{cityId}/{infoId}/{noticeId}")
	public void detail(Model model, @PathVariable("cityId") int cityId, @PathVariable("infoId") int infoId,
			@PathVariable("noticeId") int noticeId) {

		model.addAttribute("city", cityService.get(cityId));
		model.addAttribute("infoId", infoId);

		Notice notice = noticeService.get(noticeId);
		model.addAttribute("notice", notice);
		model.addAttribute("localDateTimeFormat", new SimpleDateFormat("yyyy-MM-dd'T'hh:mm"));

		if (notice != null) {
			notice.setHit(notice.getHit() + 1);
			noticeService.update(notice);
		}
	}

	/**
	 * 공지사항 정보 가져오기
	 * 
	 * @param id
	 * @return
	 */
	@GetMapping("get")
	public ResponseEntity<?> get(int id) {
		return new ResponseEntity<>(noticeService.get(id), HttpStatus.OK);
	}

	/**
	 * 공지사항 파일 가져오기
	 * 
	 * @param id
	 * @return
	 */
	@GetMapping("get/file")
	public ResponseEntity<?> getFile(int id) {
		return new ResponseEntity<>(uploadedFileRepository.findById(id).get(), HttpStatus.OK);
	}
}
