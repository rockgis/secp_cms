package com.mc.web.programs.back.bbs.{{BOARD_TYPE}};

import java.util.List;
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
 *
 * @Description : {{BOARD_TYPE}} 타입 게시판관리
 * @ClassName   : com.mc.web.programs.back.bbs.AdminBbs{{BOARD_TYPE}}Controller.java
 * @Modification Information
 *
 * @author {{USER_NAME}}
 * @since 2017. 3. 3.
 * @version 1.0 *  
 * Copyright (C)  All right reserved.
 */
@Controller
@RequestMapping(value="/super/bbs/{{BOARD_TYPE}}")
public class AdminBbs{{BOARD_TYPE}}Controller {
	
	@Autowired
	private AdminBbs{{BOARD_TYPE}}Service service;
	
	@ResponseBody
	@RequestMapping("/list.do")
	public Map index(@RequestParam Map<String, String> params, HttpServletRequest request, HttpSession session) throws Exception{
		return service.list(params);
	}
	
	@ResponseBody
	@RequestMapping("/write.do")
	@Transactional(rollbackFor = { Exception.class })
	public Map write(@RequestParam Map<String, Object> jsonObject) throws Exception{
		Map params = (JSONObject) JSONValue.parse((String)jsonObject.get("jData"));	//JSON으로 보내준 데이터를 사용
		return service.write(params);
	}
	
	@ResponseBody
	@RequestMapping("/modify.do")
	@Transactional(rollbackFor = { Exception.class })
	public Map modify(@RequestParam Map<String, Object> jsonObject) throws Exception{
		Map params = (JSONObject) JSONValue.parse((String)jsonObject.get("jData"));	//JSON으로 보내준 데이터를 사용
		return service.modify(params);
	}
	
	@ResponseBody
	@RequestMapping("/view.do")
	public Map view(@RequestParam Map<String, String> params) throws Exception{
		return service.view(params);
	}
	
}
