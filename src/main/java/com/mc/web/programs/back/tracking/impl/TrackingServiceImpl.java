package com.mc.web.programs.back.tracking.impl;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mc.common.util.DateUtil;
import com.mc.web.MCMap;
import com.mc.web.programs.back.tracking.TrackingDAO;
import com.mc.web.programs.back.tracking.TrackingService;

import egovframework.com.cmm.util.EgovHttpRequestHelper;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service("TrackingService")
public class TrackingServiceImpl extends EgovAbstractServiceImpl implements TrackingService {
	
	@Autowired
	private TrackingDAO dao;
	
	@Override
	public String insert(Map params) {
		int rst = 0;

		HttpSession session = EgovHttpRequestHelper.getCurrentSession();
		MCMap member = (MCMap) session.getAttribute("cms_member");
		if(member != null){
			params.put("member_id", member.getStrNull("member_id"));
			params.put("member_name", member.getStrNull("member_nm"));
		}
		
		if(params.get("member_name") != null){
			params.put("login_date",DateUtil.getTime("yyyy-MM-dd"));
			params.put("login_ip",EgovHttpRequestHelper.getRequestIp());
			
			Map m = new HashMap();
			m = dao.getLogin(params);
			if(m == null){
				dao.setLogin(params);
				m = dao.getLogin(params);
			}
			params.put("parent_seq", m.get("seq"));
			
			rst = dao.setLocation(params);
		}
		return String.valueOf(rst);
	}

	@Override
	public Map list(Map params) {
		Map rst = new HashMap();
		rst.put("list", dao.loginList(params));
		rst.put("pagination", dao.loginPagination(params));
		return rst;
	}

	@Override
	public Map viewLog(Map params) {
		Map rst = new HashMap();
		rst.put("list", dao.viewList(params));
		rst.put("pagination", dao.viewPagination(params));
		return rst;
	}
	
	@Override
	public Map viewAuth(Map params) {
		Map rst = new HashMap();
		rst.put("list", dao.viewAuth(params));
		return rst;
	}

}
