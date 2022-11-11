package com.mc.web.programs.front.intro.impl;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mc.web.programs.front.intro.IntroDAO;
import com.mc.web.programs.front.intro.IntroService;

/**
 *
 * @Description : 포털 소개 프로그램 서비스 구현
 * @ClassName   : com.mc.web.programs.intro.impl.IntroServiceImpl.java
 * @Modification Information
 *
 * @author khkim
 * @since 2018. 3. 29.
 * @version 1.0 *  
 * Copyright (C)  All right reserved.
 */
@Service
public class IntroServiceImpl implements IntroService {
	
	@Autowired
	private IntroDAO dao;
	
	public String index(Map<String, String> params) throws Exception {
		return "programs/intro/index";
	}
	
	public String bizIntro(Map<String, String> params) throws Exception {
		return "programs/intro/bizIntro";
	}
	
	public String siteGuide(Map<String, String> params) throws Exception {
		return "programs/intro/siteGuide";
	}
	
}
