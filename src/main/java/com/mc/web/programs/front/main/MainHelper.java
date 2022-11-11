package com.mc.web.programs.front.main;

import java.util.HashMap;
import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import com.mc.common.util.RequestSnack;

@Service
public class MainHelper {
	Logger logger = Logger.getLogger(this.getClass());

	@Autowired
	private MainDAO dao;

	/**
	 * Comment  : 메인 데이터 캐시메모리에 담기위해 헬퍼쪽으로 이동 
	 * @version : 1.0
	 * @tags    : @param params
	 * @tags    : @return
	 * @tags    : @throws Exception
	 * @date    : 2017. 5. 10.
	 *
	 */
	@Cacheable(value="mainCache", key="1")
	public Map indexData() throws Exception {
		Map rst = new HashMap();
		Map params = new HashMap();
		//Board
		params.put("rows", 6);
		params.put("cpage", 1);
		RequestSnack.setPageParams(params);
		
		params.put("board_seq", "1");
		rst.put("board1", dao.boardList(params));//공지사항
		
		params.put("board_seq", "22");
		rst.put("board2", dao.boardList(params));//보도자료
		
		params.put("board_seq", "21");
		rst.put("board2", dao.boardList(params));//참고사례		
		
		params.clear();
		
		//PopupZone
		params.put("selecter", "1");
		params.put("site_id", "1");
		params.put("rows", "99");
		rst.put("popupzone1", dao.popupList(params));//메인 이미지
		params.put("selecter", "2");
		rst.put("popupzone2", dao.popupList(params));//팝업존
		params.put("selecter", "3");
		rst.put("popupzone3", dao.popupList(params));//하단 롤링배너
		params.put("selecter", "4");
		rst.put("popupzone4", dao.popupList(params));//스카이 배너
		
		//레이어 팝업
		params.put("selecter", "10");
		params.put("rows", "99");
		rst.put("layer_popup", dao.popupList(params));//레이어 팝업
		/*
		 * 2020.01.09 유명한
		 * 레이어 팝업 타입 확인
		 */
		rst.put("popup_type", dao.popupType(params));
		
		params.clear();
		
		return rst;
	}
	
	@Cacheable(value="mainCache", key="339")
	public Map indexData2() throws Exception {
		Map rst = new HashMap();
		Map params = new HashMap();
		//Board
		params.put("rows", 6);
		params.put("cpage", 1);
		RequestSnack.setPageParams(params);
		
		params.put("board_seq", "11");
		rst.put("board1", dao.boardList(params));//공지사항
		
		params.put("board_seq", "23");
		rst.put("board2", dao.boardList(params));//보도자료
		
		params.clear();
		
		//PopupZone
		params.put("selecter", "1");
		params.put("site_id", "339");
		params.put("rows", "99");
		rst.put("popupzone1", dao.popupList(params));//메인 이미지
		params.put("selecter", "2");
		rst.put("popupzone2", dao.popupList(params));//팝업존
		params.put("selecter", "3");
		rst.put("popupzone3", dao.popupList(params));//하단 롤링배너
		params.put("selecter", "4");
		rst.put("popupzone4", dao.popupList(params));//스카이 배너
		
		//레이어 팝업
		params.put("selecter", "10");
		params.put("rows", "99");
		rst.put("layer_popup", dao.popupList(params));//레이어 팝업
		/*
		 * 2020.01.09 유명한
		 * 레이어 팝업 타입 확인
		 */
		rst.put("popup_type", dao.popupType(params));
		
		params.clear();
		
		return rst;
	}
	
}
