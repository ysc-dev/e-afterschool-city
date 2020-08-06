package com.ysc.afterschool.repository;

import java.util.List;

import org.springframework.data.jpa.repository.Query;

import com.ysc.afterschool.domain.db.ApplyWait;

public interface ApplyWaitRepository extends DefaultRepository<ApplyWait, Integer> {

	List<ApplyWait> findByInvitationIdAndStudentId(int infoId, int studentId);

	ApplyWait findByInvitationIdAndStudentIdAndSubjectId(int infoId, int studentId, int subjectId);

	@Query(value = "SELECT * FROM tb_apply_wait WHERE invitation_id = ?1 and subject_id = ?2 ORDER BY order_number asc limit 1 ", nativeQuery = true)
	ApplyWait getAsc(int infoId, int subjectId, String order);
	
	@Query(value = "SELECT * FROM tb_apply_wait WHERE invitation_id = ?1 and subject_id = ?2 ORDER BY order_number desc limit 1 ", nativeQuery = true)
	ApplyWait getDesc(int infoId, int subjectId, String order);

	@Query(value = "SELECT * FROM tb_apply_wait WHERE subject_id = ?1 ORDER BY order_number asc", nativeQuery = true)
	List<ApplyWait> findBySubjectId(int subjectId);
	
	@Query(value = "SELECT * FROM tb_apply_wait WHERE invitation_id = ?1 GROUP BY student_id", nativeQuery = true)
	List<ApplyWait> findByInvitationIdGroupByStudentId(int invitationId);
}
