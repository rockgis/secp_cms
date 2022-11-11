package com.mc.web.programs.back.system;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

/**
 * 
 *
 * @Description : 
 * @ClassName   : com.mc.web.programs.back.system.HomepageController.java
 * @Modification Information
 *
 * @author 이창기
 * @since 2017. 5. 19.
 * @version 1.0 *  
 * Copyright (C)  All right reserved.
 */
@Controller
public class AdminSystemController {
	
	@Autowired
	private AdminSystemService service;
	
	@RequestMapping("/super/system/index.do")
	public String dashboard(@RequestParam Map<String, String> params, HttpServletRequest request, HttpSession session) throws Exception{
		return service.dashboard(params);
	}
	
	@RequestMapping("/super/system/system_info/index.do")
	public String system_info(@RequestParam Map<String, String> params, HttpServletRequest request, HttpSession session) throws Exception{
		return service.system_info(params);
	}
	
}
