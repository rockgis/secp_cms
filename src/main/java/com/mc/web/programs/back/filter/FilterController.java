package com.mc.web.programs.back.filter;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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
public class FilterController {
	
	@Autowired
	private FilterService service;
	
	@ResponseBody
	@RequestMapping("/super/filter/dashboardData.do")
	public Map dashboardData(HttpServletRequest request, HttpSession session,  @RequestParam Map<String, String> params) throws Exception{
		return service.dashboardData(params);
	}
	
	@ResponseBody
	@RequestMapping("/super/filter/daylistData.do")
	public Map daylistData(HttpServletRequest request, HttpSession session,  @RequestParam Map<String, String> params) throws Exception{
		return service.daylistData(params);
	}
	
	@ResponseBody
	@RequestMapping("/super/filter/menulistData.do")
	public Map menulistData(HttpServletRequest request, HttpSession session,  @RequestParam Map<String, String> params) throws Exception{
		return service.menulistData(params);
	}
	
	@ResponseBody
	@RequestMapping("/super/filter/settingList.do")
	public Map setting(HttpServletRequest request, HttpSession session,  @RequestParam Map<String, String> params) throws Exception{
		return service.setting(params);
	}

	@ResponseBody
	@RequestMapping("/super/filter/set_default_filter.do")
	@Transactional(rollbackFor = { Exception.class })
	public Map set_default_filter(HttpServletRequest request, HttpSession session, @RequestParam Map<String, Object> jsonObject) throws Exception{
		Map params = (JSONObject) JSONValue.parse((String)jsonObject.get("jData"));	//JSON으로 보내준 데이터를 사용
		return service.set_default_filter(params);
	}
	
	@ResponseBody
	@RequestMapping("/super/filter/set_menu_filter.do")
	@Transactional(rollbackFor = { Exception.class })
	public Map set_menu_filter(HttpServletRequest request, HttpSession session, @RequestParam Map<String, Object> jsonObject) throws Exception{
		Map params = (JSONObject) JSONValue.parse((String)jsonObject.get("jData"));	//JSON으로 보내준 데이터를 사용
		return service.set_menu_filter(params);
	}
	
	@ResponseBody
	@RequestMapping("/super/filter/set_each_filter.do")
	@Transactional(rollbackFor = { Exception.class })
	public Map set_each_filter(HttpServletRequest request, HttpSession session, @RequestParam Map<String, Object> jsonObject) throws Exception{
		Map params = (JSONObject) JSONValue.parse((String)jsonObject.get("jData"));	//JSON으로 보내준 데이터를 사용
		return service.set_each_filter(params);
	}
	
	@ResponseBody
	@RequestMapping("/super/filter/get_menu_filter.do")
	public Map get_menu_filter(HttpServletRequest request, HttpSession session, @RequestParam Map params) throws Exception{
		return service.get_menu_filter(params);
	}
	
	@ResponseBody
	@RequestMapping("/super/filter/modify.do")
	@Transactional(rollbackFor = { Exception.class })
	public Map modify(HttpServletRequest request, HttpSession session,  @RequestParam Map<String, String> params) throws Exception{
		return service.modify(params);
	}
	
	@ResponseBody
	@RequestMapping("/filter/check.do")
	public Map check(HttpServletRequest request, @RequestParam Map<String, String> params) throws Exception{
		return service.check(request, params);
	}
	
	@ResponseBody
	@RequestMapping("/filter/report_record.do")
	public Map report_record(HttpServletRequest request, @RequestParam Map<String, String> params) throws Exception{
		return service.report_record(params);
	}
	
	@ResponseBody
	@RequestMapping("/super/filter/reportList.do")
	public Map reportList(HttpServletRequest request, HttpSession session,  @RequestParam Map<String, String> params) throws Exception{
		return service.reportList(params); 
	}
	
	@ResponseBody
	@RequestMapping("/super/filter/report_excel.do")
	public String report_excel(HttpServletResponse res, @RequestParam Map<String, String> params) throws Exception{
		return service.report_excel(res, params);
	}
	
	@ResponseBody
	@RequestMapping("/super/filter/detailList.do")
	public Map detailList(HttpServletRequest request, HttpSession session,  @RequestParam Map<String, String> params) throws Exception{
		return service.detailList(params);
	}
	
	@ResponseBody
	@RequestMapping("/super/filter/detail_excel.do")
	public String detail_excel(HttpServletResponse res, @RequestParam Map<String, String> params) throws Exception{
		return service.detail_excel(res, params);
	}
}
