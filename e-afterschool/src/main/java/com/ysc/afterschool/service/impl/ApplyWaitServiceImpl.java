package com.ysc.afterschool.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ysc.afterschool.domain.db.Apply.OrderType;
import com.ysc.afterschool.domain.db.ApplyWait;
import com.ysc.afterschool.repository.ApplyWaitRepository;
import com.ysc.afterschool.service.ApplyWaitService;

@Transactional
@Service
public class ApplyWaitServiceImpl implements ApplyWaitService {

	@Autowired
	private ApplyWaitRepository applyWaitRepository;

	@Override
	public ApplyWait get(Integer id) {
		return applyWaitRepository.findById(id).get();
	}
	
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

	@Override
	public boolean search(int infoId, int studentId, int subjectId) {
		return applyWaitRepository.findByInvitationIdAndStudentIdAndSubjectId(infoId, studentId, subjectId) != null;
	}

	@Override
	public ApplyWait get(int infoId, int subjectId, OrderType type) {
		if (type == OrderType.오름차순) {
			return applyWaitRepository.getAsc(infoId, subjectId, type.getName());
		} else {
			return applyWaitRepository.getDesc(infoId, subjectId, type.getName());
		}
	}
}