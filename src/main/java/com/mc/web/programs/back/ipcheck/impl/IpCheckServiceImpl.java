package com.mc.web.programs.back.ipcheck.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import com.mc.web.MCMap;
import com.mc.web.programs.back.ipcheck.IpCheckDAO;
import com.mc.web.programs.back.ipcheck.IpCheckService;
import com.mc.web.common.SessionInfo;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service("IpCheckService")
public class IpCheckServiceImpl extends EgovAbstractServiceImpl implements IpCheckService{
	
	@Autowired
	private IpCheckDAO dao;
	
	public Map list(Map params) throws Exception {
		Map rstMap = new HashMap();
		rstMap.put("list", dao.list(params));
		rstMap.put("pagination", dao.pagination(params));
		return rstMap;
	}
	
	public MCMap view(Map params) throws Exception {
		return dao.view(params);
	}

	@CacheEvict(value="ipcheckCache", key="0")
	public Map write(Map params) throws Exception {
		SessionInfo.sessionAuth(params);
		Map rstMap = new HashMap();
		rstMap.put("rst", dao.write(params));
		return rstMap;
	}

	@CacheEvict(value="ipcheckCache", key="0")
	public Map modify(Map params) throws Exception {
		SessionInfo.sessionAuth(params);
		Map rstMap = new HashMap();
		rstMap.put("rst", dao.modify(params));
		return rstMap;
	}

	@CacheEvict(value="ipcheckCache", key="0")
	public Map del(Map params) throws Exception {
		SessionInfo.sessionAuth(params);
		Map rstMap = new HashMap();
		rstMap.put("rst", dao.del(params));
		return rstMap;
	}
	
	@Cacheable(value="ipcheckCache", key="0")
	public List<String> ipcheck() throws Exception {
		return dao.ipcheck();
	}
}
