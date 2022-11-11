package com.mc.web.programs.back.code;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * 
 * @Description : 관리자 코드관리 
 * @ClassName   : com.mc.web.programs.back.code.CodeController.java
 * @author 이창기
 * @since 2015. 6. 02.
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
public class CodeController {
	Logger log = Logger.getLogger(this.getClass());
	
	@Autowired
	private CodeService service;

	@ResponseBody
	@RequestMapping("/super/code/list.do")
	public Map index(@RequestParam Map<String, String> params, HttpServletRequest request, HttpSession session) throws Exception{
		return service.list(params);
	}
	
	@ResponseBody
	@RequestMapping("/super/code/group_write.do")
	@Transactional(rollbackFor = { Exception.class })
	public Map group_write(HttpServletRequest request, HttpSession session,  @RequestParam Map<String, String> params) throws Exception{
		return service.group_write(params);
	}
	
	@ResponseBody
	@RequestMapping("/super/code/group_modify.do")
	@Transactional(rollbackFor = { Exception.class })
	public Map group_modify(HttpServletRequest request, HttpSession session,  @RequestParam Map<String, String> params) throws Exception{
		return service.group_modify(params);
	}
	
	@ResponseBody
	@RequestMapping("/super/code/code_write.do")
	@Transactional(rollbackFor = { Exception.class })
	public Map code_write(HttpServletRequest request, HttpSession session,  @RequestParam Map<String, String> params) throws Exception{
		return service.code_write(params);
	}
	
	@ResponseBody
	@RequestMapping("/super/code/code_modify.do")
	@Transactional(rollbackFor = { Exception.class })
	public Map code_modify(HttpServletRequest request, HttpSession session,  @RequestParam Map<String, String> params) throws Exception{
		return service.code_modify(params);
	}
	
	@ResponseBody
	@RequestMapping("/super/code/group_del.do")
	@Transactional(rollbackFor = { Exception.class })
	public Map group_del(HttpServletRequest request, HttpSession session,  @RequestParam Map<String, String> params) throws Exception{
		return service.group_del(params);
	}
	
	@ResponseBody
	@RequestMapping("/super/code/code_del.do")
	@Transactional(rollbackFor = { Exception.class })
	public Map code_del(HttpServletRequest request, HttpSession session,  @RequestParam Map<String, String> params) throws Exception{
		return service.code_del(params);
	}

	@ResponseBody
	@RequestMapping("/code/updateOrder.do")	
	@Transactional(rollbackFor = { Exception.class })
	public Map updateCodeOrderSeq(ModelMap model, HttpServletRequest request, HttpSession session, @RequestParam Map<String, Object> jsonObject) throws Exception {
		Map params = (JSONObject) JSONValue.parse((String)jsonObject.get("jData"));	//JSON으로 보내준 데이터를 사용
		return service.updateCodeOrderSeq(params);
	}
}
