package com.mc.web.programs.back.biz005.impl;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mc.common.util.DateUtil;
import com.mc.web.programs.back.biz005.AdminBiz005DAO;
import com.mc.web.programs.back.biz005.AdminBiz005Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;


/**
 *
 * @Description : 판로개척지원 프로그램 구현
 * @ClassName   : com.mc.web.programs.back.biz005.impl.AdminBiz005ServiceImpl.java
 * @Modification Information
 *
 * @author MSLK_JJS
 * @since 2018. 3. 29.
 * @version 1.0 *  
 * Copyright (C)  All right reserved.
 */
@Service
public class AdminBiz005ServiceImpl extends EgovAbstractServiceImpl implements AdminBiz005Service {

	@Autowired
	private AdminBiz005DAO dao;
	
	public Map test(Map params) throws Exception {
		Map rstMap = new HashMap();
		rstMap.put("data", DateUtil.getTime("YYYY-MM-DD HH:mm:ss"));
		return rstMap;
	}

}
