package com.ysc.afterschool.service;

import java.util.List;

import com.ysc.afterschool.domain.db.Subject;

public interface SubjectService extends CRUDService<Subject, Integer> {

	List<Subject> getList(int subjectGroupId);

	List<Subject> getList(int infoId, int groupId);
}
