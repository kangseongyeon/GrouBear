package kr.or.ddit.employee.comment.mapper;

import java.util.List;

import kr.or.ddit.employee.comment.vo.CommentVO;

public interface ICommentMapper {

	public List<CommentVO> commentMain(int cmntyNo);

	public void commentInsert(CommentVO commentVO);

	public void replyInsert(CommentVO commentVO);

	public List<CommentVO> commentReply(int commentNo);


}
