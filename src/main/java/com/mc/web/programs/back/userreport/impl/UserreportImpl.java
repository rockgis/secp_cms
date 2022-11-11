package com.mc.web.programs.back.userreport.impl;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mc.web.programs.back.satifaction.SatisfactionDAO;
import com.mc.web.programs.back.userreport.UserreportDAO;
import com.mc.web.programs.back.userreport.UserreportService;
import com.mc.web.common.SessionInfo;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service("UserreportService")
public class UserreportImpl extends EgovAbstractServiceImpl implements UserreportService {

	@Autowired
	private UserreportDAO dao;
	
	public Map userReport(Map params) throws Exception {
		SessionInfo.sessionAuth(params);
		Map rstMap = new HashMap();
		if(dao.isOverlap(params) > 0){
			rstMap.put("rst", "-1");
			rstMap.put("msg", "이미 제출하셨습니다. 감사합니다.");
		}else{
			dao.write(params);
			rstMap.put("rst", "1");
			//rstMap.put("data", dao.page_satisfaction(params));
		}
		return rstMap;
	}
}
