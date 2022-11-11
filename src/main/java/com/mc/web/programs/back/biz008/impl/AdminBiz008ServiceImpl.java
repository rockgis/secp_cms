package com.mc.web.programs.back.biz008.impl;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mc.common.util.DateUtil;
import com.mc.web.programs.back.biz008.AdminBiz008DAO;
import com.mc.web.programs.back.biz008.AdminBiz008Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;


/**
 *
 * @Description : 명품점포 프로그램 구현
 * @ClassName   : com.mc.web.programs.back.biz008.impl.AdminBiz008ServiceImpl.java
 * @Modification Information
 *
 * @author MSLK_JJS
 * @since 2018. 3. 29.
 * @version 1.0 *  
 * Copyright (C)  All right reserved.
 */
@Service
public class AdminBiz008ServiceImpl extends EgovAbstractServiceImpl implements AdminBiz008Service {

	@Autowired
	private AdminBiz008DAO dao;
	
	public Map test(Map params) throws Exception {
		Map rstMap = new HashMap();
		rstMap.put("data", DateUtil.getTime("YYYY-MM-DD HH:mm:ss"));
		return rstMap;
	}

}
