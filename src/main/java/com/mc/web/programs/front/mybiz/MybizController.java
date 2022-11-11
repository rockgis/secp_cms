package com.mc.web.programs.front.mybiz;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 *
 * @Description : 나의 신청 현황 프로그램 컨트롤러
 * @ClassName   : com.mc.web.programs.mybiz.MybizController.java
 * @Modification Information
 *
 * @author khkim
 * @since 2018. 3. 29.
 * @version 1.0 *  
 * Copyright (C)  All right reserved.
 */
@Controller
@RequestMapping(value="/mybiz")
public class MybizController {
	
	@Autowired
	private MybizService service;
	
	/**
	 * 나의 신청 현황
	 * @param request
	 * @param params
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/index.do", method=RequestMethod.GET)
	public String index(HttpServletRequest request, @RequestParam Map<String, String> params) throws Exception{
		return service.index(params);
	}
	
	/**
	 * 지원사업 리스트 조회
	 * @param request
	 * @param params
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/get-biz-list.do", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getBizList(HttpSession session, HttpServletRequest request, @RequestParam Map<String, Object> params) throws Exception {
		params.put("userId", session.getAttribute("id"));
		return service.getBizList(params);
	}
	
	@RequestMapping(value="/popup/biz-giveup.do", method=RequestMethod.GET)
	public String bizGiveUpPopup(HttpServletRequest request, @RequestParam Map<String, String> params) throws Exception{
		return service.bizGiveUpPopup(params);
	}
	
	@RequestMapping(value="/popup/biz-chng.do", method=RequestMethod.GET)
	public String bizChngPopup(HttpServletRequest request, @RequestParam Map<String, String> params) throws Exception{
		return service.bizChngPopup(params);
	}
	
	@RequestMapping(value="/popup/cmplt-rpt.do", method=RequestMethod.GET)
	public String cmpltRptPopup(HttpServletRequest request, @RequestParam Map<String, String> params) throws Exception{
		return service.cmpltRptPopup(params);
	}
	
	@RequestMapping(value="/popup/pymt-form.do", method=RequestMethod.GET)
	public String pymtFormPopup(HttpServletRequest request, @RequestParam Map<String, String> params) throws Exception{
		return service.pymtFormPopup(params);
	}
	
	@RequestMapping(value="/popup/{bizKey}/give-up.do", method=RequestMethod.GET)
	public String mybizPopup(HttpSession session, HttpServletRequest request, @RequestParam Map<String, String> params, @PathVariable(name="bizKey") String bizKey) throws Exception {
		String dist = "";
		if ("202311".equals(bizKey)) {
			dist = "programs/mybiz/biz001/bizGiveUp";
		}
		return dist;
	}
}
