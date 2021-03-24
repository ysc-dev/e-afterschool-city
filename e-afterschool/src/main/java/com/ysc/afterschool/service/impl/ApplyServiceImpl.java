package com.ysc.afterschool.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ysc.afterschool.domain.db.Apply;
import com.ysc.afterschool.repository.ApplyRepository;
import com.ysc.afterschool.service.ApplyService;

/**
 * 수강 신청 관리
 * 
 * @author hgko
 *
 */
@Transactional
@Service
public class ApplyServiceImpl implements ApplyService {

	@Autowired
	private ApplyRepository applyRepository;

	@Transactional(readOnly = true)
	@Override
	public Apply get(Integer id) {
		return applyRepository.findById(id).get();
	}
	
	@Transactional(readOnly = true)
	@Override
	public List<Apply> getList() {
		return applyRepository.findAll();
	}

	@Override
	public boolean regist(Apply domain) {
		if (isNew(domain)) {
			return applyRepository.save(domain) != null;
		} else {
			return false;
		}	
	}

	@Override
	public boolean update(Apply domain) {
		if (!isNew(domain)) {
			return applyRepository.save(domain) != null;
		} else {
			return false;
		}	
	}

	@Override
	public boolean delete(Integer id) {
		applyRepository.deleteById(id);
		return true;
	}

	private boolean isNew(Apply domain) {
		return !applyRepository.existsById(domain.getId());
	}

	@Transactional(readOnly = true)
	@Override
	public List<Apply> getList(int infoId, int studentId) {
		return applyRepository.findByInvitationIdAndStudentId(infoId, studentId);
	}
	
	@Transactional(readOnly = true)
	@Override
	public List<Apply> getList(int invitationId) {
		return applyRepository.findByInvitationIdGroupByStudentId(invitationId);
	}

	@Transactional(readOnly = true)
	@Override
	public boolean search(int infoId, int studentId, int subjectId) {
		return applyRepository.findByInvitationIdAndStudentIdAndSubjectId(infoId, studentId, subjectId) != null;
	}

	@Transactional(readOnly = true)
	@Override
	public long count(int infoId, int studentId) {
		return applyRepository.findCountByInvitationIdAndStudentId(infoId, studentId);
	}
}
