package com.mc.web.programs.front.biz002;

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
 * @Description : 소상공인사업정리(재기장려 지원) 프로그램 컨트롤러
 * @ClassName   : com.mc.web.programs.biz002.Biz002Controller.java
 * @Modification Information
 *
 * @author MSLK_JJS
 * @since 2018. 3. 29.
 * @version 1.0 *  
 * Copyright (C)  All right reserved.
 */
@Controller
public class Biz002Controller {
	
	@Autowired
	private Biz002Service service;
	
	@Autowired
	private ApplyService applyService;
	
	/**
	 * 신청 페이지
	 * @param request
	 * @param params
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/apply/biz002/index.do", method=RequestMethod.GET)
	public ModelAndView storeClose(HttpServletRequest request, @RequestParam Map<String, String> params, ModelAndView model) throws Exception{
		String applyType = params.get("applyType") == null ? "ONLINE" : params.get("applyType").toString();
		model.addObject("applyType", applyType);
		model.setViewName("programs/biz002/index");
		return model;
	}
}
