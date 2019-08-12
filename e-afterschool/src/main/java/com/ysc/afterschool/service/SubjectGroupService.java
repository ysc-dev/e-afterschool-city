package com.ysc.afterschool.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ysc.afterschool.domain.db.SubjectGroup;
import com.ysc.afterschool.repository.SubjectGroupRepository;

@Service
public class SubjectGroupService {

	@Autowired
	private SubjectGroupRepository subjectGroupRepository;
	
	public List<SubjectGroup> getList() {
		return subjectGroupRepository.findAll();
	}

	public SubjectGroup get(int id) {
		return subjectGroupRepository.findById(id).get();
	}
}
