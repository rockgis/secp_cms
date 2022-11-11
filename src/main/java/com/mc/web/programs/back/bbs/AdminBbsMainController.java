package com.mc.web.programs.back.bbs;

import com.mc.web.JsonDAO;
import com.mc.web.MCMap;
import com.mc.web.common.SessionInfo;
import egovframework.com.cmm.util.EgovHttpRequestHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

/**
 * 
 *
 * @Description : 공통 컨트롤러 
 * @ClassName   : com.mc.web.programs.back.bbs.AdminBbsMainController.java
 * @Modification Information
 *
 * @author 이창기
 * @since 2017. 3. 10.
 * @version 1.0 *  
 * Copyright (C)  All right reserved.
 */
@Controller
public class AdminBbsMainController {
	
	@Autowired
	private AdminBbsMainService service;

	@Autowired
	private JsonDAO jsonDAO;

	@GetMapping("/super/homepage/bbs/index.do")
	public String index(@RequestParam Map<String, String> params) throws Exception {
		SessionInfo.sessionAuth(params);
		HttpSession session = EgovHttpRequestHelper.getCurrentSession();
		MCMap cms_member = (MCMap) session.getAttribute("cms_member");
		cms_member.put("get_my_permission_page", jsonDAO.selectOne("Menu.get_my_permission_page", params));
		return "super/homepage/bbs/index";
	}

	@ResponseBody
	@RequestMapping("/super/bbs/info.do")
	public Map info(@RequestParam Map<String, String> params, HttpServletRequest request, HttpSession session) throws Exception{
		return service.boardInfo(params);
	}
	
	@ResponseBody
	@RequestMapping("/super/bbs/catlist.do")
	public List catList(@RequestParam Map<String, String> params) throws Exception{
		return service.catList(params);
	}
	
	@ResponseBody
	@RequestMapping("/super/bbs/delete.do")
	@Transactional(rollbackFor = { Exception.class })
	public Map delete(@RequestParam Map<String, Object> params) throws Exception{
		return service.delete(params);
	}
	
	@ResponseBody
	@RequestMapping("/super/bbs/move.do")
	@Transactional(rollbackFor = { Exception.class })
	public Map articleMove(@RequestParam Map<String, Object> params) throws Exception{
		return service.articleMove(params);
	}
	
	@ResponseBody
	@RequestMapping("/super/bbs/copy.do")
	@Transactional(rollbackFor = { Exception.class })
	public Map articleCopy(@RequestParam Map<String, Object> params) throws Exception{
		return service.articleCopy(params);
	}
	
	@ResponseBody
	@RequestMapping("/super/bbs/articleDelete.do")
	@Transactional(rollbackFor = { Exception.class })
	public Map articleDelete(@RequestParam Map<String, String> params) throws Exception{
		return service.articleDelete(params);
	}
	
	@ResponseBody
	@RequestMapping("/super/bbs/articleRestore.do")
	@Transactional(rollbackFor = { Exception.class })
	public Map articleRestore(@RequestParam Map<String, String> params) throws Exception{
		return service.articleRestore(params);
	}
	
}
