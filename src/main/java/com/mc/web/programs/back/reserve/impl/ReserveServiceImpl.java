package com.mc.web.programs.back.reserve.impl;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mc.web.programs.back.bbs.AdminBbsHelper;
import com.mc.web.programs.back.reserve.ReserveDAO;
import com.mc.web.programs.back.reserve.ReserveSchedule;
import com.mc.web.programs.back.reserve.ReserveService;
import com.mc.web.common.SessionInfo;

import egovframework.com.cmm.util.EgovHttpRequestHelper;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service("ReserveService")
public class ReserveServiceImpl extends EgovAbstractServiceImpl implements ReserveService{
	
	@Autowired
	private ReserveDAO dao;
		
	@Autowired
	private ReserveSchedule schedule;

	@Autowired
	private AdminBbsHelper bbsHelper;
	
	public Map list(Map params) throws Exception {
		Map rstMap = new HashMap();
		rstMap.put("list", dao.list(params));
		rstMap.put("pagination", dao.pagination(params));
		return rstMap;
	}

	public Map del(Map params) throws Exception {
		SessionInfo.sessionAuth(params);		
		Map rstMap = new HashMap();
		schedule.removeTimer((String)params.get("reserve_seq"));
		rstMap.put("rst", dao.del(params));
		return rstMap;
	}
	
	public Map write_reserve(Map params) throws Exception {
		SessionInfo.sessionAuth(params);
		params.put("type", "REG");
		params.put("gubun", "M");
		params.put("jdata", params.toString());
		dao.reserve(params);
		Map r = new HashMap();
		r.put("reserve_seq", params.get("reserve_seq"));
		r.put("reserve_dt", params.get("reserve_dt"));
		schedule.writeSchedule(r);
		Map rstMap = new HashMap();
		
		rstMap.put("rst", "1");
		
		return rstMap;
	}

	public Map modify_reserve(Map params) throws Exception {
		SessionInfo.sessionAuth(params);
		params.put("type", "MOD");
		params.put("gubun", "M");
		params.put("jdata", params.toString());
		dao.reserve(params);
		Map r = new HashMap();
		r.put("reserve_seq", params.get("reserve_seq"));
		r.put("reserve_dt", params.get("reserve_dt"));
		schedule.modifySchedule(r);
		Map rstMap = new HashMap();
		
		rstMap.put("rst", "1");
		
		return rstMap;
	}
	
	//게시물 예약 등록
	public Map write_bbs_reserve(Map params) throws Exception {
		HttpServletRequest request = EgovHttpRequestHelper.getCurrentRequest();
		
		SessionInfo.sessionAuth(params);
		params.put("type", "REG");
		params.put("gubun", "B");
		params.put("jdata", params.toString());
		dao.reserve(params);
		bbsHelper.articleFileUploadTemp(params, request);//article_seq 없이 첨부파일만 등록
		Map r = new HashMap();
		r.put("reserve_seq", params.get("reserve_seq"));
		r.put("reserve_dt", params.get("reserve_dt"));
		schedule.writeBbsSchedule(r);
		Map rstMap = new HashMap();
		
		rstMap.put("rst", "1");
		
		return rstMap;
	}

}
