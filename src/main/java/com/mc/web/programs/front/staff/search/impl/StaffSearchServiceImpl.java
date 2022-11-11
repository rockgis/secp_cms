package com.mc.web.programs.front.staff.search.impl;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mc.common.util.StringUtil;
import com.mc.web.programs.front.staff.search.StaffSearchDAO;
import com.mc.web.programs.front.staff.search.StaffSearchHelper;
import com.mc.web.programs.front.staff.search.StaffSearchService;

import egovframework.com.cmm.util.EgovHttpRequestHelper;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service("StaffSearchService")
public class StaffSearchServiceImpl extends EgovAbstractServiceImpl implements StaffSearchService {
	
	@Autowired
	private StaffSearchDAO dao;
	
	@Autowired
	private StaffSearchHelper helper;
	
	public String list(Map params) throws Exception {
		HttpServletRequest request = EgovHttpRequestHelper.getCurrentRequest();
		params.put("start_group_seq", "3");//부서
		if(StringUtil.isEmptyByParam(params, "group_seq")) params.put("group_seq", "3");
		
		request.setAttribute("group_list", dao.group_list(params));
		request.setAttribute("list", helper.makeList(dao.list(params)));
		return "staff/search/list";
	}
}
