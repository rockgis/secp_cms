package com.mc.web.programs.back.permit.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mc.web.programs.back.homepage.HomepageDAO;
import com.mc.web.programs.back.permit.PermitDAO;
import com.mc.web.programs.back.permit.PermitHelper;
import com.mc.web.programs.back.permit.PermitService;
import com.mc.web.common.SessionInfo;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service("PermitService")
public class PermitServiceImpl extends EgovAbstractServiceImpl implements PermitService{
	
	@Autowired
	private PermitHelper helper;
	
	@Autowired
	private PermitDAO dao;
	
	@Autowired
	private HomepageDAO homepageDAO;
	
	public Map list(Map params) throws Exception {
		Map rstMap = new HashMap();
		rstMap.put("list", dao.list(params));
		rstMap.put("pagination", dao.pagination(params));
		return rstMap;
	}
	
	public List menu_list(Map params) throws Exception {
		return helper.makeList(dao.menu_list(params));
	}
	
	public Map view(Map params) throws Exception {
		Map rstMap = new HashMap();
		rstMap.put("view", dao.view(params));
		rstMap.put("list", helper.makeList(dao.menu_list(params)));
		return rstMap;
	}

	public Map write(Map params) throws Exception {
		SessionInfo.sessionAuth(params);
		Map rstMap = new HashMap();
		dao.write(params);
		
		List list = (List) params.get("list");
		if(list != null){
			for (int i = 0; i < list.size(); i++) {
				Map m = (Map) list.get(i);
				m.put("parent_seq", params.get("seq"));
				m.put("order_seq", i+1);
				m.put("site_id", params.get("site_id"));
				dao.insert_permit(m);
			}
		}
		
		rstMap.put("rst", "1");
		return rstMap;
	}

	public Map modify(Map params) throws Exception {
		SessionInfo.sessionAuth(params);
		Map rstMap = new HashMap();
		dao.modify(params);

		dao.permit_del_all(params);
		//dao.permit_del_manage_member_all(params);
		List list = (List) params.get("list");
		if(list != null){
			for (int i = 0; i < list.size(); i++) {
				Map m = (Map) list.get(i);
				m.put("parent_seq", params.get("seq"));
				m.put("order_seq", i+1);
				m.put("site_id", params.get("site_id"));
				dao.insert_permit(m);
			}
		}

		rstMap.put("rst", "1");
		return rstMap;
	}

	public Map del(Map params) throws Exception {
		SessionInfo.sessionAuth(params);
		Map rstMap = new HashMap();
		dao.del(params);
		dao.permit_del_all(params);
		rstMap.put("rst", "1");
		return rstMap;
	}
}
