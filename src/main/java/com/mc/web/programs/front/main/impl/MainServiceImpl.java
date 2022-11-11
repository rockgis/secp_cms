package com.mc.web.programs.front.main.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mc.web.MCMap;
import com.mc.web.programs.back.site.layout_setting.LayoutSettingDAO;
import com.mc.web.programs.front.main.MainDAO;
import com.mc.web.programs.front.main.MainHelper;
import com.mc.web.programs.front.main.MainService;

import egovframework.com.cmm.util.EgovHttpRequestHelper;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service("MainService")
public class MainServiceImpl extends EgovAbstractServiceImpl implements MainService{
	
	@Autowired
	private MainDAO dao;
	
	@Autowired
	private LayoutSettingDAO layoutSettingDAO;
	
	@Autowired
	private MainHelper helper;

	@Override
	public String indexData() throws Exception {
		HttpServletRequest request = EgovHttpRequestHelper.getCurrentRequest();
		request.setAttribute("data", helper.indexData());
		return "web/index";
	}
	
	@Override
	public String indexData2() throws Exception {
		HttpServletRequest request = EgovHttpRequestHelper.getCurrentRequest();
		request.setAttribute("data", helper.indexData2());
		return "web2/index";
	}
	
	@Override
	public String main() throws Exception {
		HttpServletRequest request = EgovHttpRequestHelper.getCurrentRequest();
		Map rstMap = new HashMap();
		Map params = new HashMap();
		params.put("site_id", "1");
		List<MCMap> list = layoutSettingDAO.layout_list(params);
		for (MCMap map : list) {
			map.put("module", layoutSettingDAO.layout_dtl_list(map));
		}
		rstMap.put("list", list);
		request.setAttribute("data", rstMap);
		return "main";
	}
	
	@Override
	public String main_board(Map params) throws Exception {
		HttpServletRequest request = EgovHttpRequestHelper.getCurrentRequest();
		Map rstMap = new HashMap();
		//Board
		params.put("rows", "6");
		params.put("cpage", "1");
		
		request.setAttribute("board", dao.boardList(params));
		return "main_modules/board";
	}
	
	@Override
	public Map boardRlist(Map params) throws Exception {
		Map rstMap = new HashMap();
		rstMap.put("rlist", dao.boardRlist(params));
		return rstMap;
	}
}