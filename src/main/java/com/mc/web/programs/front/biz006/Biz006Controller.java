package com.mc.web.programs.front.biz006;

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
 * @Description : 청년사관학교 프로그램 컨트롤러
 * @ClassName   : com.mc.web.programs.biz006.Biz006Controller.java
 * @Modification Information
 *
 * @author MSLK_JJS
 * @since 2018. 3. 29.
 * @version 1.0 *  
 * Copyright (C)  All right reserved.
 */
@Controller
public class Biz006Controller {
	
	@Autowired
	private Biz006Service service;
	
	//청년사관학교 insert Test시 사용
	@Autowired
	private ApplyService applyService;
	
	/**
	 * 신청 페이지
	 * @param request
	 * @param params
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/apply/biz006/index.do", method=RequestMethod.GET)
	public ModelAndView index(HttpSession session,HttpServletRequest request, @RequestParam Map<String, Object> params, ModelAndView model) throws Exception{
		//params - form에 input 태그 name , mpr - 첨부파일
		
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
		model.setViewName("programs/biz006/index");
		return model;
	}
	
	/**
	 * 청년사관학교 insert Test
	 * @param request
	 * @param params
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/apply/biz006/indvdl-save.do", method=RequestMethod.POST)
	@ResponseBody
	//public Map<String, Object> indvdlApplySave(HttpServletRequest request, @RequestParam Map<String, Object> params, List<MultipartFile> attachList) throws Exception {
	public Map<String, Object> insertTest(HttpSession session, HttpServletRequest request, @RequestParam Map<String, Object> params, MultipartHttpServletRequest mpr) throws Exception {
		System.out.println("청년사관학교 insert Test in!!!");
		params.put("userId", session.getAttribute("id"));
		//if ("I".equals(params.get("saveType"))) {
			return service.insertTest(params, mpr);
		//} else {
		//	return service.indvdlUpdate(params);
		//}
	}
}
