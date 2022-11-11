package com.mc.web.programs.back.phistory;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.mc.web.MCMap;
import com.mc.web.service.CmsAbstractDAO;

/**
 *
 * @Description : 페이지이력 프로그램 DAO
 * @ClassName   : com.mc.web.programs.back.phistory.AdminPhistoryDAO.java
 * @Modification Information
 *
 * @author sdlck
 * @since 2018. 3. 29.
 * @version 1.0 *  
 * Copyright (C)  All right reserved.
 */
@Repository 
public class AdminPhistoryDAO extends CmsAbstractDAO {

	public List<MCMap> list(Map params) {
		return selectList("Phistory.list", params);
	}
	public MCMap pagination(Map params) {
		return selectOne("Phistory.pagination", params);
	}
	public MCMap view(Map params) {
		return selectOne("Phistory.view", params);
	}
	public int write(Map params) {
		return update("Phistory.write", params);
	}
	public int modify(Map params) {
		return update("Phistory.modify", params);
	}
	public int del(Map params) {
		return update("Phistory.del", params);
	}

}
