package com.mc.web.programs.back.intro;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 *
 * @Description : 포털 소개 프로그램 컨트롤러
 * @ClassName   : com.mc.web.programs.back.intro.AdminIntroController.java
 * @Modification Information
 *
 * @author khkim
 * @since 2018. 3. 29.
 * @version 1.0 *  
 * Copyright (C)  All right reserved.
 */
@Controller
public class AdminIntroController {
	
	@Autowired
	private AdminIntroService service;
	
	@ResponseBody
	@RequestMapping(value="/super/intro/test.do")
	public Map test(@RequestParam Map<String, String> params) throws Exception{
		return service.test(params);
	}
}
