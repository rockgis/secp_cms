package com.mc.web.programs.front.biz007.impl;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mc.web.programs.front.biz007.Biz007DAO;
import com.mc.web.programs.front.biz007.Biz007Service;

/**
 *
 * @Description : 청년상인육성지원 프로그램 서비스 구현
 * @ClassName   : com.mc.web.programs.biz007.impl.Biz007ServiceImpl.java
 * @Modification Information
 *
 * @author MSLK_JJS
 * @since 2018. 3. 29.
 * @version 1.0 *  
 * Copyright (C)  All right reserved.
 */
@Service
public class Biz007ServiceImpl implements Biz007Service {
	
	@Autowired
	private Biz007DAO dao;
	
	public String intro(Map<String, String> params) throws Exception {
		return "programs/biz007/intro";
	}
	
}
