package com.mc.web.programs.front.biz008.impl;

import java.util.Map;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.mc.web.programs.front.biz008.Biz008DAO;
import com.mc.web.programs.front.biz008.Biz008Service;

/**
 *
 * @Description : 명품점포 프로그램 서비스 구현
 * @ClassName   : com.mc.web.programs.biz008.impl.Biz008ServiceImpl.java
 * @Modification Information
 *
 * @author MSLK_JJS
 * @since 2018. 3. 29.
 * @version 1.0 *  
 * Copyright (C)  All right reserved.
 */
@Service
public class Biz008ServiceImpl implements Biz008Service {
	
	@Autowired
	private Biz008DAO dao;
	
	public String intro(Map<String, String> params) throws Exception {
		return "programs/biz008/intro";
	}

	/* 명품점포 인서트 테스트 */
	public String myTest(Map<String, Object> params) throws Exception {
		
		//#################   접수정보 Map 세팅 (#################################################
		//### BIZ_YR, BIZ_NO, BIZ_CYCL param에서
		params.put("RCEPT_NO", params.get("BIZ_YR").toString()+params.get("BIZ_NO").toString()+params.get("BIZ_CYCL").toString());	// 접수번호(헤더출력용)
		
		//### 개인,단체 구분
		Map<String, Object> indvdlGrpSeCdMap = new HashMap();
		indvdlGrpSeCdMap.put("code_group_seq", 9);
		indvdlGrpSeCdMap.put("code", "01"); //01:개인, 02:단체
		params.put("INDVDL_GRP_SE_CD", dao.selectCodeNm(indvdlGrpSeCdMap).get("CODE_NM"));
		
		//### 사업구분
		Map<String, Object> bizSeCdMap = new HashMap();
		bizSeCdMap.put("code_group_seq", 12);
		bizSeCdMap.put("code", "01");	//01:출현, 02:수탁
		params.put("BIZ_SE_CD",dao.selectCodeNm(bizSeCdMap).get("CODE_NM"));
		
		Map<String, Object> rcptStep = new HashMap();
		Map<String, Object> rcptSttsMap = new HashMap();
		
		//제출완료일경우 Y, 나머지는 임시저장 
		if(params.get("PRESENTN_COMPT_YN").equals("Y")) {
			rcptStep.put("code_group_seq", 14);
			rcptStep.put("code", "01");
			rcptSttsMap.put("code_group_seq", 13);
			rcptSttsMap.put("code", "03");
			
			params.put("RCPT_STEP","01");				// 접수단계(01:신청)
			params.put("RCPT_STTS","03");				// 접수상태(03:접수완로)	
			params.put("STEP",dao.selectCodeNm(rcptStep).get("CODE_NM"));					// 접수단계
			params.put("STTUS",dao.selectCodeNm(rcptSttsMap).get("CODE_NM"));					// 접수상태
		}else {
			rcptStep.put("code_group_seq", 14);
			rcptStep.put("code", "01");
			rcptSttsMap.put("code_group_seq", 13);
			rcptSttsMap.put("code", "01");
			
			params.put("RCPT_STEP","01");				// 접수단계(01:신청)
			params.put("RCPT_STTS","01");				// 접수상태(01:임시저장_	
			params.put("STEP",dao.selectCodeNm(rcptStep).get("CODE_NM"));					// 접수단계
			params.put("STTUS",dao.selectCodeNm(rcptSttsMap).get("CODE_NM"));					// 접수상태
		}
		
		params.put("BIZ_REL_AGRE_YN","Y");			// 사업관련동의여부
		params.put("MYDATA_AGRE_YN","N");			// 마이데이터동의여부
		params.put("RGTR",params.get("userId"));					// 등록자
		params.put("MDFR",params.get("userId"));					// 수정자
		
		ObjectMapper mapper = new ObjectMapper();
		String json = mapper.writerWithDefaultPrettyPrinter().writeValueAsString(params);
		params.put("RCPT_DATA",json);
		dao.myTest(params);
		return null;
	}
	
}
