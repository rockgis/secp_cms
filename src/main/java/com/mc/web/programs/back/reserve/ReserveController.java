package com.mc.web.programs.back.reserve;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.json.simple.JSONValue;
import org.jsoup.Connection.Request;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * 
 * @Description : 예약 업데이트 관리
 * @ClassName   : com.mc.web.programs.back.reserve.IpCheckController.java
 * @author 이창기
 * @since 2015. 6. 15.
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
public class ReserveController {
	
	@Autowired
	private ReserveService service;

	@ResponseBody
	@RequestMapping("/super/reserve/list.do")
	public Map index(@RequestParam Map<String, String> params, HttpServletRequest request, HttpSession session) throws Exception{
		return service.list(params);
	}
	
	@ResponseBody
	@RequestMapping(value="/super/reserve/del.do", method=RequestMethod.POST)
	@Transactional(rollbackFor = { Exception.class })
	public Map del(HttpServletRequest request, HttpSession session,  @RequestParam Map<String, String> params) throws Exception{
		return service.del(params);
	}
	
	@ResponseBody
	@RequestMapping(value="/super/reserve/write_reserve.do", method=RequestMethod.POST)
	public Map write_reserve(HttpServletRequest request, HttpSession session, @RequestParam Map<String, Object> jsonObject) throws Exception{
		Map params = (JSONObject) JSONValue.parse((String)jsonObject.get("jData"));	//JSON으로 보내준 데이터를 사용
		return service.write_reserve(params);
	}

	@ResponseBody
	@RequestMapping(value="/super/reserve/modify_reserve.do", method=RequestMethod.POST)
	public Map modify_reserve(HttpServletRequest request, HttpSession session, @RequestParam Map<String, Object> jsonObject) throws Exception{
		Map params = (JSONObject) JSONValue.parse((String)jsonObject.get("jData"));	//JSON으로 보내준 데이터를 사용
		return service.modify_reserve(params);
	}
	
	@ResponseBody
	@RequestMapping(value="/super/reserve/write_bbs_reserve.do", method=RequestMethod.POST)
	public Map write_bbs_reserve(HttpServletRequest request, HttpSession session, @RequestParam Map<String, Object> jsonObject) throws Exception{
		Map params = (JSONObject) JSONValue.parse((String)jsonObject.get("jData"));	//JSON으로 보내준 데이터를 사용
		return service.write_bbs_reserve(params);
	}
	
}
