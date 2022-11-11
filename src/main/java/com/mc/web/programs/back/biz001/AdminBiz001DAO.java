package com.mc.web.programs.back.biz001;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.mc.web.MCMap;
import com.mc.web.service.CmsAbstractDAO;

/**
 *
 * @Description : bizmanage 프로그램 DAO
 * @ClassName   : com.mc.web.programs.back.bizmanage.AdminBizmanageDAO.java
 * @Modification Information
 *
 * @author MSLK_JJS
 * @since 2018. 3. 29.
 * @version 1.0 *  
 * Copyright (C)  All right reserved.
 */
@Repository
public class AdminBiz001DAO extends CmsAbstractDAO {

	public List<MCMap> list(Map<String, String> params) {
		return selectList("biz001.list", params);
	}
	public MCMap pagination(Map<String, String> params) {
		return selectOne("biz001.pageinfo", params);
	}
	
	public Map<String,Object> selectGridHeader() throws Exception{
		return selectOne("biz001.selectGridHeader");
	}
	
	public List<MCMap> selectGridData(Map<String, String> params) throws Exception{
		return selectList("biz001.selectGridData",params);
	}
	
	
	public Map<String,Object> selectBizInfo(Map<String, Object> params) {
		return selectOne("bizmaster.selectBizDetail",params);
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
	 * 파일저장
	 * @param params
	 * @return
	 */
	public int fileInsert(Map<String, Object> params) {
		return insert("bizattach.insert", params);
	}
	
}
