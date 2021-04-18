package com.ysc.afterschool.domain.db;

import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.FetchType;
import javax.persistence.Lob;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;

import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;

import com.ysc.afterschool.domain.AbstractDomain;

import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * 전체 공지사항 테이블 도메인
 * 
 * @author hgko
 *
 */
@Entity
@Table(name = "tb_notice")
@Data
@EqualsAndHashCode(callSuper = false)
public class Notice extends AbstractDomain {

	/** 제목 */
	@NotNull
	private String title;

	/** 내용 */
	@Lob
	@NotNull
	private String content;

	/** 중요도 */
	@Enumerated(EnumType.STRING)
	private PostStatus status;
	
	/** 도시 */
	@Column(nullable = false, length = 20)
	private String city;
	
	/** 조회 수 */
	private int hit;
	
	/** 작성 사용자 ID */
	@Column(nullable = false, length = 20)
	private String userId;
	
	/** 작성 사용자명 */
	@Column(nullable = false, length = 100)
	private String userName;
	
	/** 첨부파일 */
	@OneToMany(mappedBy = "notice", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
	@Fetch(FetchMode.SUBSELECT)
	private List<UploadedFile> uploadedFiles;
	
	public enum PostStatus {
		Y, N
	}
}
