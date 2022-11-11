package com.mc.web.programs.back.{{SUB_NAME_LOWER}}.impl;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mc.common.util.DateUtil;
import com.mc.web.programs.back.{{SUB_NAME_LOWER}}.Admin{{SUB_NAME_CAMEL}}DAO;
import com.mc.web.programs.back.{{SUB_NAME_LOWER}}.Admin{{SUB_NAME_CAMEL}}Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;


/**
 *
 * @Description : {{TITLE}} 프로그램 구현
 * @ClassName   : com.mc.web.programs.back.{{SUB_NAME_LOWER}}.impl.Admin{{SUB_NAME_CAMEL}}ServiceImpl.java
 * @Modification Information
 *
 * @author {{USER_NAME}}
 * @since 2018. 3. 29.
 * @version 1.0 *  
 * Copyright (C)  All right reserved.
 */
@Service
public class Admin{{SUB_NAME_CAMEL}}ServiceImpl extends EgovAbstractServiceImpl implements Admin{{SUB_NAME_CAMEL}}Service {

	@Autowired
	private Admin{{SUB_NAME_CAMEL}}DAO dao;
	
	public Map test(Map params) throws Exception {
		Map rstMap = new HashMap();
		rstMap.put("data", DateUtil.getTime("YYYY-MM-DD HH:mm:ss"));
		return rstMap;
	}

}
