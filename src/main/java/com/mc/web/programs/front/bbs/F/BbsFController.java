package com.mc.web.programs.front.bbs.F;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

/**
 * 
 *
 * @Description : 
 * @ClassName   : com.mc.web.bbs.BbsController.java
 * @Modification Information
 *
 * @author 이창기
 * @since 2017. 3. 7.
 * @version 1.0 *  
 * Copyright (C)  All right reserved.
 */
@Controller
@RequestMapping(value="/bbs/F")
public class BbsFController{
	
	@Autowired
	private BbsFService service;
	
	@RequestMapping(value="/list.do", method=RequestMethod.GET)
	public String list(HttpServletRequest request, @RequestParam Map<String, String> params) throws Exception{
		return service.list(params);
	}
	
	@RequestMapping(value="/insertForm.do", method=RequestMethod.GET)
	public String insertForm(HttpServletRequest request, @RequestParam Map<String, String> params) throws Exception{
		return service.insertForm(params);
	}
	
	@Transactional(rollbackFor = { Exception.class })
	@RequestMapping(value="/insert.do", method=RequestMethod.POST)
	public String insert(HttpServletRequest request, @RequestParam Map<String, String> params,@RequestParam(value = "attach", required = false) List<MultipartFile> attachList) throws Exception{
		return service.insert(params, attachList);
	}
	
	@RequestMapping(value="/view.do")
	public String view(HttpServletRequest request, @RequestParam Map<String, String> params) throws Exception{
		return service.view(params);
	}
	
	@RequestMapping(value="/modifyForm.do")
	public String modifyForm(HttpServletRequest request, @RequestParam Map<String, String> params) throws Exception{
		return service.modifyForm(params);
	}
	
	@Transactional(rollbackFor = { Exception.class })
	@RequestMapping(value="/modify.do", method=RequestMethod.POST)
	public String modify(HttpServletRequest request, @RequestParam Map<String, String> params,@RequestParam(value = "attach", required = false) List<MultipartFile> attachList, @RequestParam(value = "delattach", required = false) List<String> delAttachList) throws Exception{
		return service.modify(params, attachList, delAttachList);
	}
	
	@Transactional(rollbackFor = { Exception.class })
	@RequestMapping(value={"/delete.do"})
	public String delete(HttpServletRequest request, @RequestParam Map<String, String> params) throws Exception{
		return service.delete(params);
	}
}
