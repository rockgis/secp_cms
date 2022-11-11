package com.mc.web.programs.back.permit;

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
 * @Description : 권한등록관리
 * @ClassName   : com.mc.web.programs.back.permit.PermitController.java
 * @author 이창기
 * @since 2016. 6. 16.
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
public class PermitController {
	
	@Autowired
	private PermitService service;

	@ResponseBody
	@RequestMapping("/super/permit/list.do")
	public Map index(@RequestParam Map<String, String> params, HttpServletRequest request, HttpSession session) throws Exception{
		return service.list(params);
	}
	
	@ResponseBody
	@RequestMapping("/super/permit/menu_list.do")
	public List menu_list(@RequestParam Map<String, String> params, HttpServletRequest request, HttpSession session) throws Exception{
		return service.menu_list(params);
	}
	
	@ResponseBody
	@RequestMapping("/super/permit/write.do")
	@Transactional(rollbackFor = { Exception.class })
	public Map write(HttpServletRequest request, HttpSession session, @RequestParam Map<String, Object> jsonObject) throws Exception{
		Map params = (JSONObject) JSONValue.parse((String)jsonObject.get("jData"));	//JSON으로 보내준 데이터를 사용
		return service.write(params);
	}
	
	@ResponseBody
	@RequestMapping("/super/permit/view.do")
	@Transactional(rollbackFor = { Exception.class })
	public Map view(HttpServletRequest request, HttpSession session,  @RequestParam Map<String, String> params) throws Exception{
		return service.view(params);
	}
	
	@ResponseBody
	@RequestMapping("/super/permit/modify.do")
	@Transactional(rollbackFor = { Exception.class })
	public Map modify(HttpServletRequest request, HttpSession session,  @RequestParam Map<String, Object> jsonObject) throws Exception{
		Map params = (JSONObject) JSONValue.parse((String)jsonObject.get("jData"));	//JSON으로 보내준 데이터를 사용
		return service.modify(params);
	}
	
	@ResponseBody
	@RequestMapping("/super/permit/del.do")
	@Transactional(rollbackFor = { Exception.class })
	public Map del(HttpServletRequest request, HttpSession session,  @RequestParam Map<String, String> params) throws Exception{
		return service.del(params);
	}
	
}
