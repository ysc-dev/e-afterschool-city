package com.ysc.afterschool.repository;

import com.ysc.afterschool.domain.db.City;

public interface CityRepository extends DefaultRepository<City, Integer> {

	City findByLink(String link);

}
