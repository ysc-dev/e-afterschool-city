package com.ysc.afterschool.repository;

import java.util.List;

import com.ysc.afterschool.domain.db.Subject;

public interface SubjectRepository extends DefaultRepository<Subject, Integer> {

	List<Subject> findBySubjectGroupId(int subjectGroupId);

	List<Subject> findByInvitationIdAndSubjectGroupId(int infoId, int groupId);

	int countByInvitationIdAndSubjectGroupId(int infoId, int groupId);

	List<Subject> findByInvitationId(int id);

}
