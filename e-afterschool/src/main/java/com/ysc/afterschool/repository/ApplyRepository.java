package com.ysc.afterschool.repository;

import java.util.List;

import org.springframework.data.jpa.repository.Query;

import com.ysc.afterschool.domain.db.Apply;

public interface ApplyRepository extends DefaultRepository<Apply, Integer> {

	List<Apply> findByInvitationIdAndStudentId(int infoId, int studentId);

	Apply findByInvitationIdAndStudentIdAndSubjectId(int infoId, int studentId, int subjectId);
	
	@Query(value = "SELECT count(*) FROM tb_apply WHERE invitation_id = ?1 and student_id = ?2", nativeQuery = true)
	Long findCountByInvitationIdAndStudentId(int infoId, int studentId);
}
