package com.ysc.afterschool.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ysc.afterschool.domain.db.City;
import com.ysc.afterschool.repository.CityRepository;

@Service
public class CityService {
	
	@Autowired
	private CityRepository cityRepository;

	public City get(String link) {
		return cityRepository.findByLink(link);
	}
	
	public List<City> getList() {
		return cityRepository.findAll();
	}
}
