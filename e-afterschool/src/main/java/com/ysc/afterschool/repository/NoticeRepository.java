package com.ysc.afterschool.repository;

import java.util.List;

import com.ysc.afterschool.domain.db.Notice;

public interface NoticeRepository extends DefaultRepository<Notice, Integer> {

	List<Notice> findByCity(String city);

}
