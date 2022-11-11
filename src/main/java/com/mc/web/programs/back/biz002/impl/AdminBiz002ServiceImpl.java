package com.mc.web.programs.back.biz002.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.mc.web.MCMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mc.common.util.DateUtil;
import com.mc.web.programs.back.biz002.AdminBiz002DAO;
import com.mc.web.programs.back.biz002.AdminBiz002Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;


/**
 *
 * @Description : 소상공인사업정리(재기장려 지원) 프로그램 구현
 * @ClassName   : com.mc.web.programs.back.biz002.impl.AdminBiz002ServiceImpl.java
 * @Modification Information
 *
 * @author MSLK_JJS
 * @since 2018. 3. 29.
 * @version 1.0 *  
 * Copyright (C)  All right reserved.
 */
@Service
public class AdminBiz002ServiceImpl extends EgovAbstractServiceImpl implements AdminBiz002Service {

	@Autowired
	private AdminBiz002DAO dao;

	public Map<String,Object> selectGridHeader() throws Exception{
		//Map rstMap = new HashMap();
		//rstMap.put("columnLayout", dao.selectGridHeader());
		Map<String,Object> rstMap = dao.selectGridHeader();
		return rstMap;


	}

	public List<MCMap> selectGridData(Map<String, String> params) throws Exception{
		List<MCMap> rstMap = dao.selectGridData(params);
		return rstMap;
	}

	public Map selectBizInfo(Map params) throws Exception{
		Map rstMap = new  HashMap();
		rstMap.put("bizInfo", dao.selectBizInfo(params));
		return rstMap;
	}

}
