package com.ysc.afterschool.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ysc.afterschool.domain.db.Apply;
import com.ysc.afterschool.repository.ApplyRepository;
import com.ysc.afterschool.service.ApplyService;

@Transactional
@Service
public class ApplyServiceImpl implements ApplyService {

	@Autowired
	private ApplyRepository applyRepository;

	@Override
	public Apply get(Integer id) {
		return applyRepository.findById(id).get();
	}
	
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

	@Override
	public List<Apply> getList(int infoId, int studentId) {
		return applyRepository.findByInvitationIdAndStudentId(infoId, studentId);
	}
}
