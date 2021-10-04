package com.ysc.afterschool.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ysc.afterschool.domain.db.Invitation;
import com.ysc.afterschool.domain.db.Subject;
import com.ysc.afterschool.repository.InvitationRepository;
import com.ysc.afterschool.repository.SubjectRepository;
import com.ysc.afterschool.service.SubjectService;

/**
 * 과목 관리
 * 
 * @author hgko
 *
 */
@Transactional
@Service
public class SubjectServiceImpl implements SubjectService {

	@Autowired
	private SubjectRepository subjectRepository;

	@Autowired
	private InvitationRepository invitationRepository;

	@Transactional(readOnly = true)
	@Override
	public Subject get(Integer id) {
		return subjectRepository.findById(id).get();
	}

	@Transactional(readOnly = true)
	@Override
	public List<Subject> getList() {
		return subjectRepository.findAll();
	}

	@Override
	public boolean regist(Subject domain) {
		if (isNew(domain)) {
			return subjectRepository.save(domain) != null;
		} else {
			return false;
		}
	}

	@Override
	public boolean update(Subject domain) {
		if (!isNew(domain)) {
			return subjectRepository.save(domain) != null;
		} else {
			return false;
		}
	}

	@Override
	public boolean delete(Integer id) {
		subjectRepository.deleteById(id);
		return true;
	}

	private boolean isNew(Subject domain) {
		return !subjectRepository.existsById(domain.getId());
	}

	@Transactional(readOnly = true)
	@Override
	public List<Subject> getList(int subjectGroupId) {
		return subjectRepository.findBySubjectGroupId(subjectGroupId);
	}

	@Transactional(readOnly = true)
	@Override
	public List<Subject> getList(int infoId, int groupId) {
		return subjectRepository.findByInvitationIdAndSubjectGroupId(infoId, groupId);
	}

	@Transactional(readOnly = true)
	@Override
	public List<Subject> getListFromCity(int cityId) {

		List<Subject> subjects = new ArrayList<>();

		for (Invitation invitation : invitationRepository.findByCityIdAndAddType(cityId, false)) {
			subjects.addAll(subjectRepository.findByInvitationId(invitation.getId()));
		}

		return subjects;
	}
}
