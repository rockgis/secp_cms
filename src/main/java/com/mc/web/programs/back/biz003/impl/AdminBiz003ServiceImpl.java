package com.mc.web.programs.back.biz003.impl;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mc.common.util.DateUtil;
import com.mc.web.programs.back.biz003.AdminBiz003DAO;
import com.mc.web.programs.back.biz003.AdminBiz003Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;


/**
 *
 * @Description : 소상공인사업정리 (철거지원) 프로그램 구현
 * @ClassName   : com.mc.web.programs.back.biz003.impl.AdminBiz003ServiceImpl.java
 * @Modification Information
 *
 * @author MSLK_JJS
 * @since 2018. 3. 29.
 * @version 1.0 *  
 * Copyright (C)  All right reserved.
 */
@Service
public class AdminBiz003ServiceImpl extends EgovAbstractServiceImpl implements AdminBiz003Service {

	@Autowired
	private AdminBiz003DAO dao;
	
	public Map test(Map params) throws Exception {
		Map rstMap = new HashMap();
		rstMap.put("data", DateUtil.getTime("YYYY-MM-DD HH:mm:ss"));
		return rstMap;
	}

}
