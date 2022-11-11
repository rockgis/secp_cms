package com.mc.web.programs.back.program;

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
 * @Description : 프로그램 관리
 * @ClassName   : com.mc.web.programs.back.program.ProgramController.java
 * @author 이창기
 * @since 2015. 6. 11.
 * @version 1.0 *
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일        수정자       수정내용
 *  -------       --------    ---------------------------
 * </pre>
 */
@Controller
public class ProgramController {
	
	@Autowired
	private ProgramService service;

	@ResponseBody
	@RequestMapping("/super/program/list.do")
	public Map list(@RequestParam Map<String, String> params, HttpServletRequest request, HttpSession session) throws Exception{
		return service.list(params);
	}
	
	@ResponseBody
	@RequestMapping("/super/program/menu_list.do")
	public Map menu_list(@RequestParam Map<String, String> params, HttpServletRequest request, HttpSession session) throws Exception{
		return service.menu_list(params);
	}
	
	@ResponseBody
	@RequestMapping("/super/program/write.do")
	@Transactional(rollbackFor = { Exception.class })
	public Map write(HttpServletRequest request, HttpSession session, @RequestParam Map<String, Object> jsonObject) throws Exception{
		Map params = (JSONObject) JSONValue.parse((String)jsonObject.get("jData"));	//JSON으로 보내준 데이터를 사용
		return service.write(params);
	}
	
	@ResponseBody
	@RequestMapping("/super/program/view.do")
	@Transactional(rollbackFor = { Exception.class })
	public Map view(HttpServletRequest request, HttpSession session,  @RequestParam Map<String, String> params) throws Exception{
		return service.view(params);
	}
	
	@ResponseBody
	@RequestMapping("/super/program/modify.do")
	@Transactional(rollbackFor = { Exception.class })
	public Map modify(HttpServletRequest request, HttpSession session, @RequestParam Map<String, Object> jsonObject) throws Exception{
		Map params = (JSONObject) JSONValue.parse((String)jsonObject.get("jData"));	//JSON으로 보내준 데이터를 사용
		return service.modify(params);
	}
	
	@ResponseBody
	@RequestMapping("/super/program/del.do")
	@Transactional(rollbackFor = { Exception.class })
	public Map del(HttpServletRequest request, HttpSession session,  @RequestParam Map<String, String> params) throws Exception{
		return service.del(params);
	}
	
}
