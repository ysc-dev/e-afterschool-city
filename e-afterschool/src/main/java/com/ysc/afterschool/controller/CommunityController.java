package com.ysc.afterschool.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.ysc.afterschool.domain.CommonFile;
import com.ysc.afterschool.domain.db.Student;
import com.ysc.afterschool.domain.db.SubjectNotice;
import com.ysc.afterschool.domain.db.SubjectNoticeFile;
import com.ysc.afterschool.service.CityService;
import com.ysc.afterschool.service.CommentService;
import com.ysc.afterschool.service.SubjectNoticeService;
import com.ysc.afterschool.service.SubjectService;
import com.ysc.afterschool.service.impl.FileUploadService;

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
	private CityService cityService;

	@Autowired
	private SubjectService subjectService;

	@Autowired
	private SubjectNoticeService subjectNoticeService;

	@Autowired
	private CommentService commentService;

	@Autowired
	private FileUploadService fileUploadService;

	/**
	 * 커뮤니티 화면
	 * 
	 * @param model
	 * @param cityId
	 * @param infoId
	 * @param subjectId
	 */
	@GetMapping("list/{cityId}/{infoId}/{subjectId}")
	public String list(Model model, 
			@PathVariable("cityId") int cityId, 
			@PathVariable("infoId") int infoId, 
			@PathVariable("subjectId") int subjectId) {

		model.addAttribute("city", cityService.get(cityId));
		model.addAttribute("infoId", infoId);
		model.addAttribute("subject", subjectService.get(subjectId));
		model.addAttribute("subjectNotices", subjectNoticeService.getList(subjectId));
		
		return "subject/community/list";
	}

	/**
	 * 글 등록 화면
	 * 
	 * @param model
	 * @param cityId
	 * @param infoId
	 * @param subjectId
	 * @return
	 */
	@GetMapping("regist/{cityId}/{infoId}/{subjectId}")
	public String regist(Model model, 
			@PathVariable("cityId") int cityId, 
			@PathVariable("infoId") int infoId, 
			@PathVariable("subjectId") int subjectId) {

		model.addAttribute("city", cityService.get(cityId));
		model.addAttribute("infoId", infoId);
		model.addAttribute("subject", subjectService.get(subjectId));
		
		return "subject/community/regist";
	}

	/**
	 * 글 등록 기능
	 * 
	 * @param subjectNotice
	 * @param authentication
	 * @return
	 */
	@PostMapping("regist")
	@ResponseBody
	public ResponseEntity<?> notice(SubjectNotice subjectNotice, Authentication authentication) {

		List<SubjectNoticeFile> uploadedFiles = new ArrayList<>();

		for (MultipartFile file : subjectNotice.getFiles()) {
			String fileName = file.getOriginalFilename();

			if (!fileName.isEmpty()) {
				CommonFile commonFile = fileUploadService.restore(file, CommonFile.COMMUNITY_PATH);

				SubjectNoticeFile uploadedFile = new SubjectNoticeFile(commonFile);
				uploadedFile.setSubjectNotice(subjectNotice);

				uploadedFiles.add(uploadedFile);
			}
		}

		Student student = (Student) authentication.getPrincipal();
		subjectNotice.setUserId(student.getId());
		subjectNotice.setUserName(student.getName());
		subjectNotice.setUploadedFiles(uploadedFiles);

		if (subjectNoticeService.regist(subjectNotice)) {
			return new ResponseEntity<>(HttpStatus.OK);
		}

		return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
	}

	/**
	 * 커뮤니티 상세보기 화면
	 * 
	 * @param model
	 * @param infoId
	 * @param id
	 * @param cookie
	 */
	@GetMapping("detail/{cityId}/{infoId}/{subjectId}/{noticeId}")
	public String detail(Model model, 
			@PathVariable("cityId") int cityId, 
			@PathVariable("infoId") int infoId, 
			@PathVariable("subjectId") int subjectId,
			@PathVariable("noticeId") int noticeId) {

		model.addAttribute("city", cityService.get(cityId));
		model.addAttribute("infoId", infoId);
		model.addAttribute("subjectId", subjectId);

		SubjectNotice notice = subjectNoticeService.get(noticeId);
		model.addAttribute("localDateTimeFormat", new SimpleDateFormat("yyyy-MM-dd'T'hh:mm:ss"));
		model.addAttribute("notice", notice);
		model.addAttribute("comments", commentService.getList(noticeId));

		if (notice != null) {
			notice.setHit(notice.getHit() + 1);
			subjectNoticeService.update(notice);
		}
		
		return "subject/community/detail";
	}

	/**
	 * 정보 삭제
	 * 
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

	/**
	 * 파일 조회
	 * 
	 * @param id
	 * @return
	 */
	@GetMapping("file/get")
	public ResponseEntity<?> getFile(int id) {
		return new ResponseEntity<>(subjectNoticeService.get(id), HttpStatus.OK);
	}
}
