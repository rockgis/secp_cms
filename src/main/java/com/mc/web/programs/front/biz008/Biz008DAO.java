package com.mc.web.programs.front.biz008;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.mc.web.service.CmsAbstractDAO;

/**
 *
 * @Description : 명품점포 프로그램 DAO
 * @ClassName   : com.mc.web.programs.biz008.Biz008DAO.java
 * @Modification Information
 *
 * @author MSLK_JJS
 * @since 2018. 3. 29.
 * @version 1.0 *  
 * Copyright (C)  All right reserved.
 */
@Repository
public class Biz008DAO extends CmsAbstractDAO {
	
	/* 명품점포 인서트 테스트 */
	public int myTest(Map<String, Object> params) {
		return insert("JwTest.myTestInsert", params);
	}
	
	/**
	 * 코드명 가져오기
	 * @param params
	 * @return
	 */
	public Map selectCodeNm(Map<String,Object> params) {
		return selectOne("Code.selectCodeNm",params);
	}
}
