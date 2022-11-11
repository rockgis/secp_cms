package com.mc.web.programs.front.board;

import java.util.List;
import java.util.Map;

import com.mc.web.programs.front.board.Pager.Criteria;


/**
*
* @Description : 게시판 서비스
* @ClassName   : com.mc.web.programs.front.board.impl.BoardService.java
* @Modification Information
*
* @author 이재우
* @since 2022. 10. 24.
* @version 1.0 *  
* Copyright (C)  All right reserved.
*/

public interface PortalBoardService {
	/**
	 * 게시글 목록
	 * @param Criteria
	 * @return List<>
	 * @throws Exception
	 */
	public List<Map<String, Object>> boardList(Criteria cri) throws Exception;

	/* 게시판 총 게시글 수 */
	public int getTotalCnt(Criteria cri);

	/* 게시글 상세화면 */
	public List<Map<String, Object>> boardDetail(Map<String,Object> params) throws Exception;
	
	/* 1:1 문의 글쓰기 저장 */
	public String boardInquiryRegister(Map<String, String> params) throws Exception;
	
	
}
