package com.mc.web.programs.front.bizmaster.impl;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mc.web.programs.front.bizmaster.BizmasterDAO;
import com.mc.web.programs.front.bizmaster.BizmasterService;

/**
 *
 * @Description : 지원사업 관리 프로그램 서비스 구현
 * @ClassName   : com.mc.web.programs.bizmaster.impl.BizmasterServiceImpl.java
 * @Modification Information
 *
 * @author MSLK_JJS
 * @since 2018. 3. 29.
 * @version 1.0 *  
 * Copyright (C)  All right reserved.
 */
@Service
public class BizmasterServiceImpl implements BizmasterService {
	
	@Autowired
	private BizmasterDAO dao;
	
	public String intro(Map<String, String> params) throws Exception {
		return "programs/bizmaster/intro";
	}
	
}
