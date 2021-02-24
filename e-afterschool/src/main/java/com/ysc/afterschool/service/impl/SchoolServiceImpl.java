package com.ysc.afterschool.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ysc.afterschool.domain.db.City;
import com.ysc.afterschool.domain.db.School;
import com.ysc.afterschool.repository.SchoolRepository;
import com.ysc.afterschool.service.CityService;
import com.ysc.afterschool.service.SchoolService;

@Transactional
@Service
public class SchoolServiceImpl implements SchoolService {

	@Autowired
	private SchoolRepository schoolRepository;
	
	@Autowired
	private CityService cityService;

	@Transactional(readOnly = true)
	@Override
	public School get(Integer id) {
		return schoolRepository.findById(id).get();
	}
	
	@Transactional(readOnly = true)
	@Override
	public List<School> getList() {
		return schoolRepository.findAll();
	}

	@Override
	public boolean regist(School domain) {
		if (isNew(domain)) {
			return schoolRepository.save(domain) != null;
		} else {
			return false;
		}	
	}

	@Override
	public boolean update(School domain) {
		if (!isNew(domain)) {
			return schoolRepository.save(domain) != null;
		} else {
			return false;
		}	
	}

	@Override
	public boolean delete(Integer id) {
		schoolRepository.deleteById(id);
		return true;
	}

	private boolean isNew(School domain) {
		return !schoolRepository.existsById(domain.getId());
	}

	@Override
	public School get(String name) {
		return schoolRepository.findByName(name);
	}

	@Override
	public List<School> getList(int cityId) {
		City city = cityService.get(cityId);
		return schoolRepository.findByCity(city.getName());
	}
}
