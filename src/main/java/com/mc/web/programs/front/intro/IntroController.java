package com.mc.web.programs.front.intro;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

/**
 *
 * @Description : 포털 소개 프로그램 컨트롤러
 * @ClassName   : com.mc.web.programs.intro.IntroController.java
 * @Modification Information
 *
 * @author khkim
 * @since 2018. 3. 29.
 * @version 1.0 *  
 * Copyright (C)  All right reserved.
 */
@Controller
@RequestMapping(value="/intro")
public class IntroController {
	
	@Autowired
	private IntroService service;
	
	@RequestMapping(value="/index.do", method=RequestMethod.GET)
	public String index(HttpServletRequest request, @RequestParam Map<String, String> params) throws Exception{
		return service.index(params);
	}
	
	@RequestMapping(value="/biz-intro.do", method=RequestMethod.GET)
	public String bizIntro(HttpServletRequest request, @RequestParam Map<String, String> params) throws Exception{
		return service.bizIntro(params);
	}
	
	@RequestMapping(value="/site-guide.do", method=RequestMethod.GET)
	public String siteGuide(HttpServletRequest request, @RequestParam Map<String, String> params) throws Exception{
		return service.siteGuide(params);
	}
}
