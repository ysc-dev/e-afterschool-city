package com.ysc.afterschool.repository;

import java.util.List;

import com.ysc.afterschool.domain.db.SubjectNotice;

public interface SubjectNoticeRepository extends DefaultRepository<SubjectNotice, Integer> {

	List<SubjectNotice> findBySubjectIdOrderByImportantDescCreateDateDesc(int subjectId);

}
