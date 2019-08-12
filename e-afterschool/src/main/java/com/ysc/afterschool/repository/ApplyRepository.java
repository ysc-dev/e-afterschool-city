package com.ysc.afterschool.repository;

import java.util.List;

import com.ysc.afterschool.domain.db.Apply;

public interface ApplyRepository extends DefaultRepository<Apply, Integer> {

	List<Apply> findByInvitationIdAndStudentId(int infoId, int studentId);

}
