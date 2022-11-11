package com.mc.web.programs.back.site.basic_setting.impl;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.stereotype.Service;

import com.mc.web.programs.back.site.basic_setting.SiteBasicDAO;
import com.mc.web.programs.back.site.basic_setting.SiteBasicService;
import com.mc.web.common.SessionInfo;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service("SiteBasicService")
public class SiteBasicServiceImpl extends EgovAbstractServiceImpl implements SiteBasicService {

	@Autowired
	private SiteBasicDAO dao;
	
	public Map basic_view(Map params) throws Exception {
		return dao.basic_view((String)params.get("site_id"));
	}

	public Map basic_modify(Map params) throws Exception {
		SessionInfo.sessionAuth(params);
		Map rstMap = new HashMap();
		rstMap.put("rst", dao.basic_modify(params));
		return rstMap;
	}

	@CacheEvict(value= {"menuCache","dashboardCache","basicCache","jsCssCache","menuGrantCache","ipcheckCache","mainCache"}, allEntries=true)
	public Map clear_chche(Map params) throws Exception {
		Map rstMap = new HashMap();
//		CacheManager cacheManager = CacheManager.getInstance();
//		cacheManager.clearAll();
		rstMap.put("rst", "1");
		return rstMap;
	}
}
