package com.ysc.afterschool.repository;

import java.util.List;

import com.ysc.afterschool.domain.db.SubjectGroup;

public interface SubjectGroupRepository extends DefaultRepository<SubjectGroup, Integer> {

	List<SubjectGroup> OrderBySequence();

}
