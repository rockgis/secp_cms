package com.mc.web.programs.front.apply;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.mc.web.MCMap;
import com.mc.web.service.CmsAbstractDAO;

/**
 *
 * @Description : 온라인 접수 프로그램 DAO
 * @ClassName   : com.mc.web.programs.apply.ApplyDAO.java
 * @Modification Information
 *
 * @author khkim
 * @since 2018. 3. 29.
 * @version 1.0 *  
 * Copyright (C)  All right reserved.
 */
@Repository
public class ApplyDAO extends CmsAbstractDAO {
	
	public String isAgree(Map<String, Object> params) {
		return selectOne("apply.isAgree", params);
	}
	
	public List<Map<String, Object>> getListData(Map<String, Object> params) throws Exception {
		return selectList("apply.getListData", params);
	}
	
	/**
	 * 개인지원사업 현재 일련번호
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
	 * 개인 지원사업 select one
	 * @param params
	 * @return
	 */
	public MCMap indvdlSelectOne(Map<String, Object> params) {
		return selectOne("apply.indvdlSelectOne", params);
	}
	
	/**
	 * 개인 지원사업 insert
	 * @param params
	 * @return
	 */
	public int indvdlInsert(Map<String, Object> params) {
		return insert("apply.indvdlInsert", params);
	}
	
	/**
	 * 개인 지원사업 update
	 * @param params
	 * @return
	 */
	public int indvdlUpdate(Map<String, Object> params) {
		return update("apply.indvdlUpdate", params);
	}
	
	/**
	 * 단체 지원사업 select one
	 * @param params
	 * @return
	 */
	public MCMap grpSelectOne(Map<String, Object> params) {
		return selectOne("apply.grpSelectOne", params);
	}
	
	/**
	 * 단체 지원사업 insert
	 * @param params
	 * @return
	 */
	public int grpInsert(Map<String, Object> params) {
		return insert("apply.grpInsert", params);
	}
	
	/**
	 * 단체 지원사업 update
	 * @param params
	 * @return
	 */
	public int grpUpdate(Map<String, Object> params) {
		return update("apply.grpUpdate", params);
	}
	
	/**
	 * 파일저장
	 * @param params
	 * @return
	 */
	public int fileInsert(Map<String, Object> params) {
		return insert("bizattach.insert", params);
	}
	
}
