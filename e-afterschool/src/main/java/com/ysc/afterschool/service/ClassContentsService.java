package com.ysc.afterschool.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ysc.afterschool.domain.db.ClassContents;
import com.ysc.afterschool.repository.ClassContentsRepository;

@Transactional
@Service
public class ClassContentsService {

	@Autowired
	private ClassContentsRepository classContentsRepository;
	
	@Transactional(readOnly = true)
	public List<ClassContents> getList(int subjectId) {
		return classContentsRepository.findBySubjectId(subjectId);
	}

	@Transactional(readOnly = true)
	public ClassContents get(int id) {
		return classContentsRepository.findById(id).get();
	}
}
