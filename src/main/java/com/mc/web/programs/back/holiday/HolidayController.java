package com.mc.web.programs.back.holiday;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * 
 * @Description : 공휴일 관리 
 * @ClassName   : com.mc.web.programs.back.holiday.HolidayController.java
 * @author 유민기
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
public class HolidayController {
	
	@Autowired
	private HolidayCheckService service;

	@ResponseBody
	@RequestMapping("/super/holiday/list.do")
	public Map index(@RequestParam Map<String, String> params, HttpServletRequest request, HttpSession session) throws Exception{
		return service.list(params);
	}
	
	@ResponseBody
	@RequestMapping("/super/holiday/write.do")
	@Transactional(rollbackFor = { Exception.class })
	public Map write(HttpServletRequest request, HttpSession session,  @RequestParam Map<String, String> params) throws Exception{
		return service.write(params);
	}
	
	@ResponseBody
	@RequestMapping("/super/holiday/view.do")
	@Transactional(rollbackFor = { Exception.class })
	public Map view(HttpServletRequest request, HttpSession session,  @RequestParam Map<String, String> params) throws Exception{
		return service.view(params);
	}
	
	@ResponseBody
	@RequestMapping("/super/holiday/modify.do")
	@Transactional(rollbackFor = { Exception.class })
	public Map modify(HttpServletRequest request, HttpSession session,  @RequestParam Map<String, String> params) throws Exception{
		return service.modify(params);
	}
	
	@ResponseBody
	@RequestMapping("/super/holiday/del.do")
	@Transactional(rollbackFor = { Exception.class })
	public Map del(HttpServletRequest request, HttpSession session,  @RequestParam Map<String, String> params) throws Exception{
		return service.del(params);
	}
	
}
