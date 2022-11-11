package com.mc.web.programs.front.board;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Update;
import org.springframework.stereotype.Repository;

import com.mc.web.MCMap;
import com.mc.web.programs.front.board.Pager.Criteria;
import com.mc.web.service.CmsAbstractDAO;

/**
*
* @Description : 게시판 다오
* @ClassName   : com.mc.web.programs.front.board.impl.BoardDAO.java
* @Modification Information
*
* @author 이재우
* @since 2022. 10. 24.
* @version 1.0 *  
* Copyright (C)  All right reserved.
*/

@Repository
public class PortalBoardDAO extends CmsAbstractDAO {
	/**
	 * 게시판 조회
	 * @param Criteria
	 * @return
	 */
	public List<Map<String, Object>> boardList(Criteria cri) {
		return selectList("PortalBoard.boardList", cri);
	}
	
	/**
	 * 게시판 총 게시글 수
	 * @param Criteria
	 * @return
	 */
	public int getTotalCnt(Criteria cri) {
		return selectOne("PortalBoard.getTotalCnt",cri);
	}
	
	/**
	 * 게시글 상세화면
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> boardDetail(Map<String, Object> params) {
		update("PortalBoard.boardCount",params); // 조회수 + 1
		return selectList("PortalBoard.boardDetail", params);
	}
	
	/* 1:1 문의 글쓰기 저장 */
	public int boardInquiryRegister(Map<String, String> params) {
		return insert("PortalBoard.boardInquiryRegister", params);
	}
	
}