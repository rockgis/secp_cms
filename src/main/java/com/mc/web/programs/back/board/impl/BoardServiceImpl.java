package com.mc.web.programs.back.board.impl;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mc.web.programs.back.board.BoardDAO;
import com.mc.web.programs.back.board.BoardHelper;
import com.mc.web.programs.back.board.BoardService;
import com.mc.web.common.SessionInfo;

import egovframework.com.cmm.util.EgovHttpRequestHelper;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service("BoardService")
public class BoardServiceImpl extends EgovAbstractServiceImpl implements BoardService{
	
	@Autowired
	private BoardDAO dao;
	
	@Autowired
	private BoardHelper helper;

	public Map list(Map params) throws Exception {
		Map rstMap = new HashMap();
		rstMap.put("list", dao.list(params));
		rstMap.put("pagination", dao.pagination(params));
		return rstMap;
	}
	
	public Map menu_list(Map params) throws Exception {
		Map rstMap = new HashMap();
		rstMap.put("list", dao.menu_list(params));
		return rstMap;
	}

	public Map insert(Map params) throws Exception {
		Map rstMap = new HashMap();
		SessionInfo.sessionAuth(params);
		
		rstMap.put("result", dao.insert(params));

		
		if("F".equals(params.get("board_type"))){
			//F타입, 개인정보 등록 허용 동의란
			if(params.get("agree_yn").equals("Y")){
				List<Map> list_agree = (List)params.get("user_agree");
				for(int x=0; x < list_agree.size();x++){
					Map m = list_agree.get(x);
					params.put("agree_tit", m.get("agree_tit"));
					params.put("agree_cont", m.get("agree_cont"));
					params.put("agree_check", m.get("agree_check"));		
					params.put("agree_order", m.get("agree_order"));
					
					dao.insertCustomAgree(params);
				}				
			}
						
		/*}
		
		if("F".equals(params.get("board_type"))){*/
			//F타입, 커스텀 컬럼
			List<Map> list = (List)params.get("custom");
			for(int x=0; x < list.size();x++){
				Map m = list.get(x);
				m.put("board_seq", params.get("board_seq"));
				dao.insertCustom(m);				
			}
		}
		if(params.get("cat_yn").equals("Y")){
			if(params.get("cat_nm") != null){
				List cat = (List)params.get("cat_nm");
				for(int x=0; x < cat.size(); x++){
					Map m = new HashMap();
					m.put("board_seq", params.get("board_seq"));
					m.put("cat_nm", ((Map)cat.get(x)).get("cat_nm"));
					m.put("session_member_id", params.get("session_member_id"));
					m.put("session_member_nm", params.get("session_member_nm"));
					dao.cat_insert(m);
				}
			}
		}
		
		if(params.get("board_type").equals("C")){
			if(params.get("state_nm") != null){
				List state = (List)params.get("state_nm");
				for(int x=0; x < state.size(); x++){
					Map m = new HashMap();
					Map stateMap = (Map)state.get(x);
					m.put("board_seq", params.get("board_seq"));
					m.put("state_nm", stateMap.get("state_nm"));
					m.put("session_member_id", params.get("session_member_id"));
					m.put("session_member_nm", params.get("session_member_nm"));
					dao.state_insert(m);
				}
			}
		}
		return rstMap;
	}
	
