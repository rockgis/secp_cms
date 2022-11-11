package com.mc.web.programs.back.phistory.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import com.mc.common.util.DateUtil;
import com.mc.web.MCMap;
import com.mc.web.common.SessionInfo;
import com.mc.web.programs.back.phistory.AdminPhistoryDAO;
import com.mc.web.programs.back.phistory.AdminPhistoryService;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;


/**
 *
 * @Description : 페이지이력 프로그램 구현
 * @ClassName   : com.mc.web.programs.back.phistory.impl.AdminPhistoryServiceImpl.java
 * @Modification Information
 *
 * @author sdlck
 * @since 2018. 3. 29.
 * @version 1.0 *  
 * Copyright (C)  All right reserved.
 */
@Service 
public class AdminPhistoryServiceImpl extends EgovAbstractServiceImpl implements AdminPhistoryService {

	@Autowired
	private AdminPhistoryDAO dao; 
	
	public Map list(Map params) throws Exception {
		Map rstMap = new HashMap();
		rstMap.put("list", dao.list(params));
		rstMap.put("pagination", dao.pagination(params));
		return rstMap;
	}
	
	public MCMap view(Map params) throws Exception {
		return dao.view(params);
	}

	public Map write(Map params) throws Exception {
		SessionInfo.sessionAuth(params);
		Map rstMap = new HashMap();
		rstMap.put("rst", dao.write(params));
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
