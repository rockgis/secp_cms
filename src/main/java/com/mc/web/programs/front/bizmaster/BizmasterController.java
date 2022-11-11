package com.mc.web.programs.front.bizmaster;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

/**
 *
 * @Description : 지원사업 관리 프로그램 컨트롤러
 * @ClassName   : com.mc.web.programs.bizmaster.BizmasterController.java
 * @Modification Information
 *
 * @author MSLK_JJS
 * @since 2018. 3. 29.
 * @version 1.0 *  
 * Copyright (C)  All right reserved.
 */
@Controller
public class BizmasterController {
	
	@Autowired
	private BizmasterService service;
	
	@RequestMapping(value="/bizmaster/intro.do")
	public String intro(HttpServletRequest request, @RequestParam Map<String, String> params) throws Exception{
		return service.intro(params);
	}
}
