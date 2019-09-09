package com.ysc.afterschool.repository;

import java.util.List;

import com.ysc.afterschool.domain.db.SubjectUploadedFile;

public interface SubjectUploadedFileRepository extends DefaultRepository<SubjectUploadedFile, Integer> {

	List<SubjectUploadedFile> findByClassContentsId(int classId);
}
