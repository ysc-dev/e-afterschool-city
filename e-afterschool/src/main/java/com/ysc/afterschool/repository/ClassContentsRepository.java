package com.ysc.afterschool.repository;

import java.util.List;

import com.ysc.afterschool.domain.db.ClassContents;

public interface ClassContentsRepository extends DefaultRepository<ClassContents, Integer> {

	List<ClassContents> findBySubjectId(int subjectId);

}
