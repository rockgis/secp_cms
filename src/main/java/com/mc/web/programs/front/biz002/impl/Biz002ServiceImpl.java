package com.mc.web.programs.front.biz002.impl;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mc.web.programs.front.biz002.Biz002DAO;
import com.mc.web.programs.front.biz002.Biz002Service;

/**
 *
 * @Description : 소상공인사업정리(재기장려 지원) 프로그램 서비스 구현
 * @ClassName   : com.mc.web.programs.biz002.impl.Biz002ServiceImpl.java
 * @Modification Information
 *
 * @author MSLK_JJS
 * @since 2018. 3. 29.
 * @version 1.0 *  
 * Copyright (C)  All right reserved.
 */
@Service
public class Biz002ServiceImpl implements Biz002Service {
	
	@Autowired
	private Biz002DAO dao;
	
	public String intro(Map<String, String> params) throws Exception {
		return "programs/biz002/intro";
	}
	
}
