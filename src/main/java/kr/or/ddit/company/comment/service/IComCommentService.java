package kr.or.ddit.company.comment.service;

import java.util.List;

import kr.or.ddit.company.comment.vo.ComCommentVO;

public interface IComCommentService {

	public List<ComCommentVO> comcommentMain(int cmntyNo);

	public void comcommentInsert(ComCommentVO commentVO);

	public List<ComCommentVO> comcommentReply(int commentNo);
	
	public void comreplyInsert(ComCommentVO commentVO);

}
