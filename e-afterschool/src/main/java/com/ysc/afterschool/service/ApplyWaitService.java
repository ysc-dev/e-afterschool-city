package com.ysc.afterschool.service;

import java.util.List;

import com.ysc.afterschool.domain.db.Apply.OrderType;
import com.ysc.afterschool.domain.db.ApplyWait;

public interface ApplyWaitService extends CRUDService<ApplyWait, Integer> {

	boolean search(int infoId, int studentId, int subjectId);
	
	ApplyWait get(int infoId, int subjectId, OrderType type);
	
	List<ApplyWait> getList(int subjectId);
}
