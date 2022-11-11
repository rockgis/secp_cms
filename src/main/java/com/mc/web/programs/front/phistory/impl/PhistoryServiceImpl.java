package com.mc.web.programs.front.phistory.impl;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mc.common.util.StringUtil;
import com.mc.web.MCMap;
import com.mc.web.programs.front.phistory.PhistoryDAO;
import com.mc.web.programs.front.phistory.PhistoryService;

import egovframework.com.cmm.util.EgovHttpRequestHelper;

/**
 *
 * @Description : 페이지이력 프로그램 서비스 구현
 * @ClassName   : com.mc.web.programs.phistory.impl.PhistoryServiceImpl.java
 * @Modification Information
 *
 * @author sdlck
 * @since 2018. 3. 29.
 * @version 1.0 *  
 * Copyright (C)  All right reserved.
 */
@Service
public class PhistoryServiceImpl implements PhistoryService {
	
	@Autowired
	private PhistoryDAO dao;
	
	public String intro(Map<String, String> params) throws Exception {
		HttpServletRequest request = EgovHttpRequestHelper.getCurrentRequest();
		
		List<MCMap> list = dao.history_list(params);
		if(StringUtil.isEmptyByParam(params, "seq")){
			if(list.size() > 0) {
				params.put("seq", list.get(0).getStrNull("seq"));
			}
		}
		request.setAttribute("view", dao.view(params));
		request.setAttribute("hlist", list);
		return "programs/phistory/intro";
	}
	
}
