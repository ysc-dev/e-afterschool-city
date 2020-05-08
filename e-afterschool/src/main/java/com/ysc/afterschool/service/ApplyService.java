package com.ysc.afterschool.service;

import java.util.List;

import com.ysc.afterschool.domain.db.Apply;

public interface ApplyService extends CRUDService<Apply, Integer> {

	List<Apply> getList(int infoId, int studentId);

	boolean search(int infoId, int studentId, int subjectId);
	
	long count(int infoId, int studentId);
}
