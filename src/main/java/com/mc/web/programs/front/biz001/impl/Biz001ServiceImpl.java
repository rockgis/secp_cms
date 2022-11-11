package com.mc.web.programs.front.biz001.impl;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mc.web.programs.front.apply.ApplyDAO;
import com.mc.web.programs.front.biz001.Biz001DAO;
import com.mc.web.programs.front.biz001.Biz001Service;

/**
 *
 * @Description : bizmanage 프로그램 서비스 구현
 * @ClassName   : com.mc.web.programs.bizmanage.impl.BizmanageServiceImpl.java
 * @Modification Information
 *
 * @author MSLK_JJS
 * @since 2018. 3. 29.
 * @version 1.0 *  
 * Copyright (C)  All right reserved.
 */
@Service
public class Biz001ServiceImpl implements Biz001Service {
	
	@Autowired
	private Biz001DAO dao;
	
	@Autowired
	private ApplyDAO applyDao;

	@Override
	@Transactional(rollbackFor = {Exception.class})
	public Map<String, Object> submitGiveup(Map<String, Object> params) throws Exception {
		Map<String, Object> applyData = applyDao.indvdlSelectOne(params);
		params.put("bizSeCd", applyData.get("biz_se_cd"));
		params.put("dataSeCd", applyData.get("data_se_cd"));
		params.put("rcptStep", applyData.get("rcpt_step"));
		params.put("rcptStts", "07");
		params.put("_agreYn", applyData.get("mydata_agre_yn"));
		params.put("rcptData", applyData.get("rcpt_data"));
		
		int chgResult = dao.insertChgMng(params);
		
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("bizYr", params.get("bizYr"));
		paramMap.put("bizNo", params.get("bizNo"));
		paramMap.put("bizCycl", params.get("bizCycl"));
		paramMap.put("rcptStts", "07");
		paramMap.put("userId", params.get("userId"));
		int mngResult = applyDao.indvdlUpdate(paramMap);
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		try {
			if (chgResult > 0 && mngResult > 0) {
				map.put("result", true);
			} else {
				throw new Exception("Biz001ServiceImpl.submitGiveup error.");
			}	
		} catch(Exception e) {
			map.put("result", false);
			e.getStackTrace();
		}
		
		return map;
	}
}
