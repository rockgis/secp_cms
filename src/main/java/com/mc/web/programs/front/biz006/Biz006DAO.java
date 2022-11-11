package com.mc.web.programs.front.biz006;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.mc.web.service.CmsAbstractDAO;

/**
 *
 * @Description : 청년사관학교 프로그램 DAO
 * @ClassName   : com.mc.web.programs.biz006.Biz006DAO.java
 * @Modification Information
 *
 * @author MSLK_JJS
 * @since 2018. 3. 29.
 * @version 1.0 *  
 * Copyright (C)  All right reserved.
 */
@Repository
public class Biz006DAO extends CmsAbstractDAO {
	
	public String isAgree(Map<String, Object> params) {
		return selectOne("apply.isAgree", params);
	}
	/**
	 * 개인지원사업 현재 일련번호 (RCEPT_SN)
	 * @param params
	 * @return
	 */
	public int selectBizSnNow(Map<String, Object> params) {
		return selectOne("apply.selectBizSnNow", params);
	}
	/**
	 * 코드명 가져오기
	 * @param params
	 * @return
	 */
	public Map selectCodeNm(Map<String,Object> params) {
		return selectOne("Code.selectCodeNm",params);
	}
	
	/**
	 * 파일저장 
	 * @param params
	 * @return
	 */
	public int fileInsertTest(Map<String, Object> params) {
		return insert("bizattach.insert", params);
	}
	/**
	 * 개인 지원사업 청년사관학교 insert TEST
	 * @param params
	 * @return
	 */
	public int indvdlInsert(Map<String, Object> params) {
//		return insert("apply.testIndvdlInsert", params); //insert test 쿼리
		return insert("apply.indvdlInsert", params);
	} 
}
