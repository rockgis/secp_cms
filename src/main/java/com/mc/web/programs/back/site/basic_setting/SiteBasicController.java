package com.mc.web.programs.back.site.basic_setting;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import net.sf.json.JSONObject;

/**
 *
 * @Description : 사이트 기본 설정
 * @ClassName   : com.mc.web.programs.back.site.basic_setting.SiteBasicController.java
 * @Modification Information
 *
 * @author 이창기
 * @since 2017. 3. 29.
 * @version 1.0 *  
 * Copyright (C)  All right reserved.
 */
@Controller
public class SiteBasicController {
	
	@Autowired
	private SiteBasicService service;
	
	@ResponseBody
	@RequestMapping("/super/site/basic_setting/view.do")
	public Map view(HttpServletRequest request, HttpSession session,  @RequestParam Map<String, String> params) throws Exception{
		return service.basic_view(params);
	}
	
	@ResponseBody
	@RequestMapping(value="/super/site/basic_setting/modify.do", method=RequestMethod.POST)
	@Transactional(rollbackFor = { Exception.class })
	public Map modify(HttpServletRequest request, HttpSession session,  @RequestParam Map<String, String> params) throws Exception{
		return service.basic_modify(params);
	}
	
	@ResponseBody
	@RequestMapping("/super/site/basic_setting/clear_chche.do")
	public Map clear_chche(HttpServletRequest request, HttpSession session,  @RequestParam Map<String, String> params) throws Exception{
		return service.clear_chche(params);
	}
}
