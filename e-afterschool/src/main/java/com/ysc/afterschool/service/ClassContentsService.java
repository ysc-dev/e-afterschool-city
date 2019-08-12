package com.ysc.afterschool.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ysc.afterschool.domain.db.ClassContents;
import com.ysc.afterschool.repository.ClassContentsRepository;

@Service
public class ClassContentsService {

	@Autowired
	private ClassContentsRepository classContentsRepository;
	
	public List<ClassContents> getList(int subjectId) {
		return classContentsRepository.findBySubjectId(subjectId);
	}
}
