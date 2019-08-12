package com.ysc.afterschool.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ysc.afterschool.domain.db.Notice;
import com.ysc.afterschool.repository.NoticeRepository;

@Service
public class NoticeService {

	@Autowired
	private NoticeRepository noticeRepository;
	
	@Autowired
	private CityService cityService;
	
	public List<Notice> getList(int cityId) {
		return noticeRepository.findByCity(cityService.get(cityId).getName());
	}
}
