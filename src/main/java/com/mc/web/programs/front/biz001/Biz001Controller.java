package com.mc.web.programs.front.biz001;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.mc.web.programs.front.apply.ApplyService;

/**
*
* @Description : 경영환경개선 프로그램 컨트롤러
* @ClassName   : com.mc.web.programs.biz002.Biz001Controller.java
* @Modification Information
*
* @author MSLK_JJS
* @since 2018. 3. 29.
* @version 1.0 *  
* Copyright (C)  All right reserved.
*/
@Controller
public class Biz001Controller {
	
	@Autowired
	private Biz001Service service;
	
	@Autowired
	private ApplyService applyService;
	
	/**
	 * 신청 페이지
	 * @param request
	 * @param params
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/apply/biz001/index.do", method=RequestMethod.GET)
	public ModelAndView index(HttpSession session, HttpServletRequest request, @RequestParam Map<String, Object> params, ModelAndView model) throws Exception{
		// 개인정보 이용동의 여부 확인
		params.put("userId", session.getAttribute("id"));
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
		model.setViewName("programs/biz001/index");
		return model;
	}
	
	/**
	 * 포기신청 팝업
	 * @param session
	 * @param request
	 * @param params
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/mybiz/biz001/popup/give-up.do", method=RequestMethod.GET)
	public ModelAndView popupGiveup(HttpSession session, HttpServletRequest request, @RequestParam Map<String, Object> params, ModelAndView model) throws Exception {
		model.setViewName("programs/mybiz/popup/biz001/bizGiveup");
		return model;
	}
	
	/**
	 * 포기신청: 변경관리 테이블 insert
	 * @param session
	 * @param request
	 * @param params
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/mybiz/biz001/give-up.do", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> submitGiveup(HttpSession session, HttpServletRequest request, @RequestParam Map<String, Object> params, ModelAndView model) throws Exception {
		params.put("userId", session.getAttribute("id"));
		
		// 사업마다 고정 값을 가지고 있음.
		params.put("bizYr", "2023");
		params.put("bizNo", "1");
		params.put("bizCycl", "1");
		
		return service.submitGiveup(params);
	}
}
