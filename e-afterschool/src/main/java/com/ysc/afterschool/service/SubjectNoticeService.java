package com.ysc.afterschool.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ysc.afterschool.domain.db.SubjectNotice;
import com.ysc.afterschool.repository.SubjectNoticeRepository;

@Service
public class SubjectNoticeService {

	@Autowired
	private SubjectNoticeRepository subjectNoticeRepository;
	
	public List<SubjectNotice> getList(int subjectId) {
		return subjectNoticeRepository.findBySubjectId(subjectId);
	}
}