	public Map modify(Map params) throws Exception {
		Map rstMap = new HashMap();
		SessionInfo.sessionAuth(params);
		rstMap.put("result", dao.modify(params));
		if("F".equals(params.get("board_type"))){
			//F타입, 개인정보 등록 허용 동의란
			if(params.get("agree_yn").equals("Y")){
				//기존항목 전부삭제
				dao.modifyCustomAgree(params);
				//수정항목 전부추가
				List<Map> list_agree = (List)params.get("user_agree");
				for(int x=0; x < list_agree.size();x++){
					Map m = list_agree.get(x);
					params.put("agree_tit", m.get("agree_tit"));
					params.put("agree_cont", m.get("agree_cont"));
					params.put("agree_check", m.get("agree_check"));		
					params.put("agree_order", m.get("agree_order"));
					
					dao.insertCustomAgree(params);
				}
			}
			
			dao.modifyCustom(params);//기존 요소 삭제
			List<Map> list = (List)params.get("custom");
			for(int x=0; x < list.size();x++){
				Map m = list.get(x);
				m.put("board_seq", params.get("board_seq"));
				dao.insertCustom(m);
			}
		}
		if(params.get("cat_yn").equals("Y")){
			if(params.get("remove_cat") != null){
				/* 기존 카테고리 삭제 */
				List remove_cat = (List)params.get("remove_cat");
				for(int x=0; x < remove_cat.size(); x++){
					Map m = new HashMap();
					m.put("session_member_id", params.get("session_member_id"));
					m.put("session_member_nm", params.get("session_member_nm"));
					m.put("board_cat_seq", ((Map)remove_cat.get(x)).get("board_cat_seq"));
					dao.cat_delete(m);
				}
			}
			if(params.get("cat_nm") != null){
				List cat = (List)params.get("cat_nm");
				for(int x=0; x < cat.size(); x++){
					Map m = new HashMap();
					Map cat_info = (Map)cat.get(x);
					if(cat_info.get("board_cat_seq") != null){
						/* 기존 카테고리 수정 */
						m.put("session_member_id", params.get("session_member_id"));
						m.put("session_member_nm", params.get("session_member_nm"));
						m.put("board_cat_seq", cat_info.get("board_cat_seq"));
						m.put("cat_nm", cat_info.get("cat_nm"));
						dao.cat_update(m);
					}else{
						/* 신규 카테고리 생성 */
						m.put("session_member_id", params.get("session_member_id"));
						m.put("session_member_nm", params.get("session_member_nm"));
						m.put("board_seq", params.get("board_seq"));
						m.put("cat_nm", cat_info.get("cat_nm"));
						dao.cat_insert(m);
					}
				}
			}
		}else{
			/* 카테고리 전부 삭제 */
			Map m = new HashMap();
			m.put("session_member_id", params.get("session_member_id"));
			m.put("session_member_nm", params.get("session_member_nm"));
			m.put("board_seq", params.get("board_seq"));
			dao.cat_delete(m);
		}

		if(params.get("board_type").equals("C")){
			if(params.get("remove_state") != null){
				/* 기존 상태값 삭제 */
				List remove_state = (List)params.get("remove_state");
				for(int x=0; x < remove_state.size(); x++){
					Map m = new HashMap();
					m.put("session_member_id", params.get("session_member_id"));
					m.put("session_member_nm", params.get("session_member_nm"));
					m.put("board_state_seq", ((Map)remove_state.get(x)).get("board_state_seq"));
					dao.state_delete(m);
				}
			}
			if(params.get("state_nm") != null){
				List state = (List)params.get("state_nm");
				for(int x=0; x < state.size(); x++){
					Map m = new HashMap();
					Map state_info = (Map)state.get(x);
					if(state_info.get("board_state_seq") != null){
						/* 기존 상태값 수정 */
						m.put("session_member_id", params.get("session_member_id"));
						m.put("session_member_nm", params.get("session_member_nm"));
						m.put("board_state_seq", state_info.get("board_state_seq"));
						m.put("state_nm", state_info.get("state_nm"));
						dao.state_update(m);
					}else{
						/* 신규 상태값 생성 */
						m.put("session_member_id", params.get("session_member_id"));
						m.put("session_member_nm", params.get("session_member_nm"));
						m.put("board_seq", params.get("board_seq"));
						m.put("state_nm", state_info.get("state_nm"));
						dao.state_insert(m);
					}
				}
			}
		}else{
			/* 카테고리 전부 삭제 */
			Map m = new HashMap();
			m.put("session_member_id", params.get("session_member_id"));
			m.put("session_member_nm", params.get("session_member_nm"));
			m.put("board_seq", params.get("board_seq"));
			dao.state_delete(m);
		}
		return rstMap;
	}

	public Map info(Map params) throws Exception {
		Map rstMap = new HashMap();
		Map info = dao.info(params);
		rstMap.put("info",info);
		if(info.get("cat_yn").equals("Y")){
			List list = dao.cat_info(params);
			rstMap.put("cat_info",list);
		}
		if(info.get("board_type").equals("C")){
			List list = dao.state_info(params);
			rstMap.put("state_info",list);
		}
		if(info.get("agree_yn").equals("Y")){
			List list = dao.selectCustomAgree(params);
			rstMap.put("agree_info",list);
		}
		return rstMap;
	}

