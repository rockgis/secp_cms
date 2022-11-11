package com.mc.web.programs.front.biz001;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.mc.web.service.CmsAbstractDAO;

/**
 *
 * @Description : bizmanage 프로그램 DAO
 * @ClassName   : com.mc.web.programs.bizmanage.BizmanageDAO.java
 * @Modification Information
 *
 * @author MSLK_JJS
 * @since 2018. 3. 29.
 * @version 1.0 *  
 * Copyright (C)  All right reserved.
 */
@Repository
public class Biz001DAO extends CmsAbstractDAO {
	public int insertChgMng(Map<String, Object> params) {
		return insert("biz001.insertChgMng", params);
	}
}
