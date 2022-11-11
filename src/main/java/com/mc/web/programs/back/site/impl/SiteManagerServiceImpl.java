package com.mc.web.programs.back.site.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mc.common.util.RequestSnack;
import com.mc.common.util.StringUtil;
import com.mc.web.MCMap;
import com.mc.web.programs.back.homepage.HomepageDAO;
import com.mc.web.programs.back.site.SiteManagerDAO;
import com.mc.web.programs.back.site.SiteManagerHelper;
import com.mc.web.programs.back.site.SiteManagerService;
import com.mc.web.common.SessionInfo;

import egovframework.com.cmm.util.EgovHttpRequestHelper;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service("SiteManagerService")
public class SiteManagerServiceImpl extends EgovAbstractServiceImpl implements SiteManagerService {

	@Autowired
	private SiteManagerDAO dao;
	
	@Autowired
	private SiteManagerHelper helper;
	
	@Autowired
	private HomepageDAO homepageDAO;

	public String dashboard(Map params) throws Exception {
		HttpServletRequest request = EgovHttpRequestHelper.getCurrentRequest();
		params.put("mode", "site");
		params.put("site_id", StringUtil.isEmptyByParam(RequestSnack.getCookie(request, "adh_menu_current_siteid"))?"1":RequestSnack.getCookie(request, "adh_menu_current_siteid"));
		request.setAttribute("data", helper.dashboardData(params));
		return "/super/site/index";
	}
	
	public Map list(Map<String, String> params) throws Exception {
		Map rstMap = new HashMap();
		rstMap.put("list", dao.list(params));
		rstMap.put("pagination", dao.pagination(params));
		return rstMap;
	}
	
	public Map view(Map<String, String> params) throws Exception {
		Map rstMap = new HashMap();
		rstMap.put("view", dao.view(params));
		rstMap.put("staff_list", homepageDAO.staff_list(params));
		return rstMap;
	}

	public Map write(Map params) throws Exception {
		SessionInfo.sessionAuth(params);
		Map rstMap = new HashMap();
		dao.write(params);
		
		List list = (List) params.get("staff_list");
		if(list != null){
			for (int i = 0; i < list.size(); i++) {
				Map m = (Map) list.get(i);
				m.put("order_seq", i+1);
				m.put("cms_menu_seq", params.get("cms_menu_seq"));
				m.put("session_member_id", params.get("session_member_id"));
				m.put("session_member_nm", params.get("session_member_nm"));
				m.put("ip", EgovHttpRequestHelper.getRequestIp());
				homepageDAO.insertStaff(m);
			}
		}
		if("127.0.0.1".equals(EgovHttpRequestHelper.getRequestIp()) || "localhost".equals(EgovHttpRequestHelper.getRequestIp())){
			helper.updateJSON(params);
		}
		rstMap.put("rst", "1");
		
		return rstMap;
	}

	public Map modify(Map params) throws Exception {
		SessionInfo.sessionAuth(params);
		Map rstMap = new HashMap();
		dao.modify(params);

		homepageDAO.staff_del_all(params);
		List list = (List) params.get("staff_list");
		if(list != null){
			for (int i = 0; i < list.size(); i++) {
				Map m = (Map) list.get(i);
				m.put("order_seq", i+1);
				m.put("cms_menu_seq", params.get("cms_menu_seq"));
				m.put("session_member_id", params.get("session_member_id"));
				m.put("session_member_nm", params.get("session_member_nm"));
				m.put("ip", EgovHttpRequestHelper.getRequestIp());
				homepageDAO.insertStaff(m);
			}
		}
		if(!"1".equals(String.valueOf(params.get("cms_menu_seq")))) {
			helper.updateJSON(params);
		}
		rstMap.put("rst", "1");
		return rstMap;
	}

	public Map del(Map<String, String> params) throws Exception {
		SessionInfo.sessionAuth(params);
		Map rstMap = new HashMap();
		rstMap.put("rst", dao.del(params));
		if("127.0.0.1".equals(EgovHttpRequestHelper.getRequestIp()) || "localhost".equals(EgovHttpRequestHelper.getRequestIp())){
			helper.deleteJSON(params);
		}
		return rstMap;
	}
}
