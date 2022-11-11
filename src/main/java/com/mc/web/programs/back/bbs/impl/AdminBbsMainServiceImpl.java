package com.mc.web.programs.back.bbs.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mc.common.util.StringUtil;
import com.mc.web.programs.back.bbs.AdminBbsDAO;
import com.mc.web.programs.back.bbs.AdminBbsMainService;
import com.mc.web.programs.back.filter.FilterService;
import com.mc.web.attach.AttachDAO;
import com.mc.web.common.SessionInfo;

import egovframework.com.cmm.util.EgovHttpRequestHelper;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service("AdminBbsMainService")
public class AdminBbsMainServiceImpl extends EgovAbstractServiceImpl implements AdminBbsMainService{
	
	@Autowired
	private AdminBbsDAO dao;
	
	@Autowired
	private AttachDAO attachDAO;
	
	@Autowired
	private FilterService filterService;
	
	public Map boardInfo(Map params) throws Exception {
		Map rstMap = new HashMap();
		rstMap.put("info", dao.boardInfo(params));
		return rstMap;
	}

	public List catList(Map params) throws Exception {
		return dao.catList(params);
	}
	
	public Map delete(Map params) throws Exception {
		Map rstMap = new HashMap();
		List deleteList = StringUtil.strToList((String)params.get("article_seq"), ",");
		params.put("seq_list", deleteList);
		rstMap.put("rst",dao.delete(params));
		return rstMap;
	}

	public Map articleMove(Map params) throws Exception {
		Map rstMap = new HashMap();
		try{
			List deleteList = StringUtil.strToList((String)params.get("article_seq"), ",");
			params.put("seq_list", deleteList);
			dao.articleMove(params);
			rstMap.put("msg", "게시물이 이동되었습니다.");
		}catch(Exception e){
			rstMap.put("msg", "게시물중 에러가 발새하였습니다.");
		}
		return rstMap;
	}
	
	public Map articleCopy(Map params) throws Exception {
		Map rstMap = new HashMap();
		
		HttpServletRequest request = EgovHttpRequestHelper.getCurrentRequest();
		SessionInfo.sessionAuth(params);
		
		try{
			List<String> copyList = StringUtil.strToList((String)params.get("article_seq"), ",");
			params.put("seq_list", copyList);
			
			for (String seq : copyList){
				params.put("seq", seq);
				dao.articleCopy(params);			
			}			
			rstMap.put("msg", "게시물이 복사되었습니다.");
		}catch(Exception e){
			rstMap.put("msg", "게시물중 에러가 발생하였습니다.");
		}
		return rstMap;
	}

	public Map articleDelete(Map params) throws Exception {
		Map rstMap = new HashMap();
		List<String> deleteList = StringUtil.strToList((String)params.get("article_seq"), ",");
		params.put("seq_list", deleteList);
		rstMap.put("rst", dao.articleDelete(params));
		
		params.put("table_nm", "MC_ARTICLE");
		rstMap.put("rst", attachDAO.delete_all_list(params));
		
		//필터사용시 삭제시 콜
		for (String seq : deleteList) {
			filterService.report_delete(String.valueOf(params.get("cms_menu_seq")), seq);
		}
		return rstMap;
	}

	public Map articleRestore(Map params) throws Exception {
		Map rstMap = new HashMap();
		List deleteList = StringUtil.strToList((String)params.get("article_seq"), ",");
		params.put("seq_list", deleteList);
		rstMap.put("rst", dao.articleRestore(params));
		return rstMap;
	}
}
