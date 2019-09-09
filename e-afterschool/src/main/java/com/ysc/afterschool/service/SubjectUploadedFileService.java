package com.ysc.afterschool.service;

import java.util.List;

import com.ysc.afterschool.domain.db.SubjectUploadedFile;

public interface SubjectUploadedFileService extends CRUDService<SubjectUploadedFile, Integer> {

	List<SubjectUploadedFile> getList(int classId);

}
