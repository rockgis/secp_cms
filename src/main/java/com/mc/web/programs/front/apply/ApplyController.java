package com.mc.web.programs.front.apply;

import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.ObjectMapper;

/**
 *
 * @Description : 온라인 접수 프로그램 컨트롤러
 * @ClassName   : com.mc.web.programs.apply.ApplyController.java
 * @Modification Information
 *
 * @author khkim
 * @since 2018. 3. 29.
 * @version 1.0 *  
 * Copyright (C)  All right reserved.
 */
@Controller
@RequestMapping(value="/apply")
public class ApplyController {
	
	@Autowired
	private ApplyService service;
	
	/**
	 * 온라인 접수 목록 페이지
	 * @param request
	 * @param params
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/list.do", method=RequestMethod.GET)
	public String list(HttpServletRequest request, @RequestParam Map<String, String> params) throws Exception{
		return service.list(params);
	}
	
	/**
	 * 온라인 접수 지원사업 리스트 데이터
	 * @param request
	 * @param params
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/get-list.do", method=RequestMethod.POST)
	@ResponseBody
	public List<Map<String, Object>> getListData(HttpServletRequest request, @RequestParam Map<String, Object> params) throws Exception {
		return service.getListData(params);
	}
	
	/**
	 * 개인 지원사업 데이터 1 건 조회
	 * @param request
	 * @param params
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/indvdl-get.do", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> selectIndvdlApply(HttpSession session, HttpServletRequest request, @RequestParam Map<String, Object> params) throws Exception {
		params.put("userId", session.getAttribute("id"));
		return service.indvdlSelectOne(params);
	}
	
	/**
	 * 개인 지원사업 저장
	 * @param request
	 * @param params
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/indvdl-save.do", method=RequestMethod.POST)
	@ResponseBody
	//public Map<String, Object> indvdlApplySave(HttpServletRequest request, @RequestParam Map<String, Object> params, List<MultipartFile> attachList) throws Exception {
	public Map<String, Object> indvdlApplySave(HttpSession session, HttpServletRequest request, @RequestParam Map<String, Object> params, MultipartHttpServletRequest mpr) throws Exception {
		System.out.println("ApplyController In!!!");
		params.put("userId", session.getAttribute("id"));
		//if ("I".equals(params.get("saveType"))) {
			return service.indvdlInsert(params, mpr);
		//} else {
		//	return service.indvdlUpdate(params);
		//}
	}
	
	/**
	 * 단체 지원사업 데이터 1 건 조회
	 * @param request
	 * @param params
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/grp-get.do", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> selectGrpApply(HttpSession session, HttpServletRequest request, @RequestParam Map<String, Object> params) throws Exception {
		params.put("userId", session.getAttribute("id"));
		return service.grpSelectOne(params);
	}
	
	/**
	 * 단체 지원사업 저장
	 * @param request
	 * @param params
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/grp-save.do", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> grpApplySave(HttpServletRequest request, @RequestParam Map<String, Object> params) throws Exception {
		if ("I".equals(params.get("saveType"))) {
			return service.grpInsert(params);
		} else {
			return service.grpUpdate(params);
		}
	}
	
	/**
	 * 간편접수 이용동의 페이지
	 * @param request
	 * @param params
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/apply-easy.do", method=RequestMethod.GET)
	public String applyEasy(HttpServletRequest request, @RequestParam Map<String, Object> params) throws Exception{
		return service.applyEasy(params);
	}
	
	/**
	 * 간편접수 본인인증 페이지
	 * @param request
	 * @param params
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/easy/self-auth.do", method=RequestMethod.GET)
	public String applyEasySelfAuth(HttpServletRequest request, @RequestParam Map<String, Object> params) throws Exception {
		return service.applyEasySelfAuth(params);
	}
	
	/**
	 * 간편접수 필수 자격 확인 입력 페이지
	 * @param request
	 * @param params
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/easy/prvlg.do", method=RequestMethod.GET)
	public String applyEasyPrvlg(HttpServletRequest request, @RequestParam Map<String, Object> params) throws Exception {
		return service.applyEasyPrvlg(params);
	}
	
	/**
	 * 간편접수 필수 자격 확인 로딩 페이지
	 * @param request
	 * @param params
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/easy/mydata-req.do", method=RequestMethod.GET)
	public String applyEasyMydataReqPage(HttpServletRequest request, @RequestParam Map<String, Object> params) throws Exception {
		return service.applyEasyMydataReqPage(params);
	}
	
	/**
	 * kcp 본인인증 실패 URL
	 * @param session
	 * @param request
	 * @param params
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/easy/kcp-fail.do", method=RequestMethod.GET)
	public String kcpFail(HttpSession session, HttpServletRequest request, @RequestParam Map<String, Object> params) throws Exception {
		return "programs/member/kcpAuthFail";
	}
	
	/**
	 * kcp 본인인증 성공 URL
	 * @param session
	 * @param request
	 * @param params
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/easy/kcp-success.do", method=RequestMethod.GET)
	public String kcpSuccess(HttpSession session, HttpServletRequest request, @RequestParam Map<String, Object> params) throws Exception {
		return "programs/member/kcpAuthSuccess";
	}
}
