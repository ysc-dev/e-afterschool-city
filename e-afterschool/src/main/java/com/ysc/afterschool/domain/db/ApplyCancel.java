package com.ysc.afterschool.domain.db;

import java.time.LocalDateTime;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import org.hibernate.annotations.CreationTimestamp;

import com.ysc.afterschool.domain.Domain;

import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 수강 취소 관리 테이블 도메인
 * 
 * @author hgko
 *
 */
@Entity
@Table(name = "tb_apply_cancel")
@Data
@NoArgsConstructor
public class ApplyCancel implements Domain {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	/** 학생 */
	@OneToOne
    @JoinColumn(name = "student_id")
	private Student student;
	
	/** 과목 */
	private int subjectId;
	
	/** 안내장 */
	private int invitationId;
	
	/** 소속(학교 명) */
	@Column(nullable = false, length = 45)
	private String school;
	
	/** 학년 */
	private int grade;
	
	@CreationTimestamp
	private LocalDateTime createDate;
	
	public ApplyCancel(Apply apply) {
		this.invitationId = apply.getInvitationId();
		this.student = apply.getStudent();
		this.subjectId = apply.getSubjectId();
		this.school = student.getSchool();
		this.grade = student.getGrade();
	}
}
