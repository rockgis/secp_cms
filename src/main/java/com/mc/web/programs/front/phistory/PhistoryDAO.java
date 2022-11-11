package com.mc.web.programs.front.phistory;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.mc.web.MCMap;
import com.mc.web.service.CmsAbstractDAO;

/**
 *
 * @Description : 페이지이력 프로그램 DAO
 * @ClassName   : com.mc.web.programs.phistory.PhistoryDAO.java
 * @Modification Information
 *
 * @author sdlck
 * @since 2018. 3. 29.
 * @version 1.0 *  
 * Copyright (C)  All right reserved.
 */
@Repository
public class PhistoryDAO extends CmsAbstractDAO {

	public MCMap view(Map<String, String> params) {
		return selectOne("Phistory.view", params);
	}

	public List<MCMap> history_list(Map<String, String> params) {
		return selectList("Phistory.history_list", params);
	}
	
}
