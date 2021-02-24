package com.ysc.afterschool.domain.db;

import java.time.LocalDateTime;

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
 * 수강 신청 대기 관리 테이블 도메인
 * 
 * @author hgko
 *
 */
@Entity
@Table(name = "tb_apply_wait")
@Data
@NoArgsConstructor
public class ApplyWait implements Domain {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	/** 학생 */
	@OneToOne
    @JoinColumn(name = "student_id")
	private Student student;
	
	/** 과목 */
	@OneToOne
    @JoinColumn(name = "subject_id")
	private Subject subject;
	
	/** 안내장 */
	private int invitationId;
	
	/** 대기 순서 */
	private int orderNumber;
	
	/** 생성일시 */
	@CreationTimestamp
	private LocalDateTime createDate;
	
	public ApplyWait(int infoId, Student student, Subject subject, int order) {
		this.invitationId = infoId;
		this.student = student;
		this.subject = subject;
		this.orderNumber = order;
	}
}
