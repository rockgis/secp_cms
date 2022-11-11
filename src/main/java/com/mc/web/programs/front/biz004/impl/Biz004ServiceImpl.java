package com.mc.web.programs.front.biz004.impl;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mc.web.programs.front.biz004.Biz004DAO;
import com.mc.web.programs.front.biz004.Biz004Service;

/**
 *
 * @Description : 소상공인사업정리 (컨설팅 지원) 프로그램 서비스 구현
 * @ClassName   : com.mc.web.programs.biz004.impl.Biz004ServiceImpl.java
 * @Modification Information
 *
 * @author MSLK_JJS
 * @since 2018. 3. 29.
 * @version 1.0 *  
 * Copyright (C)  All right reserved.
 */
@Service
public class Biz004ServiceImpl implements Biz004Service {
	
	@Autowired
	private Biz004DAO dao;
	
	public String intro(Map<String, String> params) throws Exception {
		return "programs/biz004/intro";
	}
	
}
