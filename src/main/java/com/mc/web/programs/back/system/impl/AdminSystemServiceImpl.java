package com.mc.web.programs.back.system.impl;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.session.SessionRegistry;
import org.springframework.stereotype.Service;

import com.mc.common.util.RequestSnack;
import com.mc.common.util.StringUtil;
import com.mc.web.programs.back.system.AdminSystemDAO;
import com.mc.web.programs.back.system.AdminSystemHelper;
import com.mc.web.programs.back.system.AdminSystemService;
import com.mc.web.login.session.SessionInformationSupport;
import com.mc.web.service.Globals;
import com.mc.web.vsc.SystemMode;
import com.mc.web.vsc.VscFactory;
import com.mc.web.vsc.VscProcess;

import egovframework.com.cmm.util.EgovHttpRequestHelper;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service("AdminSystemService")
public class AdminSystemServiceImpl extends EgovAbstractServiceImpl implements AdminSystemService{
	
	@Autowired
	private AdminSystemDAO dao;
	
	@Autowired
	private AdminSystemHelper helper;

	@Autowired
	private SessionRegistry sessionRegistry;

	public String dashboard(Map params) throws Exception {
		HttpServletRequest request = EgovHttpRequestHelper.getCurrentRequest();
		params.put("mode", "sys");
		params.put("site_id", StringUtil.isEmptyByParam(RequestSnack.getCookie(request, "adh_menu_current_siteid"))?"1":RequestSnack.getCookie(request, "adh_menu_current_siteid"));
		Map rstMap = helper.dashboardData(params);

		SessionInformationSupport sessionInformationSupport = new SessionInformationSupport(sessionRegistry);

		Map p = new HashMap();
		//실시간 사용자 접속카운트
		p.put("gubun", "user");
		rstMap.put("realtime_user_count", sessionInformationSupport.getSessionInformations(p).size());
		//실시간 관리자 접속카운트
		p.put("gubun", "admin");
		p.put("group_seq", "1");
		rstMap.put("realtime_admin1_count", sessionInformationSupport.getSessionInformations(p).size());
		p.put("group_seq", "2");
		rstMap.put("realtime_admin2_count", sessionInformationSupport.getSessionInformations(p).size());
		p.clear();
		
		request.setAttribute("data", rstMap);
		return "/super/system/index";
	}

	public String system_info(Map params) throws Exception {
		HttpServletRequest request = EgovHttpRequestHelper.getCurrentRequest();
		VscProcess vp = new VscFactory().create(SystemMode.get(Globals.SYS_MODE));
    	vp.init();
		request.setAttribute("data", vp.getInfo());
		return "super/system/system_info/index";
	}
}