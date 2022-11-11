package com.mc.web.programs.back.biz007;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 *
 * @Description : 청년상인육성지원 프로그램 컨트롤러
 * @ClassName   : com.mc.web.programs.back.biz007.AdminBiz007Controller.java
 * @Modification Information
 *
 * @author MSLK_JJS
 * @since 2018. 3. 29.
 * @version 1.0 *  
 * Copyright (C)  All right reserved.
 */
@Controller
public class AdminBiz007Controller {
	
	@Autowired
	private AdminBiz007Service service;

	@RequestMapping(value="/super/homepage/biz007/index.do")
	public String list(@RequestParam Map<String, String> params, ModelMap model) throws Exception{
		//return service.test(params);
		//model.addAttribute("list", service.list(params));
		return "super/homepage/biz007/indexA01";
	}


	@RequestMapping(value="/super/homepage/biz007/indexB01.do")
	public String indexB01(@RequestParam Map<String, String> params, ModelMap model) throws Exception{
		//return service.test(params);
		//model.addAttribute("list", service.list(params));
		return "super/homepage/biz007/indexB01";
	}


	@RequestMapping(value="/super/homepage/biz007/indexC01.do")
	public String indexC01(@RequestParam Map<String, String> params, ModelMap model) throws Exception{
		//return service.test(params);
		//model.addAttribute("list", service.list(params));
		return "super/homepage/biz007/indexC01";
	}


	@RequestMapping(value="/super/homepage/biz007/indexD01.do")
	public String indexD01(@RequestParam Map<String, String> params, ModelMap model) throws Exception{
		//return service.test(params);
		//model.addAttribute("list", service.list(params));
		return "super/homepage/biz007/indexD01";
	}
}
