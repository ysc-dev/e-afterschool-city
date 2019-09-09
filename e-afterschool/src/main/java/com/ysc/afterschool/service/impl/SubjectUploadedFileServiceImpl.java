package com.ysc.afterschool.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ysc.afterschool.domain.db.SubjectUploadedFile;
import com.ysc.afterschool.repository.SubjectUploadedFileRepository;
import com.ysc.afterschool.service.SubjectUploadedFileService;

@Transactional
@Service
public class SubjectUploadedFileServiceImpl implements SubjectUploadedFileService {
	
	@Autowired
	private SubjectUploadedFileRepository subjectUploadedFileRepository;

	@Override
	public SubjectUploadedFile get(Integer id) {
		return subjectUploadedFileRepository.findById(id).get();
	}

	@Transactional(readOnly = true)
	@Cacheable("subjectUploadedFile.list")
	@Override
	public List<SubjectUploadedFile> getList() {
		return subjectUploadedFileRepository.findAll();
	}

	@Override
	public boolean regist(SubjectUploadedFile domain) {
		if (isNew(domain)) {
			return subjectUploadedFileRepository.save(domain) != null;
		} else {
			return false;
		}	
	}

	@Override
	public boolean update(SubjectUploadedFile domain) {
		if (!isNew(domain)) {
			return subjectUploadedFileRepository.save(domain) != null;
		} else {
			return false;
		}	
	}

	@Override
	public boolean delete(Integer id) {
		subjectUploadedFileRepository.deleteById(id);
		return true;
	}

	private boolean isNew(SubjectUploadedFile domain) {
		return !subjectUploadedFileRepository.existsById(domain.getId());
	}

	@Override
	public List<SubjectUploadedFile> getList(int classId) {
		return subjectUploadedFileRepository.findByClassContentsId(classId);
	}
}
