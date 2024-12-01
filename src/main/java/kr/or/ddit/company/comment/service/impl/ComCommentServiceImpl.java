package kr.or.ddit.company.comment.service.impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.company.comment.mapper.IComCommentMapper;
import kr.or.ddit.company.comment.service.IComCommentService;
import kr.or.ddit.company.comment.vo.ComCommentVO;


@Service
public class ComCommentServiceImpl implements IComCommentService {

	@Inject
	private IComCommentMapper commentMapper;

	@Override
	public List<ComCommentVO> comcommentMain(int cmntyNo) {
		return commentMapper.comcommentMain(cmntyNo);
	}

	@Override
	public void comcommentInsert(ComCommentVO commentVO) {
		commentMapper.comcommentInsert(commentVO);
	}
	
	@Override
	public List<ComCommentVO> comcommentReply(int commentNo) {
		return commentMapper.comcommentReply(commentNo);
	}
	
	@Override
	public void comreplyInsert(ComCommentVO commentVO) {
		commentMapper.comreplyInsert(commentVO);
	}

}
