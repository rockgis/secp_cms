package com.mc.web.programs.back.analytics;

import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * 
 * @Description : 페이지 접속 통계
 * @ClassName   : com.mc.web.programs.back.reserve.AnalyticsController.java
 * @author 이창기
 * @since 2015. 6. 21.
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
public class AnalyticsController {
	
	@Autowired
	private AnalyticsService service;
	
	@ResponseBody
	@RequestMapping("/analytics/history.do")
	public String add_weblog(@RequestParam Map<String, String> params) throws Exception{
		return service.add_weblog(params);
	}
	
	@ResponseBody
	@RequestMapping("/super/analytics/intro.do")
	public Map intro(@RequestParam Map<String, String> params) throws Exception{
		return service.intro(params);
	}
	
	@ResponseBody
	@RequestMapping("/super/analytics/day.do")
	public Map day(@RequestParam Map<String, String> params) throws Exception{
		return service.day(params);
	}
	
	@ResponseBody
	@RequestMapping("/super/analytics/time.do")
	public Map time(@RequestParam Map<String, String> params) throws Exception{
		return service.time(params);
	}
	
	@ResponseBody
	@RequestMapping("/super/analytics/browser.do")
	public Map browser(@RequestParam Map<String, String> params) throws Exception{
		return service.browser(params);
	}
	
	@ResponseBody
	@RequestMapping("/super/analytics/os.do")
	public Map os(@RequestParam Map<String, String> params) throws Exception{
		return service.os(params);
	}
	
	@ResponseBody
	@RequestMapping("/super/analytics/page.do")
	public Map page(@RequestParam Map<String, String> params) throws Exception{
		return service.page(params);
	}

	@ResponseBody
	@RequestMapping("/super/analytics/execeldown.do")
	public String execeldown(HttpServletResponse res, @RequestParam Map<String, String> params) throws Exception{
		return service.execeldown(res, params);
	}
}