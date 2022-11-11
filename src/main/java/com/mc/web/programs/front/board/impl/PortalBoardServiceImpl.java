package com.mc.web.programs.front.board.impl;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mc.web.programs.front.board.PortalBoardDAO;
import com.mc.web.programs.front.board.PortalBoardService;
import com.mc.web.programs.front.board.Pager.Criteria;

import egovframework.com.cmm.util.EgovHttpRequestHelper;

/**
*
* @Description : 게시판 서비스 구현
* @ClassName   : com.mc.web.programs.front.board.impl.BoardServiceImpl.java
* @Modification Information
*
* @author 이재우
* @since 2022. 10. 24.
* @version 1.0 *  
* Copyright (C)  All right reserved.
*/

@Service("PortalBoardService")
public class PortalBoardServiceImpl implements PortalBoardService {

	@Autowired(required=true)
	private PortalBoardDAO dao;
	
	/* 게시글 목록 */
	@Override
	public List<Map<String, Object>> boardList(Criteria cri) throws Exception {
	    return dao.boardList(cri);
	}

	/* 게시판 총 게시글 수 */
	@Override
	public int getTotalCnt(Criteria cri) {
		return dao.getTotalCnt(cri);
	}
	
	/* 게시글 상세화면 */
	@Override
	public List<Map<String, Object>> boardDetail(Map<String, Object> params) throws Exception {
		return dao.boardDetail(params);
	}
	
	/* 1:1 문의 글쓰기 저장 */
	@Override
	public String boardInquiryRegister(Map<String, String> params) throws Exception {
		HttpServletRequest request = EgovHttpRequestHelper.getCurrentRequest();
		dao.boardInquiryRegister(params);
		request.setAttribute("Test", "Test");
		return "Test";
	}

}
