package com.mc.web.programs.back.phistory;

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
 * @Description : 페이지이력 프로그램 컨트롤러
 * @ClassName   : com.mc.web.programs.back.phistory.AdminPhistoryController.java
 * @Modification Information
 *
 * @author sdlck
 * @since 2018. 3. 29.
 * @version 1.0 *  
 * Copyright (C)  All right reserved.
 */
@Controller
public class AdminPhistoryController {
	
	@Autowired
	private AdminPhistoryService service; 
	
	@ResponseBody
	@RequestMapping("/super/phistory/list.do")
	public Map index(@RequestParam Map<String, String> params, HttpServletRequest request, HttpSession session) throws Exception{
		return service.list(params);
	}
	
	@ResponseBody
	@RequestMapping("/super/phistory/write.do")
	@Transactional(rollbackFor = { Exception.class })
	public Map write(@RequestParam Map<String, Object> jsonObject) throws Exception{
		Map params = (JSONObject) JSONValue.parse((String)jsonObject.get("jData"));	//JSON으로 보내준 데이터를 사용
		return service.write(params);
	}
	
	@ResponseBody
	@RequestMapping("/super/phistory/view.do")
	@Transactional(rollbackFor = { Exception.class })
	public Map view(HttpServletRequest request, HttpSession session,  @RequestParam Map<String, String> params) throws Exception{
		return service.view(params);
	}
	
	@ResponseBody
	@RequestMapping("/super/phistory/modify.do")
	@Transactional(rollbackFor = { Exception.class })
	public Map modify(@RequestParam Map<String, Object> jsonObject) throws Exception{
		Map params = (JSONObject) JSONValue.parse((String)jsonObject.get("jData"));	//JSON으로 보내준 데이터를 사용
		return service.modify(params);
	}
	
	@ResponseBody
	@RequestMapping("/super/phistory/del.do")
	@Transactional(rollbackFor = { Exception.class })
	public Map del(HttpServletRequest request, HttpSession session,  @RequestParam Map<String, String> params) throws Exception{
		return service.del(params);
	}
}
