package com.mc.web.programs.back.bizmaster;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 *
 * @Description : 지원사업 관리 프로그램 컨트롤러
 * @ClassName   : com.mc.web.programs.back.bizmaster.AdminBizmasterController.java
 * @Modification Information
 *
 * @author MSLK_JJS
 * @since 2018. 3. 29.
 * @version 1.0 *  
 * Copyright (C)  All right reserved.
 */
@Controller
public class AdminBizmasterController {
	
	@Autowired
	private AdminBizmasterService service;
	
	@ResponseBody
	@RequestMapping(value="/super/bizmaster/test.do")
	public Map test(@RequestParam Map<String, String> params) throws Exception{
		return service.test(params);
	}
}
