package com.ysc.afterschool.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import com.ysc.afterschool.domain.db.ClassContents;
import com.ysc.afterschool.repository.ClassContentsRepository;

@Service
public class ClassContentsService {

	@Autowired
	private ClassContentsRepository classContentsRepository;
	
	@Cacheable("classContents.getList")
	public List<ClassContents> getList(int subjectId) {
		return classContentsRepository.findBySubjectId(subjectId);
	}

	@Cacheable("classContents.get")
	public ClassContents get(int id) {
		return classContentsRepository.findById(id).get();
	}
}
