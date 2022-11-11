package com.mc.web.programs.front.biz004;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.mc.web.programs.front.apply.ApplyService;

/**
 *
 * @Description : 소상공인사업정리 (컨설팅 지원) 프로그램 컨트롤러
 * @ClassName   : com.mc.web.programs.biz004.Biz004Controller.java
 * @Modification Information
 *
 * @author MSLK_JJS
 * @since 2018. 3. 29.
 * @version 1.0 *  
 * Copyright (C)  All right reserved.
 */
@Controller
public class Biz004Controller {
	
	@Autowired
	private Biz004Service service;
	
	@Autowired
	private ApplyService applyService;
	
	
	@RequestMapping(value="/biz004/intro.do")
	public String intro(HttpServletRequest request, @RequestParam Map<String, String> params) throws Exception{
		return service.intro(params);
	}
	
	/**
	 * 신청 페이지
	 * @param request
	 * @param params
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/apply/biz004/index.do", method=RequestMethod.GET)
	public ModelAndView ptmEnv(HttpServletRequest request, @RequestParam Map<String, Object> params, ModelAndView model) throws Exception{
String isAgree = applyService.isAgree(params);
		
		String applyType = params.get("applyType") == null ? "ONLINE" : params.get("applyType").toString(); 		// 온라인접수 또는 마이데이터
		String bizYr = params.get("bizYr") == null ? "" : params.get("bizYr").toString(); 							// 지원사업 키: 사업년도
		String bizNo = params.get("bizNo") == null ? "" : params.get("bizNo").toString(); 							// 지원사업 키: 사업번호
		String bizCycl = params.get("bizCycl") == null ? "" : params.get("bizCycl").toString(); 					// 지원사업 키: 사업차수
		String rceptSn = params.get("rceptSn") == null ? "" : params.get("rceptSn").toString(); 							// 지원사업 키: 사업일련번호
		String indvdlGrpSeCd = params.get("indvdlGrpSeCd") == null ? "" : params.get("indvdlGrpSeCd").toString(); 	// 개인접수 또는 단체접수 구분 코드
		
		model.addObject("applyType", applyType);
		model.addObject("bizYr", bizYr);
		model.addObject("bizNo", bizNo);
		model.addObject("bizCycl", bizCycl);
		model.addObject("rceptSn", rceptSn);
		model.addObject("indvdlGrpSeCd", indvdlGrpSeCd);
		model.addObject("isAgree", isAgree);
	//	model.setViewName(applyService.bizClose(params));
		model.setViewName("programs/biz004/index");

		return model;
	}
}
