package com.mc.web.programs.front.biz006.impl;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.mc.common.util.DateUtil;
import com.mc.web.common.FileUtil;
import com.mc.web.programs.front.biz006.Biz006DAO;
import com.mc.web.programs.front.biz006.Biz006Service;


/**
 *
 * @Description : 청년사관학교 프로그램 서비스 구현
 * @ClassName   : com.mc.web.programs.biz006.impl.Biz006ServiceImpl.java
 * @Modification Information
 *
 * @author MSLK_JJS
 * @since 2018. 3. 29.
 * @version 1.0 *  
 * Copyright (C)  All right reserved.
 */
@Service
public class Biz006ServiceImpl implements Biz006Service {
	@Value("#{config['bizUpload.temp']}")
	private String TEMP_PATH;
	@Value("#{config['bizUpload.data']}")
	private String UPLOAD_PATH;
	@Value("#{config['bizUpload.pdfTemplates']}")
	private String PDF_TEMPLATES_PATH;
	@Value("#{config['bizUpload.pdf']}")
	private String PDF_UPLOAD_PATH;
	
	@Autowired
	private FileUtil fileUtil;
	
	@Autowired
	private Biz006DAO dao;
	
	public String intro(Map<String, String> params) throws Exception {
		return "programs/biz006/intro";
	}
	
	/*청년사관학교 insert Test*/
	
