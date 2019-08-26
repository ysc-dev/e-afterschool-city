package com.ysc.afterschool.service;

import com.ysc.afterschool.domain.db.ApplyWait;
import com.ysc.afterschool.domain.db.Apply.OrderType;

public interface ApplyWaitService extends CRUDService<ApplyWait, Integer> {

	boolean search(int infoId, int studentId, int subjectId);
	
	ApplyWait get(int infoId, int subjectId, OrderType type);
}
