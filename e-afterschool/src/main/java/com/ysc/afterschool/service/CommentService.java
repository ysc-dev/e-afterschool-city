package com.ysc.afterschool.service;

import java.util.List;

import com.ysc.afterschool.domain.db.Comment;

public interface CommentService extends CRUDService<Comment, Integer> {

	List<Comment> getList(int noticeId);
}
