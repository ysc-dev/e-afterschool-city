package com.ysc.afterschool.repository;

import com.ysc.afterschool.domain.db.School;

public interface SchoolRepository extends DefaultRepository<School, Integer> {

	School findByName(String name);

}
