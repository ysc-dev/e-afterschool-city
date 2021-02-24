package com.ysc.afterschool.service;

import java.util.List;

import com.ysc.afterschool.domain.db.School;

public interface SchoolService extends CRUDService<School, Integer> {

	School get(String name);

	List<School> getList(int cityId);
}
