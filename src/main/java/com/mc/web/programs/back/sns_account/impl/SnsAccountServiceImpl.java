package com.mc.web.programs.back.sns_account.impl;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mc.web.MCMap;
import com.mc.web.programs.back.sns_account.SnsAccountDAO;
import com.mc.web.programs.back.sns_account.SnsAccountService;
import com.mc.web.common.SessionInfo;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service("SnsAccountService")
public class SnsAccountServiceImpl extends EgovAbstractServiceImpl implements SnsAccountService {

	@Autowired
	private SnsAccountDAO dao;
	
	public MCMap view() throws Exception {
		return dao.view();
	}

	public Map modify(Map params) throws Exception {
		SessionInfo.sessionAuth(params);
		Map rstMap = new HashMap();
		rstMap.put("rst", dao.modify(params));
		return rstMap;
	}
}