package com.mc.web.programs.back.site.js_css;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.json.simple.JSONValue;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 *
 * @Description : 사이트 기본 설정
 * @ClassName   : com.mc.web.programs.back.site.basic_setting.JsCssController.java
 * @Modification Information
 *
 * @author 이창기
 * @since 2017. 3. 29.
 * @version 1.0 *  
 * Copyright (C)  All right reserved.
 */
@Controller
public class JsCssController {
	
	@Autowired
	private JsCssService service;
	
	@ResponseBody
	@RequestMapping("/super/site/js_css/js_css_main.do")
	public Map js_css_main(HttpServletRequest request, HttpSession session,  @RequestParam Map<String, String> params) throws Exception{
		return service.js_css_main(params);
	}
	
	@ResponseBody
	@RequestMapping("/super/site/js_css/js_css_list.do")
	public Map js_css_list(HttpServletRequest request, HttpSession session,  @RequestParam Map<String, String> params) throws Exception{
		return service.js_css_list(params);
	}
	
	@ResponseBody
	@RequestMapping("/super/site/js_css/js_css_get_item.do")
	public Map js_css_get_item(HttpServletRequest request, HttpSession session,  @RequestParam Map<String, String> params) throws Exception{
		return service.js_css_get_item(params);
	}
	
	@ResponseBody
	@RequestMapping("/super/site/js_css/js_css_write.do")
	@Transactional(rollbackFor = { Exception.class })
	public Map js_css_write(HttpServletRequest request, HttpSession session,  @RequestParam Map<String, Object> jsonObject) throws Exception{
		Map params = (JSONObject) JSONValue.parse((String)jsonObject.get("jData"));	//JSON으로 보내준 데이터를 사용
		return service.js_css_write(params);
	}
}
