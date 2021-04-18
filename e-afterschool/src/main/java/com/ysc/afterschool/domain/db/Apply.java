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
import javax.persistence.Transient;

import org.hibernate.annotations.CreationTimestamp;

import com.ysc.afterschool.domain.Domain;

import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;

/**
 * 수강 신청 관리 테이블 도메인
 * 
 * @author hgko
 *
 */
@Entity
@Table(name = "tb_apply")
@Data
@NoArgsConstructor
public class Apply implements Domain {

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
	
	/** 생성일시 */
	@CreationTimestamp
	private LocalDateTime createDate;
	
	@Transient
	private Subject subject;
	
	public Apply(int invitationId, Student student, Subject subject) {
		this.invitationId = invitationId;
		this.student = student;
		this.subjectId = subject.getId();
		this.school = student.getSchool();
		this.grade = student.getGrade();
	}
	
	@Getter
	public enum OrderType {
		오름차순("asc"),
		내림차순("desc");
		
		private String name;
		
		private OrderType(String name) {
			this.name = name;
		}
	}
		
}
