package com.mc.web.programs.front.biz007;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

/**
 *
 * @Description : 청년상인육성지원 프로그램 컨트롤러
 * @ClassName   : com.mc.web.programs.biz007.Biz007Controller.java
 * @Modification Information
 *
 * @author MSLK_JJS
 * @since 2018. 3. 29.
 * @version 1.0 *  
 * Copyright (C)  All right reserved.
 */
@Controller
public class Biz007Controller {
	
	@Autowired
	private Biz007Service service;
	
	@RequestMapping(value="/biz007/intro.do")
	public String intro(HttpServletRequest request, @RequestParam Map<String, String> params) throws Exception{
		return service.intro(params);
	}
}