	public Map delete(Map params) throws Exception {
		Map rstMap = new HashMap();
		SessionInfo.sessionAuth(params);
		rstMap.put("rst", dao.delete(params));
		rstMap.put("rst", dao.deleteCustomAgree(params));
		return rstMap;
	}
	
	/*
	 * 커스텀 게시판 관련
	 * 
	 */
	public List<Map> customColumnList() throws Exception {
		return dao.customColumnList();
	}

	public List<Map> customElementList(Map params) throws Exception {
		return dao.customElementList(params);
	}

	@Override
	public List<Map> typeList() throws Exception {
		return dao.typeList();
	}

	@Override
	public Map typeInsert(Map<String, String> params){
		Map rstMap = new HashMap();
		try{
			if("127.0.0.1".equals(EgovHttpRequestHelper.getRequestIp()) || "localhost".equals(EgovHttpRequestHelper.getRequestIp())){
				helper.makeFiles(params);
			}
			if(dirCheck(params,rstMap,"등록")){
				if(dao.typeInsert(params) == 1){
					rstMap.put("msg", "등록이 완료되었습니다.");
				}else{
					rstMap.put("msg", "등록에 실패하였습니다.");
				}
			}
		}catch(Exception e){
			rstMap.put("msg", "알수없는 오류가 발생하였습니다.");
		}finally {
			rstMap.put("list",dao.typeList());
		}
		return rstMap;
	}

	@Override
	public Map typeModify(Map<String, String> params){
		Map rstMap = new HashMap();
		try{
//			if(dirCheck(params,rstMap,"수정")){
				if(dao.typeModify(params) == 1){
					rstMap.put("msg", "등록이 완료되었습니다.");
				}else{
					rstMap.put("msg", "등록에 실패하였습니다.");
				}
//			}
		}catch(Exception e){
			rstMap.put("msg", "알수없는 오류가 발생하였습니다.");
		}finally {
			rstMap.put("list",dao.typeList());
		}
		return rstMap;
	}

	@Override
	public Map typeDelete(Map<String, String> params) throws Exception {
		Map rstMap = new HashMap();
		dao.typeDelete(params);
		rstMap.put("msg", "삭제가 완료되었습니다.");
		rstMap.put("list",dao.typeList());
		return rstMap;
	}
	
	private boolean dirCheck(Map<String, String> params,Map rstMap,String type){
		boolean checkValue = false;
		HttpServletRequest request = EgovHttpRequestHelper.getCurrentRequest();
		File user_dir = new File(request.getSession().getServletContext().getRealPath(File.separator+"WEB-INF"+File.separator+"jsp"+File.separator+"bbs"+File.separator+params.get("board_type")+File.separator));
		File admin_dir = new File(request.getSession().getServletContext().getRealPath(File.separator+"WEB-INF"+File.separator+"jsp"+File.separator+"super"+File.separator+"homepage"+File.separator+"bbs"+File.separator+params.get("board_type")+File.separator));
		
		/* 
		 * 20211122 
		 * FAMOUS
		 * 로컬에서 JSP파일 생성이 meta쪽에 생성되어 확인되지 않아 주석처리
		 * 
		if(!user_dir.isDirectory() && !admin_dir.isDirectory()){
			rstMap.put("msg", type+"하려는 타입의 사용자와 관리자 게시판이 개발되어 있지 않습니다.");
		}else if(!user_dir.isDirectory()){
			rstMap.put("msg", type+"하려는 타입의 사용자 게시판이 개발되어 있지 않습니다.");
		}else if(!admin_dir.isDirectory()){
			rstMap.put("msg", type+"하려는 타입의 관리자 게시판이 개발되어 있지 않습니다.");
		}else if(typeCheck(params)){
			rstMap.put("msg", type+"하려는 타입이 이미 등록되어 있습니다.");
		}else{
			checkValue = true;
		} */
		
		/* 
		 * 20211122 
		 * FAMOUS
		 * 중복여부만 확인
		 */
		if(typeCheck(params)){
			rstMap.put("msg", type+"하려는 타입이 이미 등록되어 있습니다.");
		}else{
			checkValue = true;
		}
		
		return checkValue;
	}
	
	private boolean typeCheck(Map<String, String> params){
		boolean checkValue = true;
		List list = dao.typeCheck(params);
		if(list.isEmpty()){
			checkValue = false;
		}
		return checkValue;
	}
}