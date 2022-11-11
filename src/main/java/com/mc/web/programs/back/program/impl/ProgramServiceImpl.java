package com.mc.web.programs.back.program.impl;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mc.web.MCMap;
import com.mc.web.programs.back.program.ProgramDAO;
import com.mc.web.programs.back.program.ProgramHelper;
import com.mc.web.programs.back.program.ProgramService;
import com.mc.web.common.SessionInfo;

import egovframework.com.cmm.util.EgovHttpRequestHelper;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service("ProgramService")
public class ProgramServiceImpl extends EgovAbstractServiceImpl implements ProgramService{
	
	@Autowired
	private ProgramDAO dao;
	
	@Autowired
	private ProgramHelper helper;
	
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
	
	public MCMap view(Map params) throws Exception {
		return dao.view(params);
	}

	public Map write(Map params) throws Exception {
		SessionInfo.sessionAuth(params);
		Map rstMap = new HashMap();
		rstMap.put("rst", dao.write(params));
		if("Y".equals(params.get("create_file_yn")) && ("127.0.0.1".equals(EgovHttpRequestHelper.getRequestIp()) || "localhost".equals(EgovHttpRequestHelper.getRequestIp()) || "0:0:0:0:0:0:0:1".equals(EgovHttpRequestHelper.getRequestIp()))){
			helper.makeFiles(params);
		}
		return rstMap;
	}

	public Map modify(Map params) throws Exception {
		SessionInfo.sessionAuth(params);
		Map rstMap = new HashMap();
		rstMap.put("rst", dao.modify(params));
		return rstMap;
	}

	public Map del(Map params) throws Exception {
		SessionInfo.sessionAuth(params);
		Map rstMap = new HashMap();
		rstMap.put("rst", dao.del(params));
		return rstMap;
	}
}
