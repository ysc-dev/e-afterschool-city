package com.ysc.afterschool.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ysc.afterschool.domain.db.Apply.OrderType;
import com.ysc.afterschool.domain.db.ApplyWait;
import com.ysc.afterschool.repository.ApplyWaitRepository;
import com.ysc.afterschool.service.ApplyWaitService;

/**
 * 수강 대기 관리
 * 
 * @author hgko
 *
 */
@Transactional
@Service
public class ApplyWaitServiceImpl implements ApplyWaitService {

	@Autowired
	private ApplyWaitRepository applyWaitRepository;

	@Transactional(readOnly = true)
	@Override
	public ApplyWait get(Integer id) {
		return applyWaitRepository.findById(id).get();
	}

	@Transactional(readOnly = true)
	@Override
	public List<ApplyWait> getList() {
		return applyWaitRepository.findAll();
	}

	@Override
	public boolean regist(ApplyWait domain) {
		if (isNew(domain)) {
			return applyWaitRepository.save(domain) != null;
		} else {
			return false;
		}
	}

	@Override
	public boolean update(ApplyWait domain) {
		if (!isNew(domain)) {
			return applyWaitRepository.save(domain) != null;
		} else {
			return false;
		}
	}

	@Override
	public boolean delete(Integer id) {
		applyWaitRepository.deleteById(id);
		return true;
	}

	private boolean isNew(ApplyWait domain) {
		return !applyWaitRepository.existsById(domain.getId());
	}

	@Transactional(readOnly = true)
	@Override
	public boolean search(int infoId, int studentId, int subjectId) {
		return applyWaitRepository.findByInvitationIdAndStudentIdAndSubjectId(infoId, studentId, subjectId) != null;
	}

	@Transactional(readOnly = true)
	@Override
	public ApplyWait get(int infoId, int subjectId, OrderType type) {
		if (type == OrderType.오름차순) {
			return applyWaitRepository.getAsc(infoId, subjectId, type.getName());
		} else {
			return applyWaitRepository.getDesc(infoId, subjectId, type.getName());
		}
	}

	@Transactional(readOnly = true)
	@Override
	public List<ApplyWait> getList(int subjectId) {
		return applyWaitRepository.findBySubjectId(subjectId);
	}

	/**
	 * 안내장으로 조회
	 */
	@Transactional(readOnly = true)
	@Override
	public List<ApplyWait> getGroupList(int invitationId) {
		return applyWaitRepository.findByInvitationIdGroupByStudentId(invitationId);
	}
	
	/**
	 * 안내장, 학생을 통해 조회
	 */
	@Transactional(readOnly = true)
	@Override
	public List<ApplyWait> getList(int infoId, int studentId) {
		return applyWaitRepository.findByInvitationIdAndStudentId(infoId, studentId);
	}
}
