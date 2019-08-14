package com.ysc.afterschool.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ysc.afterschool.domain.db.SubjectNotice;
import com.ysc.afterschool.repository.SubjectNoticeRepository;
import com.ysc.afterschool.service.SubjectNoticeService;

@Transactional
@Service
public class SubjectNoticeServiceImpl implements SubjectNoticeService {

	@Autowired
	private SubjectNoticeRepository subjectNoticeRepository;

	@Override
	public SubjectNotice get(Integer id) {
		return subjectNoticeRepository.findById(id).get();
	}
	
	@Override
	public List<SubjectNotice> getList() {
		return subjectNoticeRepository.findAll();
	}

	@Override
	public boolean regist(SubjectNotice domain) {
		if (isNew(domain)) {
			return subjectNoticeRepository.save(domain) != null;
		} else {
			return false;
		}	
	}

	@Override
	public boolean update(SubjectNotice domain) {
		if (!isNew(domain)) {
			return subjectNoticeRepository.save(domain) != null;
		} else {
			return false;
		}	
	}

	@Override
	public boolean delete(Integer id) {
		subjectNoticeRepository.deleteById(id);
		return true;
	}

	private boolean isNew(SubjectNotice domain) {
		return !subjectNoticeRepository.existsById(domain.getId());
	}

	@Override
	public List<SubjectNotice> getList(int subjectId) {
		return subjectNoticeRepository.findBySubjectId(subjectId);
	}
}
