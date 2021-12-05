package com.ysc.afterschool.domain.db;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.ysc.afterschool.domain.AbstractDomain;
import com.ysc.afterschool.domain.db.Student.TargetType;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.Getter;

/**
 * 수강 과목 관리 도메인
 * 
 * @author hgko
 *
 */
@Entity
@Table(name = "tb_subject")
@Data
@EqualsAndHashCode(callSuper = false)
public class Subject extends AbstractDomain {

	/** 이름 */
	@Column(nullable = false, length = 255)
	private String name;
	
	/** 안내장 */
	private int invitationId;
	
	/** 강사 */
	@OneToOne
    @JoinColumn(name = "teacher_id")
	private Teacher teacher;
	
	/** 과목 그룹 */
	@OneToOne
    @JoinColumn(name = "subject_group_id")
	private SubjectGroup subjectGroup;
	
	/** 수강기간 */
	@Column(nullable = false, length = 255)
	private String period;
	
	/** 요일 */
	@Column(nullable = false, length = 45)
	private String week;
	
	/** 운영시간 */
	@Column(nullable = false, length = 45)
	private String time;
	
	/** 장소 */
	@Column(length = 255)
	private String location;
	
	/** 재료비 및 교구비 부가적인 설명 */
	@Column(nullable = false, length = 45)
	private String cost;
	
	/** 정원 */
	private int fixedNumber;
	
	/** 수강신청 인원 */
	private int applyNumber;
	
	/** 대기 정원 */
	private int waitFixedNumber;
	
	/** 신청 대기 인원 */
	private int waitingNumber;
	
	/** 과목특징 */
	@Column(nullable = false, length = 255)
	private String description;
	
	/** 대상 */
	@Enumerated(EnumType.STRING)
	@Column(nullable = false)
	private TargetType targetType;
	
	@Enumerated(EnumType.STRING)
	@Column(nullable = false)
	private GradeType gradeType;
	
	@Transient
	private String target;
	
	@Transient
	private ApplyType applyType;
	
	@Getter
	public enum ApplyType {
		NONE(""), 
		APPLY("신청완료"), 
		APPLYWAIT("신청완료"), 
		NOTAPPLY("신청불가"),
		FILL("정원초과"),
		WAITING("대기인원초과"),
		APPLYFILL("수강신청완료");
		
		private String name;
		
		private ApplyType(String name) {
			this.name = name;
		}
	}
	
	@Getter
	public enum GradeType {
		NONE("전학년", 0, 0),
		GRADE_1_2("1-2학년", 1, 2),
		GRADE_1_3("1-3학년", 1, 3),
		GRADE_1_4("1-4학년", 1, 4),
		GRADE_2_6("2-6학년", 2, 6),
		GRADE_3_4("3-4학년", 3, 4),
		GRADE_3_6("3-6학년", 3, 6),
		GRADE_4_6("4-6학년", 4, 6),
		GRADE_5_6("5-6학년", 5, 6),
		초_3_6_중등("초등 3-6학년, 중등", 3, 6),
		초_5_6_중등("초등 5-6학년, 중등", 5, 6),
		유치부_5("유치부 5세", 0, 7),
		유치부_6("유치부 6세", 0, 7),
		유치부_7("유치부 7세", 0, 7),
		유치부_5_MORE("유치부 5세 이상", 0, 7),
		유치부_6_MORE("유치부 6세 이상", 0, 7),
		유치부_7_MORE("유치부 7세 이상", 0, 7),
		유치부_5_6("유치부 5~6세", 0, 7),
		유치부_5_7("유치부 5~7세", 0, 7);
		
		private String name;
		
		private int min;
		
		private int max;
		
		private GradeType(String name, int min, int max) {
			this.name = name;
			this.min = min;
			this.max = max;
		}
	}
	
	/**
	 * 학생 학년에 따라 과목 대상학년만 보여지도록
	 * @param gradeType
	 * @param grade
	 * @return
	 */
	public boolean targetTrue(GradeType gradeType, int grade) {
		if (gradeType == GradeType.NONE 
				|| (gradeType.getMin() <= grade && grade <= gradeType.getMax())
				|| gradeType.getName().contains("유치부")) {
			return true;
		}
		return false;
	}
}
