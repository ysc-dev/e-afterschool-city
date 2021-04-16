package com.ysc.afterschool.service;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ysc.afterschool.domain.db.SubjectGroup;
import com.ysc.afterschool.repository.SubjectGroupRepository;
import com.ysc.afterschool.repository.SubjectRepository;

@Service
@Transactional
public class SubjectGroupService {

	@Autowired
	private SubjectGroupRepository subjectGroupRepository;
	
	@Autowired
	private SubjectRepository subjectRepository;
	
	@Transactional(readOnly = true)
	public List<SubjectGroup> getList() {
		return subjectGroupRepository.findAll();
	}

	@Transactional(readOnly = true)
	public SubjectGroup get(int id) {
		return subjectGroupRepository.findById(id).get();
	}

	@Transactional(readOnly = true)
	public List<SubjectGroup> getList(int infoId) {
		return subjectGroupRepository.OrderBySequence().stream().map(data -> {
			data.setSubjects(subjectRepository.countByInvitationIdAndSubjectGroupId(infoId, data.getId()));
			return data;
		}).filter(data -> data.getSubjects() > 0).collect(Collectors.toList());
	}
}
