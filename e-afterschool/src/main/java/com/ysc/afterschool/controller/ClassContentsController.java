package com.ysc.afterschool.controller;

import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ysc.afterschool.domain.db.SubjectUploadedFile;
import com.ysc.afterschool.domain.db.SubjectUploadedFile.FileType;
import com.ysc.afterschool.service.CityService;
import com.ysc.afterschool.service.ClassContentsService;
import com.ysc.afterschool.service.SubjectService;

/**
 * 횟수별 수업내용
 * 
 * @author hgko
 *
 */
@Controller
@RequestMapping("subject/class")
public class ClassContentsController {
	
	@Autowired
	private CityService cityService;

	@Autowired
	private SubjectService subjectService;

	@Autowired
	private ClassContentsService classContentsService;

	/**
	 * 횟수별 수업내용 화면
	 * 
	 * @param model
	 * @param infoId
	 * @param id
	 * @param cookie
	 */
	@GetMapping("{cityId}/{infoId}/{subjectId}")
	public String classView(Model model, 
			@PathVariable("cityId") int cityId, 
			@PathVariable("infoId") int infoId, 
			@PathVariable("subjectId") int subjectId) {

		model.addAttribute("city", cityService.get(cityId));
		model.addAttribute("infoId", infoId);
		model.addAttribute("subject", subjectService.get(subjectId));

		model.addAttribute("classContents", classContentsService.getList(subjectId).stream().map(data -> {
			String fileType = "";
			for (SubjectUploadedFile file : data.getUploadedFiles()) {
				if (file.getFileType() == FileType.IMAGE || file.getFileType() == FileType.VIDEO) {
					fileType = "IMAGE";
				}
			}

			data.setFileType(fileType);
			return data;
		}).collect(Collectors.toList()));
		
		return "subject/class";
	}

	/**
	 * 파일 조회
	 * 
	 * @param id
	 * @return
	 */
	@GetMapping("file/get")
	public ResponseEntity<?> getFile(int id) {
		return new ResponseEntity<>(classContentsService.get(id), HttpStatus.OK);
	}
}
