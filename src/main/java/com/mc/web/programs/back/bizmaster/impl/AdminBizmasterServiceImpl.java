package com.mc.web.programs.back.bizmaster.impl;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mc.common.util.DateUtil;
import com.mc.web.programs.back.bizmaster.AdminBizmasterDAO;
import com.mc.web.programs.back.bizmaster.AdminBizmasterService;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;


/**
 *
 * @Description : 지원사업 관리 프로그램 구현
 * @ClassName   : com.mc.web.programs.back.bizmaster.impl.AdminBizmasterServiceImpl.java
 * @Modification Information
 *
 * @author MSLK_JJS
 * @since 2018. 3. 29.
 * @version 1.0 *  
 * Copyright (C)  All right reserved.
 */
@Service
public class AdminBizmasterServiceImpl extends EgovAbstractServiceImpl implements AdminBizmasterService {

	@Autowired
	private AdminBizmasterDAO dao;
	
	public Map test(Map params) throws Exception {
		Map rstMap = new HashMap();
		rstMap.put("data", DateUtil.getTime("YYYY-MM-DD HH:mm:ss"));
		return rstMap;
	}

}
