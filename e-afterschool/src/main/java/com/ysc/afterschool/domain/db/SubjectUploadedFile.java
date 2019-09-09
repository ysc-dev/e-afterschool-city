package com.ysc.afterschool.domain.db;

import java.time.LocalDateTime;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.hibernate.annotations.CreationTimestamp;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.ysc.afterschool.domain.Domain;

import lombok.Data;

/**
 * 과목 관련 첨부파일 관리 도메인
 * 
 * @author hgko
 *
 */
@Entity
@Table(name = "tb_subject_uploaded_file")
@Data
public class SubjectUploadedFile implements Domain {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	/** 파일 이름 */
	@Column(nullable = false, length = 100)
	private String fileName;

	/** 파일 데이터 */
	@Column(columnDefinition = "longblob")
	private byte[] content;

	/** 파일 확장자 */
	@Column(nullable = false, length = 100)
	private String contentType;
	
	@CreationTimestamp
	private LocalDateTime createDate;
	
	@ManyToOne
	@JoinColumn(name = "class_contents_id")
    @JsonIgnore
    private ClassContents classContents;
    
    @Enumerated(EnumType.STRING)
	@Column(nullable = false)
	private FileType fileType;
    
	public enum FileType {
		IMAGE, VIDEO;
	}
}
