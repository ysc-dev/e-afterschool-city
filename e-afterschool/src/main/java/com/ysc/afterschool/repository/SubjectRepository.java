package com.ysc.afterschool.repository;

import java.util.List;

import com.ysc.afterschool.domain.db.Subject;

public interface SubjectRepository extends DefaultRepository<Subject, Integer> {

	List<Subject> findBySubjectGroupId(int subjectGroupId);

}