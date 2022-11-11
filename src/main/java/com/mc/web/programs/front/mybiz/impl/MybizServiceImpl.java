package com.mc.web.programs.front.mybiz.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mc.web.programs.front.mybiz.MybizDAO;
import com.mc.web.programs.front.mybiz.MybizService;

/**
 *
 * @Description : 나의 신청 현황 프로그램 서비스 구현
 * @ClassName   : com.mc.web.programs.mybiz.impl.MybizServiceImpl.java
 * @Modification Information
 *
 * @author khkim
 * @since 2018. 3. 29.
 * @version 1.0 *  
 * Copyright (C)  All right reserved.
 */
@Service
public class MybizServiceImpl implements MybizService {
	
	@Autowired
	private MybizDAO dao;
	
	public String index(Map<String, String> params) throws Exception {
		return "programs/mybiz/index";
	}
	
	@Transactional(rollbackFor = {Exception.class})
	public Map<String, Object> getBizList(Map<String, Object> params) throws Exception {
		Map<String, Object> map = new HashMap<>();
		
		List<Map<String, Object>> list = dao.getBizList(params);
		
		List<Map<String, Object>> prog = new ArrayList<>(); // 진행 중인 사업
		List<Map<String, Object>> comp = new ArrayList<>(); // 완료 사업
		for (Map<String, Object> m : list) {
			String step = m.get("RCPT_STEP").toString();
			if ("03".equals(step)) { // 진행단계가 완료인 경우
				comp.add(m);
			} else {
				prog.add(m);
			}
		}
		map.put("PROGRESS", prog);
		map.put("COMPLETE", comp);
		return map;
	}

	public String bizGiveUpPopup(Map<String, String> params) throws Exception {
		return "programs/mybiz/popup/bizGiveUp";
	}

	public String bizChngPopup(Map<String, String> params) throws Exception {
		return "programs/mybiz/popup/bizChng";
	}

	public String cmpltRptPopup(Map<String, String> params) throws Exception {
		return "programs/mybiz/popup/cmpltRpt";
	}
	
	public String pymtFormPopup(Map<String, String> params) throws Exception {
		return "programs/mybiz/popup/pymtForm";
	}
	
}
