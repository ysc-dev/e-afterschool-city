package com.ysc.afterschool.repository;

import java.util.List;

import com.ysc.afterschool.domain.db.Comment;

public interface CommentRepository extends DefaultRepository<Comment, Integer> {

	List<Comment> findBySubjectNoticeId(int noticeId);

}
