package com.mc.web.programs.back.biz008;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 *
 * @Description : 명품점포 프로그램 컨트롤러
 * @ClassName   : com.mc.web.programs.back.biz008.AdminBiz008Controller.java
 * @Modification Information
 *
 * @author MSLK_JJS
 * @since 2018. 3. 29.
 * @version 1.0 *  
 * Copyright (C)  All right reserved.
 */
@Controller
public class AdminBiz008Controller {
	
	@Autowired
	private AdminBiz008Service service;

	@RequestMapping(value="/super/homepage/biz008/index.do")
	public String list(@RequestParam Map<String, String> params, ModelMap model) throws Exception{
		//return service.test(params);
		//model.addAttribute("list", service.list(params));
		return "super/homepage/biz008/indexA01";
	}


	@RequestMapping(value="/super/homepage/biz008/indexB01.do")
	public String indexB01(@RequestParam Map<String, String> params, ModelMap model) throws Exception{
		//return service.test(params);
		//model.addAttribute("list", service.list(params));
		return "super/homepage/biz008/indexB01";
	}


	@RequestMapping(value="/super/homepage/biz008/indexC01.do")
	public String indexC01(@RequestParam Map<String, String> params, ModelMap model) throws Exception{
		//return service.test(params);
		//model.addAttribute("list", service.list(params));
		return "super/homepage/biz008/indexC01";
	}


	@RequestMapping(value="/super/homepage/biz008/indexD01.do")
	public String indexD01(@RequestParam Map<String, String> params, ModelMap model) throws Exception{
		//return service.test(params);
		//model.addAttribute("list", service.list(params));
		return "super/homepage/biz008/indexD01";
	}
}
