package com.mc.web.programs.back.site;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.json.simple.JSONValue;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * 
 * @Description : 사이트 추가 관리
 * @ClassName   : com.mc.web.programs.back.satifaction.SatifactionController.java
 * @author 이창기
 * @since 2015. 6. 24.
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
public class SiteManagerController {
	
	@Autowired
	private SiteManagerService service;
	
	@RequestMapping("/super/site/index.do")
	public String dashboard(@RequestParam Map<String, String> params, HttpServletRequest request, HttpSession session) throws Exception{
		return service.dashboard(params);
	}
	
	@ResponseBody
	@RequestMapping("/super/site/list.do")
	public Map index(@RequestParam Map<String, String> params, HttpServletRequest request, HttpSession session) throws Exception{
		return service.list(params);
	}
	
	@ResponseBody
	@RequestMapping("/super/site/write.do")
	@Transactional(rollbackFor = { Exception.class })
	public Map write(HttpServletRequest request, HttpSession session, @RequestParam Map<String, Object> jsonObject) throws Exception{
		Map params = (JSONObject) JSONValue.parse((String)jsonObject.get("jData"));	//JSON으로 보내준 데이터를 사용
		return service.write(params);
	}
	
	@ResponseBody
	@RequestMapping("/super/site/view.do")
	@Transactional(rollbackFor = { Exception.class })
	public Map view(HttpServletRequest request, HttpSession session,  @RequestParam Map<String, String> params) throws Exception{
		return service.view(params);
	}
	
	@ResponseBody
	@RequestMapping(value="/super/site/modify.do", method=RequestMethod.POST)
	@Transactional(rollbackFor = { Exception.class })
	public Map modify(HttpServletRequest request, HttpSession session, @RequestParam Map<String, Object> jsonObject) throws Exception{
		Map params = (JSONObject) JSONValue.parse((String)jsonObject.get("jData"));	//JSON으로 보내준 데이터를 사용
		if("<p><br></p>".equals(params.get("footer_html")) == true) { //웹에디터에서 삭제시 잔여 HTML 존재
			params.put("footer_html",  "");
		}
		return service.modify(params);
	}
	
	@ResponseBody
	@RequestMapping("/super/site/del.do")
	@Transactional(rollbackFor = { Exception.class })
	public Map del(HttpServletRequest request, HttpSession session,  @RequestParam Map<String, String> params) throws Exception{
		return service.del(params);
	}
}
