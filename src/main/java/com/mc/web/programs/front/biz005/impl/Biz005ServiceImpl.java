package com.mc.web.programs.front.biz005.impl;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mc.web.programs.front.biz005.Biz005DAO;
import com.mc.web.programs.front.biz005.Biz005Service;

/**
 *
 * @Description : 판로개척지원 프로그램 서비스 구현
 * @ClassName   : com.mc.web.programs.biz005.impl.Biz005ServiceImpl.java
 * @Modification Information
 *
 * @author MSLK_JJS
 * @since 2018. 3. 29.
 * @version 1.0 *  
 * Copyright (C)  All right reserved.
 */
@Service
public class Biz005ServiceImpl implements Biz005Service {
	
	@Autowired
	private Biz005DAO dao;
	
	public String intro(Map<String, String> params) throws Exception {
		return "programs/biz005/intro";
	}
	
}
