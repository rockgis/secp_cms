package com.mc.web.programs.back.biz004.impl;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mc.common.util.DateUtil;
import com.mc.web.programs.back.biz004.AdminBiz004DAO;
import com.mc.web.programs.back.biz004.AdminBiz004Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;


/**
 *
 * @Description : 소상공인사업정리 (컨설팅 지원) 프로그램 구현
 * @ClassName   : com.mc.web.programs.back.biz004.impl.AdminBiz004ServiceImpl.java
 * @Modification Information
 *
 * @author MSLK_JJS
 * @since 2018. 3. 29.
 * @version 1.0 *  
 * Copyright (C)  All right reserved.
 */
@Service
public class AdminBiz004ServiceImpl extends EgovAbstractServiceImpl implements AdminBiz004Service {

	@Autowired
	private AdminBiz004DAO dao;
	
	public Map test(Map params) throws Exception {
		Map rstMap = new HashMap();
		rstMap.put("data", DateUtil.getTime("YYYY-MM-DD HH:mm:ss"));
		return rstMap;
	}

}
