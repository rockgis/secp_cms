package com.mc.web.programs.front.biz003.impl;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mc.web.programs.front.biz003.Biz003DAO;
import com.mc.web.programs.front.biz003.Biz003Service;

/**
 *
 * @Description : 소상공인사업정리 (철거지원) 프로그램 서비스 구현
 * @ClassName   : com.mc.web.programs.biz003.impl.Biz003ServiceImpl.java
 * @Modification Information
 *
 * @author MSLK_JJS
 * @since 2018. 3. 29.
 * @version 1.0 *  
 * Copyright (C)  All right reserved.
 */
@Service
public class Biz003ServiceImpl implements Biz003Service {
	
	@Autowired
	private Biz003DAO dao;
	
	public String intro(Map<String, String> params) throws Exception {
		return "programs/biz003/intro";
	}
	
}
