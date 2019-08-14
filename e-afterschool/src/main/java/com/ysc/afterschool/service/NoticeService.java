package com.ysc.afterschool.service;

import java.util.List;

import com.ysc.afterschool.domain.db.Notice;

public interface NoticeService extends CRUDService<Notice, Integer> {

	List<Notice> getList(int cityId);

}
