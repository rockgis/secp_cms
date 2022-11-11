package com.mc.web.programs.back.site.js_css.impl;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.stereotype.Service;

import com.mc.web.programs.back.site.js_css.JsCssDAO;
import com.mc.web.programs.back.site.js_css.JsCssService;
import com.mc.web.common.SessionInfo;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service("JsCssService")
public class JsCssServiceImpl extends EgovAbstractServiceImpl implements JsCssService {

	@Autowired
	private JsCssDAO dao;
	
	public Map js_css_main(Map params) throws Exception {
		Map rstMap = new HashMap();
		Map p = new HashMap();
		rstMap.put("data", dao.js_css_main(params));
		return rstMap;
	}
	
	public Map js_css_list(Map params) throws Exception {
		Map rstMap = new HashMap();
		rstMap.put("list", dao.js_css_list(params));
		rstMap.put("pagination", dao.js_css_pagination(params));
		return rstMap;
	}
	
	public Map js_css_get_item(Map params) throws Exception {
		Map rstMap = new HashMap();
		rstMap.put("view", dao.js_css_get_item(params));
		return rstMap;
	}

	public Map js_css_write(Map params) throws Exception {
		Map rstMap = new HashMap();
		SessionInfo.sessionAuth(params);
		rstMap.put("rst", dao.js_css_write(params));
		return rstMap;
	}
}
