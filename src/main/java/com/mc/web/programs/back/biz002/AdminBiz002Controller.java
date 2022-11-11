package com.mc.web.programs.back.biz002;

import java.util.List;
import java.util.Map;

import com.mc.web.MCMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

/**
 *
 * @Description : 소상공인사업정리(재기장려 지원) 프로그램 컨트롤러
 * @ClassName   : com.mc.web.programs.back.biz002.AdminBiz002Controller.java
 * @Modification Information
 *
 * @author MSLK_JJS
 * @since 2018. 3. 29.
 * @version 1.0 *  
 * Copyright (C)  All right reserved.
 */
@Controller
public class AdminBiz002Controller {
	
	@Autowired
	private AdminBiz002Service service;

	/**
	 * 소상공인사업정리(재기장려 지원)
	 * @param params
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/super/homepage/biz002/index.do")
	public String list(@RequestParam Map<String, String> params,ModelMap model) throws Exception{
		//return service.test(params);
		//model.addAttribute("list", service.list(params));
		return "super/homepage/biz002/index";
	}


	@RequestMapping(value="/super/homepage/biz002/indexB01.do")
	public String indexB01(@RequestParam Map<String, String> params, ModelMap model) throws Exception{
		//return service.test(params);
		//model.addAttribute("list", service.list(params));
		return "super/homepage/biz002/indexB01";
	}


	@RequestMapping(value="/super/homepage/biz002/indexC01.do")
	public String indexC01(@RequestParam Map<String, String> params, ModelMap model) throws Exception{
		//return service.test(params);
		//model.addAttribute("list", service.list(params));
		return "super/homepage/biz002/indexC01";
	}


	@RequestMapping(value="/super/homepage/biz002/indexD01.do")
	public String indexD01(@RequestParam Map<String, String> params, ModelMap model) throws Exception{
		//return service.test(params);
		//model.addAttribute("list", service.list(params));
		return "super/homepage/biz002/indexD01";
	}
}
