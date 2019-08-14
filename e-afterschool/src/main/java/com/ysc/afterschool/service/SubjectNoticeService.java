package com.ysc.afterschool.service;

import java.util.List;

import com.ysc.afterschool.domain.db.SubjectNotice;

public interface SubjectNoticeService extends CRUDService<SubjectNotice, Integer> {

	List<SubjectNotice> getList(int subjectId);
}
