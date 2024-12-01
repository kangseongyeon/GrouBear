package kr.or.ddit.employee.comment.service;

import java.util.List;

import kr.or.ddit.employee.comment.vo.CommentVO;

public interface ICommentService {

	public List<CommentVO> commentMain(int cmntyNo);

	public void commentInsert(CommentVO commentVO);

	public List<CommentVO> commentReply(int commentNo);
	
	public void replyInsert(CommentVO commentVO);

}
