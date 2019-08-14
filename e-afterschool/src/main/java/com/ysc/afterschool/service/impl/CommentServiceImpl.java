package com.ysc.afterschool.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ysc.afterschool.domain.db.Comment;
import com.ysc.afterschool.repository.CommentRepository;
import com.ysc.afterschool.service.CommentService;

@Transactional
@Service
public class CommentServiceImpl implements CommentService {

	@Autowired
	private CommentRepository commentRepository;

	@Override
	public Comment get(Integer id) {
		return commentRepository.findById(id).get();
	}
	
	@Override
	public List<Comment> getList() {
		return commentRepository.findAll();
	}

	@Override
	public boolean regist(Comment domain) {
		if (isNew(domain)) {
			return commentRepository.save(domain) != null;
		} else {
			return false;
		}	
	}

	@Override
	public boolean update(Comment domain) {
		if (!isNew(domain)) {
			return commentRepository.save(domain) != null;
		} else {
			return false;
		}	
	}

	@Override
	public boolean delete(Integer id) {
		commentRepository.deleteById(id);
		return true;
	}

	private boolean isNew(Comment domain) {
		return !commentRepository.existsById(domain.getId());
	}

	@Override
	public List<Comment> getList(int noticeId) {
		return commentRepository.findBySubjectNoticeId(noticeId);
	}
}
