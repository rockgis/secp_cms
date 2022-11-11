package com.mc.web.programs.back.intro.impl;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mc.common.util.DateUtil;
import com.mc.web.programs.back.intro.AdminIntroDAO;
import com.mc.web.programs.back.intro.AdminIntroService;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;


/**
 *
 * @Description : 포털 소개 프로그램 구현
 * @ClassName   : com.mc.web.programs.back.intro.impl.AdminIntroServiceImpl.java
 * @Modification Information
 *
 * @author khkim
 * @since 2018. 3. 29.
 * @version 1.0 *  
 * Copyright (C)  All right reserved.
 */
@Service
public class AdminIntroServiceImpl extends EgovAbstractServiceImpl implements AdminIntroService {

	@Autowired
	private AdminIntroDAO dao;
	
	public Map test(Map params) throws Exception {
		Map rstMap = new HashMap();
		rstMap.put("data", DateUtil.getTime("YYYY-MM-DD HH:mm:ss"));
		return rstMap;
	}

}
