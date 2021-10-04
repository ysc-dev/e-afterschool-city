package com.ysc.afterschool.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ysc.afterschool.domain.db.Notice;
import com.ysc.afterschool.repository.NoticeRepository;
import com.ysc.afterschool.service.CityService;
import com.ysc.afterschool.service.NoticeService;

/**
 * 공지사항 관리
 * 
 * @author hgko
 *
 */
@Transactional
@Service
public class NoticeServiceImpl implements NoticeService {

	@Autowired
	private NoticeRepository noticeRepository;

	@Autowired
	private CityService cityService;

	@Transactional(readOnly = true)
	@Override
	public Notice get(Integer id) {
		return noticeRepository.findById(id).get();
	}

	@Transactional(readOnly = true)
	@Override
	public List<Notice> getList() {
		return noticeRepository.findAll();
	}

	@Override
	public boolean regist(Notice domain) {
		if (isNew(domain)) {
			return noticeRepository.save(domain) != null;
		} else {
			return false;
		}
	}

	@Override
	public boolean update(Notice domain) {
		if (!isNew(domain)) {
			return noticeRepository.save(domain) != null;
		} else {
			return false;
		}
	}

	@Override
	public boolean delete(Integer id) {
		noticeRepository.deleteById(id);
		return true;
	}

	private boolean isNew(Notice domain) {
		return !noticeRepository.existsById(domain.getId());
	}

	@Transactional(readOnly = true)
	@Override
	public List<Notice> getList(int cityId) {
		return noticeRepository.findByCityOrderByCreateDateDesc(cityService.get(cityId).getName());
	}
}
