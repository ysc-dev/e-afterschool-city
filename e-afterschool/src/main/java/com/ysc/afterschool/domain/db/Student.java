package com.ysc.afterschool.domain.db;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.ysc.afterschool.domain.AbstractDomain;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.Getter;

/**
 * 학생 관리 도메인
 * 
 * @author hgko
 *
 */
@Entity
@Table(name = "tb_student")
@Data
@EqualsAndHashCode(callSuper = false)
public class Student extends AbstractDomain {
	
	/** 이름 */
	@Column(nullable = false, length = 20)
	private String name;
	
	/** 소속(학교 명) */
	@Column(nullable = false, length = 45)
	private String school;
	
	/** 소속(학교 명) - 간략히 */
	@Column(nullable = false, length = 45)
	private String schoolInfo;
	
	/** 학년 */
	private int grade;
	
	/** 학급(반) */
	private int classType;
	
	/** 번호 */
	private int number;
	
	/** 연락처 */
	@Column(length = 20)
	private String tel;
	
	/** 개인정보제공 동의 */
	private boolean agree;
	
	/** 주민등록번호 */
	@Column(length = 15)
	private String residentNumber;
	
	@Enumerated(EnumType.STRING)
	@Column(nullable = false)
	private TargetType targetType;
	
	/** 캠퍼스 */
	@Column(length = 20)
	private String city;
	
	/** 아파트 */
	@Column(length = 45)
	private String apartment;
	
	/** 동 */
	@Column(length = 45)
	private String dong;
	
	/** 호수 */
	@Column(length = 45)
	private String ho;
	
	/** 핸드폰 앞자리 */
	@Transient
	private String service;
	
	@Transient
	private String jumin1;
	
	@Transient
	private String jumin2;
	
	@Getter
	public enum TargetType {
		전체("전체", ""),
		초등("초등", "초"),
		중등("중등", "중"),
		고등("고등", "고"),
		유치부("유치부", ""),
		성인부("성인부", "");
		
		private String name;
		
		private String info;
		
		private TargetType(String name, String info) {
			this.name = name;
			this.info = info;
		}
	}
}
