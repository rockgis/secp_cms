package com.mc.web.programs.front.biz008;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.mc.web.programs.front.apply.ApplyService;

/**
 *
 * @Description : 명품점포 프로그램 컨트롤러
 * @ClassName   : com.mc.web.programs.biz008.Biz008Controller.java
 * @Modification Information
 *
 * @author MSLK_JJS
 * @since 2018. 3. 29.
 * @version 1.0 *  
 * Copyright (C)  All right reserved.
 */
@Controller
public class Biz008Controller {
	
	@Autowired
	private Biz008Service service;
	
	@Autowired
	private ApplyService applyService;
	
	@RequestMapping(value="/biz008/intro.do")
	public String intro(HttpServletRequest request, @RequestParam Map<String, String> params) throws Exception{
		return service.intro(params);
	}
	
	@RequestMapping(value="/apply/biz008/index.do")
	public ModelAndView index(HttpServletRequest request, @RequestParam Map<String, Object> params, ModelAndView model) throws Exception {
		// 개인정보 이용동의 여부 확인
		String isAgree = applyService.isAgree(params);
		
		String applyType = params.get("applyType") == null ? "ONLINE" : params.get("applyType").toString(); 		// 온라인접수 또는 마이데이터
		String bizYr = params.get("bizYr") == null ? "" : params.get("bizYr").toString(); 							// 지원사업 키: 사업년도
		String bizNo = params.get("bizNo") == null ? "" : params.get("bizNo").toString(); 							// 지원사업 키: 사업번호
		String bizCycl = params.get("bizCycl") == null ? "" : params.get("bizCycl").toString(); 					// 지원사업 키: 사업차수
		String indvdlGrpSeCd = params.get("indvdlGrpSeCd") == null ? "" : params.get("indvdlGrpSeCd").toString(); 	// 개인접수 또는 단체접수 구분 코드
		
		model.addObject("applyType", applyType);
		model.addObject("bizYr", bizYr);
		model.addObject("bizNo", bizNo);
		model.addObject("bizCycl", bizCycl);
		model.addObject("indvdlGrpSeCd", indvdlGrpSeCd);
		model.addObject("isAgree", isAgree);
		model.setViewName("programs/biz008/index");
		return model;
	}
	
	/* 명품점포 인서트 테스트 */
	@RequestMapping(value="/apply/biz008/insert08.do", method=RequestMethod.POST)
	@ResponseBody
	public String boardInquiryRegister(HttpSession session, HttpServletRequest request, @RequestParam Map<String, Object> params, MultipartHttpServletRequest mpr) throws Exception{
		System.out.println("abcdabcdabcd In!!!");
		params.put("userId", session.getAttribute("id"));
		return service.myTest(params);
	}
	
}
