package com.mc.web.programs.back.site.layout_setting;

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
 * @Description : 레이아웃 구성설정
 * @ClassName   : com.mc.web.programs.back.site.layout_setting.LayoutSettingController.java
 * @Modification Information
 *
 * @author 이창기
 * @since 2017. 5. 12.
 * @version 1.0 *  
 * Copyright (C)  All right reserved.
 */
@Controller
public class LayoutSettingController {
	
	@Autowired
	private LayoutSettingService service;
	
	@ResponseBody
	@RequestMapping("/super/site/layout_setting/list.do")
	public Map list(HttpServletRequest request, HttpSession session,  @RequestParam Map<String, String> params) throws Exception{
		return service.layout_list(params);
	}
	
	@ResponseBody
	@RequestMapping("/super/site/layout_setting/modify.do")
	@Transactional(rollbackFor = { Exception.class })
	public Map modify(HttpServletRequest request, HttpSession session,  @RequestParam Map<String, String> jsonObject) throws Exception{
		Map params = (JSONObject) JSONValue.parse((String)jsonObject.get("jData"));	//JSON으로 보내준 데이터를 사용
		return service.layout_insert(params);
	}
}