	@Transactional(rollbackFor = { Exception.class })
	public Map<String, Object> insertTest(Map<String, Object> params, MultipartHttpServletRequest mpr) throws Exception {
		
		//#################   접수정보 Map 세팅 (#################################################
		//### BIZ_YR, BIZ_NO, BIZ_CYCL param에서
		params.put("RCEPT_SN",dao.selectBizSnNow(params)+1);		// 접수일련번호(현재 사업일련번호+1을 미리 선택)
		params.put("RCEPT_NO", params.get("BIZ_YR").toString()+"-"+params.get("BIZ_NO").toString()+"-"+params.get("BIZ_CYCL").toString()+"-"+params.get("RCEPT_SN").toString());	// 접수번호(헤더출력용)
		
		//### 접수구분
		Map<String, Object> rceptSeMap = new HashMap();
		rceptSeMap.put("code_group_seq", 15);
		rceptSeMap.put("code", "01"); //01:온라인, 02:마이데이터, 03:서류접수
		params.put("RCEPT_SE",dao.selectCodeNm(rceptSeMap).get("CODE_NM")); 	
		
		//### 개인,단체 구분
		Map<String, Object> indvdlGrpSeCdMap = new HashMap();
		indvdlGrpSeCdMap.put("code_group_seq", 9);
		indvdlGrpSeCdMap.put("code", "01"); //01:개인, 02:단체
		params.put("INDVDL_GRP_SE_CD",dao.selectCodeNm(indvdlGrpSeCdMap).get("CODE_NM"));		
		//params.put("INDVDL_GRP_SE_CD","01");		// 개인,단체 구분코드
		
		//### 사업구분
		Map<String, Object> bizSeCdMap = new HashMap();
		bizSeCdMap.put("code_group_seq", 12);
		bizSeCdMap.put("code", "01");	//01:출현, 02:수탁
		params.put("BIZ_SE_CD",dao.selectCodeNm(bizSeCdMap).get("CODE_NM"));		
		//params.put("BIZ_SE_CD","01");				// 사업 구분코드
		
		//params.put("DATA_SE_CD","01");				// 접수구분코드 (
		
		
		
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
		
		
		
		params.put("BIZ_REL_AGRE_YN","Y");								// 사업관련동의여부
		params.put("MYDATA_AGRE_YN","N");								// 마이데이터동의여부
		params.put("RGTR",params.get("userId"));						// 등록자
		params.put("MDFR",params.get("userId"));						// 수정자
		params.put("RCEPT_DT",DateUtil.formatDate("yyyyMMddhhmmss"));	// 접수일시
		//params.put("MDFCN_DT",new Date());							// 수정일시
		
		
//		params.put("PLANFILE", mpr.getFileMap().get("PLANFILE").getOriginalFilename());		//창업계획
//		params.put("REGFILE", mpr.getFileMap().get("REGFILE").getOriginalFilename());		//주민등록초본
//		params.put("FACTFILE", mpr.getFileMap().get("FACTFILE").getOriginalFilename());		//사실증명
//		params.put("COOKFILE", mpr.getFileMap().get("COOKFILE").getOriginalFilename());		//우대사항
//		params.put("ITEMFILE", mpr.getFileMap().get("ITEMFILE").getOriginalFilename());		//창업아이템 관련  경력 3년 이상
//		params.put("FOODFILE", mpr.getFileMap().get("FOODFILE").getOriginalFilename());		//음식조리 관련 자격증 보유
//		params.put("AWARDFILE", mpr.getFileMap().get("AWARDFILE").getOriginalFilename());	//정부/지자체 시행 음식 경진대회 입상 경력
//		params.put("ETCFILE", mpr.getFileMap().get("ETCFILE").getOriginalFilename());		//기타 우대조건
		
		
		
		
		
//		ObjectMapper mapper = new ObjectMapper();
//		
//        String json = mapper.writerWithDefaultPrettyPrinter().writeValueAsString(params);
//
//        System.out.println(json);       // pretty-print
//		
//		params.put("RCPT_DATA",json);	// 접수데이터 json형태로  RCPT_DATA에 저장
//		dao.indvdlInsert(params);		

		//#################   파일저장 세팅 (#################################################
		Map<String, Object> fileMap = new HashMap();
		fileMap.put("BIZ_YR",params.get("BIZ_YR"));
		fileMap.put("BIZ_NO",params.get("BIZ_NO"));
		fileMap.put("BIZ_CYCL",params.get("BIZ_CYCL"));
		fileMap.put("RCEPT_SN",params.get("RCEPT_SN"));				// 접수일련번호(상기 세팅)
		fileMap.put("FILE_PATH",UPLOAD_PATH);
		fileMap.put("RGTR",params.get("userId"));					// 등록자
		fileMap.put("MDFR",params.get("userId"));					// 수정자
		
		params.put("RCEPT_DT",DateUtil.formatDate("yyyyMMddhhmmss"));
		
		System.out.println("##############***** mpr.getFileMap().toString() ******#################");
		
		//파일저장 Test
		Map<String,String> filesaveMap = new HashMap();
		
		if(!mpr.getFileMap().get("PLANFILE").getOriginalFilename().equals("")) {
			fileMap.put("ORGNL_FILE_NM", mpr.getFileMap().get("PLANFILE").getOriginalFilename());
			fileMap.put("FILE_SZ",mpr.getFileMap().get("PLANFILE").getSize());
			fileMap.put("FILE_SE", "PLANFILE");
			
			filesaveMap = fileUtil.uploadFile(UPLOAD_PATH, mpr.getFile("PLANFILE"));
			fileMap.put("FILE_NM",filesaveMap.get("uuid"));
			dao.fileInsertTest(fileMap);
			
		}
		if(!mpr.getFileMap().get("REGFILE").getOriginalFilename().equals("")) {
			fileMap.put("ORGNL_FILE_NM", mpr.getFileMap().get("REGFILE").getOriginalFilename());
			fileMap.put("FILE_SZ",mpr.getFileMap().get("REGFILE").getSize());
			fileMap.put("FILE_SE", "REGFILE");
			
			filesaveMap = fileUtil.uploadFile(UPLOAD_PATH, mpr.getFile("REGFILE"));
			fileMap.put("FILE_NM",filesaveMap.get("uuid"));
			dao.fileInsertTest(fileMap);
		}
		if(!mpr.getFileMap().get("FACTFILE").getOriginalFilename().equals("")) {
			fileMap.put("ORGNL_FILE_NM", mpr.getFileMap().get("FACTFILE").getOriginalFilename());
			fileMap.put("FILE_SZ",mpr.getFileMap().get("FACTFILE").getSize());
			fileMap.put("FILE_SE", "FACTFILE");
			
			filesaveMap = fileUtil.uploadFile(UPLOAD_PATH, mpr.getFile("FACTFILE"));
			fileMap.put("FILE_NM",filesaveMap.get("uuid"));
			dao.fileInsertTest(fileMap);
		}
		if(!mpr.getFileMap().get("COOKFILE").getOriginalFilename().equals("")) {
			fileMap.put("ORGNL_FILE_NM", mpr.getFileMap().get("COOKFILE").getOriginalFilename());
			fileMap.put("FILE_SZ",mpr.getFileMap().get("COOKFILE").getSize());
			fileMap.put("FILE_SE", "COOKFILE");
			
			filesaveMap = fileUtil.uploadFile(UPLOAD_PATH, mpr.getFile("COOKFILE"));
			fileMap.put("FILE_NM",filesaveMap.get("uuid"));
			dao.fileInsertTest(fileMap);
		}
		if(!mpr.getFileMap().get("ITEMFILE").getOriginalFilename().equals("")) {
			fileMap.put("ORGNL_FILE_NM", mpr.getFileMap().get("ITEMFILE").getOriginalFilename());
			fileMap.put("FILE_SZ",mpr.getFileMap().get("ITEMFILE").getSize());
			fileMap.put("FILE_SE", "ITEMFILE");
			
			filesaveMap = fileUtil.uploadFile(UPLOAD_PATH, mpr.getFile("ITEMFILE"));
			fileMap.put("FILE_NM",filesaveMap.get("uuid"));
			dao.fileInsertTest(fileMap);
		}
		if(!mpr.getFileMap().get("FOODFILE").getOriginalFilename().equals("")) {
			fileMap.put("ORGNL_FILE_NM", mpr.getFileMap().get("FOODFILE").getOriginalFilename());
			fileMap.put("FILE_SZ",mpr.getFileMap().get("FOODFILE").getSize());
			fileMap.put("FILE_SE", "FOODFILE");
			
			filesaveMap = fileUtil.uploadFile(UPLOAD_PATH, mpr.getFile("FOODFILE"));
			fileMap.put("FILE_NM",filesaveMap.get("uuid"));
			dao.fileInsertTest(fileMap);
		}
		if(!mpr.getFileMap().get("AWARDFILE").getOriginalFilename().equals("")) {
			fileMap.put("ORGNL_FILE_NM", mpr.getFileMap().get("AWARDFILE").getOriginalFilename());
			fileMap.put("FILE_SZ",mpr.getFileMap().get("AWARDFILE").getSize());
			fileMap.put("FILE_SE", "AWARDFILE");
			
			filesaveMap = fileUtil.uploadFile(UPLOAD_PATH, mpr.getFile("AWARDFILE"));
			fileMap.put("FILE_NM",filesaveMap.get("uuid"));
			dao.fileInsertTest(fileMap);
		}
		if(!mpr.getFileMap().get("ETCFILE").getOriginalFilename().equals("")) {
			fileMap.put("ORGNL_FILE_NM", mpr.getFileMap().get("ETCFILE").getOriginalFilename());
			fileMap.put("FILE_SZ",mpr.getFileMap().get("ETCFILE").getSize());
			fileMap.put("FILE_SE", "ETCFILE");
			
			filesaveMap = fileUtil.uploadFile(UPLOAD_PATH, mpr.getFile("ETCFILE"));
			fileMap.put("FILE_NM",filesaveMap.get("uuid"));
			dao.fileInsertTest(fileMap);
		}
		
		ObjectMapper mapper = new ObjectMapper();
        String json = mapper.writerWithDefaultPrettyPrinter().writeValueAsString(params);
        System.out.println(json);   					// pretty-print
		params.put("RCPT_DATA",json);					// 접수데이터
		
		Map<String, Object> map = new HashMap<>();
		if (dao.indvdlInsert(params) == 0) {
			map.put("result", false);
		} else {
			map.put("result", true);
		}
		return map;
	}
	
	
}
