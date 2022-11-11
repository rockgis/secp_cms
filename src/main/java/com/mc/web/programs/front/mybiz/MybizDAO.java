package com.mc.web.programs.front.mybiz;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.mc.web.service.CmsAbstractDAO;

/**
 *
 * @Description : 나의 신청 현황 프로그램 DAO
 * @ClassName   : com.mc.web.programs.mybiz.MybizDAO.java
 * @Modification Information
 *
 * @author khkim
 * @since 2018. 3. 29.
 * @version 1.0 *  
 * Copyright (C)  All right reserved.
 */
@Repository
public class MybizDAO extends CmsAbstractDAO {
	
	/**
	 * 지원사업 리스트 조회
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> getBizList(Map<String, Object> params) throws Exception {
		return selectList("mybiz.getBizList", params);
	}
}
