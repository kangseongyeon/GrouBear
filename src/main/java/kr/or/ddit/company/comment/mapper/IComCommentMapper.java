package kr.or.ddit.company.comment.mapper;

import java.util.List;

import kr.or.ddit.company.comment.vo.ComCommentVO;

public interface IComCommentMapper {

	public List<ComCommentVO> comcommentMain(int cmntyNo);

	public void comcommentInsert(ComCommentVO commentVO);

	public void comreplyInsert(ComCommentVO commentVO);

	public List<ComCommentVO> comcommentReply(int commentNo);


}
