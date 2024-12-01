package kr.or.ddit.employee.comment.service.impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.employee.comment.mapper.ICommentMapper;
import kr.or.ddit.employee.comment.service.ICommentService;
import kr.or.ddit.employee.comment.vo.CommentVO;

@Service
public class CommentServiceImpl implements ICommentService {

	@Inject
	private ICommentMapper commentMapper;

	@Override
	public List<CommentVO> commentMain(int cmntyNo) {
		return commentMapper.commentMain(cmntyNo);
	}

	@Override
	public void commentInsert(CommentVO commentVO) {
		commentMapper.commentInsert(commentVO);
	}
	
	@Override
	public List<CommentVO> commentReply(int commentNo) {
		return commentMapper.commentReply(commentNo);
	}
	
	@Override
	public void replyInsert(CommentVO commentVO) {
		commentMapper.replyInsert(commentVO);
	}

}
