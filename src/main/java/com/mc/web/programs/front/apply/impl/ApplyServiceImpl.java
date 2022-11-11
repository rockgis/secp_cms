package com.mc.web.programs.front.apply.impl;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.mc.common.util.DateUtil;
import com.mc.web.MCMap;
import com.mc.web.common.FileUtil;
import com.mc.web.programs.front.apply.ApplyDAO;
import com.mc.web.programs.front.apply.ApplyService;

import egovframework.com.cmm.util.EgovHttpRequestHelper;
import kr.ggbaro.util.common.execl.ExeclToPdf;

/**
 *
 * @Description : 온라인 접수 프로그램 서비스 구현
 * @ClassName   : com.mc.web.programs.apply.impl.ApplyServiceImpl.java
 * @Modification Information
 *
 * @author khkim
 * @since 2018. 3. 29.
 * @version 1.0 *  
 * Copyright (C)  All right reserved.
 */
@Service
public class ApplyServiceImpl implements ApplyService {
	
	@Value("#{config['bizUpload.temp']}")
	private String TEMP_PATH;
	@Value("#{config['bizUpload.data']}")
	private String UPLOAD_PATH;
	@Value("#{config['bizUpload.pdfTemplates']}")
	private String PDF_TEMPLATES_PATH;
	@Value("#{config['bizUpload.pdf']}")
	private String PDF_UPLOAD_PATH;
	
	
	@Autowired
	private ApplyDAO dao;
	
	@Autowired
	private FileUtil fileUtil;
	
	
	public int selectBizSnNow(Map<String, Object> params) throws Exception{
		return dao.selectBizSnNow(params);
	}
	
	
	public String isAgree(Map<String, Object> params) throws Exception {
		return dao.isAgree(params);
	}
	
	public String list(Map<String, String> params) throws Exception {
		return "programs/apply/list";
	}
	
	@Transactional(rollbackFor = {Exception.class})
	public List<Map<String, Object>> getListData(Map<String, Object> params) throws Exception {
		return dao.getListData(params);
	}
	
	public String mngEnv(Map<String, String> params) throws Exception {
		return "programs/apply/mngEnv";
	}
	
	public Map<String, Object> indvdlSelectOne(Map<String, Object> params) throws Exception {
		return dao.indvdlSelectOne(params);
	}
	
	@Transactional(rollbackFor = { Exception.class })
	public Map<String, Object> indvdlInsert(Map<String, Object> params, MultipartHttpServletRequest mpr) throws Exception {
		
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
		
		
		
		
		
		
		params.put("BIZ_REL_AGRE_YN","Y");			// 사업관련동의여부
		params.put("MYDATA_AGRE_YN","N");			// 마이데이터동의여부
		params.put("RGTR",params.get("userId"));					// 등록자
		params.put("MDFR",params.get("userId"));					// 수정자
		
		params.put("RCEPT_DT",DateUtil.formatDate("yyyyMMddhhmmss"));			// 접수일시
		//params.put("MDFCN_DT",new Date());			// 수정일시
		
		params.put("1_YY_SM_1", params.get("tax0")); 			//부가세(전년도) 계
		params.put("1_YY_SM_2", params.get("tax1")); 			//부가세(현재년도) 계
		
		params.put("STOR_INNER", mpr.getFileMap().get("STOR_INNER").getOriginalFilename());
		
		
		
		
		
//		System.out.println("############ STOR_INNER : "+mpr.getFileMap().get("STOR_INNER").getOriginalFilename());
//		System.out.println("############ STOR_EXTRL : "+mpr.getFileMap().get("STOR_EXTRL").getOriginalFilename());
		

		//#################   파일저장 세팅 (#################################################
		Map<String, Object> fileMap = new HashMap();
		fileMap.put("BIZ_YR",params.get("BIZ_YR"));
		fileMap.put("BIZ_NO",params.get("BIZ_NO"));
		fileMap.put("BIZ_CYCL",params.get("BIZ_CYCL"));
		fileMap.put("RCEPT_SN",params.get("RCEPT_SN"));		// 접수일련번호(상기 세팅)
		fileMap.put("FILE_PATH",UPLOAD_PATH);
		fileMap.put("RGTR",params.get("userId"));					// 등록자
		fileMap.put("MDFR",params.get("userId"));					// 수정자
		
		//fileMap.put("ORGNL_FILE_NM",mpr.getFileMap().get("STOR_INNER").getOriginalFilename());
		//fileMap.put("FILE_EXTN",mpr.getFileMap().get("STOR_INNER").get);
		
		
		System.out.println("############## mpr.getFileMap().toString() #################");
		//System.out.println(mpr.getFileMap().get("STOR_INNER").);
		
		//for(int i=0;i<mpr.getFileMap().size();i++) {
		
		Map<String,String> filesaveMap = new HashMap();
		
		if(!mpr.getFileMap().get("STOR_INNER").getOriginalFilename().equals("")) {
			
			fileMap.put("ORGNL_FILE_NM", mpr.getFileMap().get("STOR_INNER").getOriginalFilename());
			fileMap.put("FILE_SZ",mpr.getFileMap().get("STOR_INNER").getSize());
			fileMap.put("FILE_SE", "STOR_INNER");
			
			filesaveMap = fileUtil.uploadFile(UPLOAD_PATH, mpr.getFile("STOR_INNER"));
			fileMap.put("FILE_NM",filesaveMap.get("uuid"));
			dao.fileInsert(fileMap);
			
		}
		if(!mpr.getFileMap().get("STOR_EXTRL").getOriginalFilename().equals("")) {
			fileMap.put("ORGNL_FILE_NM", mpr.getFileMap().get("STOR_EXTRL").getOriginalFilename());
			fileMap.put("FILE_SZ",mpr.getFileMap().get("STOR_EXTRL").getSize());
			fileMap.put("FILE_SE", "STOR_EXTRL");
			
			filesaveMap = fileUtil.uploadFile(UPLOAD_PATH, mpr.getFile("STOR_EXTRL"));
			fileMap.put("FILE_NM",filesaveMap.get("uuid"));
			dao.fileInsert(fileMap);
		}
		if(!mpr.getFileMap().get("IMPRVM_PHOTO_1").getOriginalFilename().equals("")) {
			fileMap.put("ORGNL_FILE_NM", mpr.getFileMap().get("IMPRVM_PHOTO_1").getOriginalFilename());
			fileMap.put("FILE_SZ",mpr.getFileMap().get("IMPRVM_PHOTO_1").getSize());
			fileMap.put("FILE_SE", "IMPRVM_PHOTO_1");
			
			filesaveMap = fileUtil.uploadFile(UPLOAD_PATH, mpr.getFile("IMPRVM_PHOTO_1"));
			fileMap.put("FILE_NM",filesaveMap.get("uuid"));
			dao.fileInsert(fileMap);
		}
		if(!mpr.getFileMap().get("IMPRVM_PHOTO_2").getOriginalFilename().equals("")) {
			fileMap.put("ORGNL_FILE_NM", mpr.getFileMap().get("IMPRVM_PHOTO_2").getOriginalFilename());
			fileMap.put("FILE_SZ",mpr.getFileMap().get("IMPRVM_PHOTO_2").getSize());
			fileMap.put("FILE_SE", "IMPRVM_PHOTO_2");
			
			filesaveMap = fileUtil.uploadFile(UPLOAD_PATH, mpr.getFile("IMPRVM_PHOTO_2"));
			fileMap.put("FILE_NM",filesaveMap.get("uuid"));
			dao.fileInsert(fileMap);
		}
		if(!mpr.getFileMap().get("IMPRVM_PHOTO_3").getOriginalFilename().equals("")) {
			fileMap.put("ORGNL_FILE_NM", mpr.getFileMap().get("IMPRVM_PHOTO_3").getOriginalFilename());
			fileMap.put("FILE_SZ",mpr.getFileMap().get("IMPRVM_PHOTO_3").getSize());
			fileMap.put("FILE_SE", "IMPRVM_PHOTO_3");
			
			filesaveMap = fileUtil.uploadFile(UPLOAD_PATH, mpr.getFile("IMPRVM_PHOTO_3"));
			fileMap.put("FILE_NM",filesaveMap.get("uuid"));
			dao.fileInsert(fileMap);
		}
		if(!mpr.getFileMap().get("IMPRVM_PHOTO_4").getOriginalFilename().equals("")) {
			fileMap.put("ORGNL_FILE_NM", mpr.getFileMap().get("IMPRVM_PHOTO_4").getOriginalFilename());
			fileMap.put("FILE_SZ",mpr.getFileMap().get("IMPRVM_PHOTO_4").getSize());
			fileMap.put("FILE_SE", "IMPRVM_PHOTO_4");
			
			filesaveMap = fileUtil.uploadFile(UPLOAD_PATH, mpr.getFile("IMPRVM_PHOTO_4"));
			fileMap.put("FILE_NM",filesaveMap.get("uuid"));
			dao.fileInsert(fileMap);
		}
		if(!mpr.getFileMap().get("IMPRVM_PHOTO_5").getOriginalFilename().equals("")) {
			fileMap.put("ORGNL_FILE_NM", mpr.getFileMap().get("IMPRVM_PHOTO_5").getOriginalFilename());
			fileMap.put("FILE_SZ",mpr.getFileMap().get("IMPRVM_PHOTO_5").getSize());
			fileMap.put("FILE_SE", "IMPRVM_PHOTO_5");
			
			filesaveMap = fileUtil.uploadFile(UPLOAD_PATH, mpr.getFile("IMPRVM_PHOTO_5"));
			fileMap.put("FILE_NM",filesaveMap.get("uuid"));
			dao.fileInsert(fileMap);
		}
		if(!mpr.getFileMap().get("IMPRVM_PHOTO_6").getOriginalFilename().equals("")) {
			fileMap.put("ORGNL_FILE_NM", mpr.getFileMap().get("IMPRVM_PHOTO_6").getOriginalFilename());
			fileMap.put("FILE_SZ",mpr.getFileMap().get("IMPRVM_PHOTO_6").getSize());
			fileMap.put("FILE_SE", "IMPRVM_PHOTO_6");
			
			filesaveMap = fileUtil.uploadFile(UPLOAD_PATH, mpr.getFile("IMPRVM_PHOTO_6"));
			fileMap.put("FILE_NM",filesaveMap.get("uuid"));
			dao.fileInsert(fileMap);
		}
		if(!mpr.getFileMap().get("CNSTRCT_PRQUDO_1").getOriginalFilename().equals("")) {
			fileMap.put("ORGNL_FILE_NM", mpr.getFileMap().get("CNSTRCT_PRQUDO_1").getOriginalFilename());
			fileMap.put("FILE_SZ",mpr.getFileMap().get("CNSTRCT_PRQUDO_1").getSize());
			fileMap.put("FILE_SE", "CNSTRCT_PRQUDO_1");
			
			filesaveMap = fileUtil.uploadFile(UPLOAD_PATH, mpr.getFile("CNSTRCT_PRQUDO_1"));
			fileMap.put("FILE_NM",filesaveMap.get("uuid"));
			dao.fileInsert(fileMap);
		}
		if(!mpr.getFileMap().get("CNSTRCT_ENTRPS_BSNM_CEREGRT_1").getOriginalFilename().equals("")) {
			fileMap.put("ORGNL_FILE_NM", mpr.getFileMap().get("CNSTRCT_ENTRPS_BSNM_CEREGRT_1").getOriginalFilename());
			fileMap.put("FILE_SZ",mpr.getFileMap().get("CNSTRCT_ENTRPS_BSNM_CEREGRT_1").getSize());
			fileMap.put("FILE_SE", "CNSTRCT_ENTRPS_BSNM_CEREGRT_1");
			
			filesaveMap = fileUtil.uploadFile(UPLOAD_PATH, mpr.getFile("CNSTRCT_ENTRPS_BSNM_CEREGRT_1"));
			fileMap.put("FILE_NM",filesaveMap.get("uuid"));
			dao.fileInsert(fileMap);
		}
		if(!mpr.getFileMap().get("CNSTRCT_PRQUDO_2").getOriginalFilename().equals("")) {
			fileMap.put("ORGNL_FILE_NM", mpr.getFileMap().get("CNSTRCT_PRQUDO_2").getOriginalFilename());
			fileMap.put("FILE_SZ",mpr.getFileMap().get("CNSTRCT_PRQUDO_2").getSize());
			fileMap.put("FILE_SE", "CNSTRCT_PRQUDO_2");
			
			filesaveMap = fileUtil.uploadFile(UPLOAD_PATH, mpr.getFile("CNSTRCT_PRQUDO_2"));
			fileMap.put("FILE_NM",filesaveMap.get("uuid"));
			dao.fileInsert(fileMap);
		}
		if(!mpr.getFileMap().get("CNSTRCT_ENTRPS_BSNM_CEREGRT_2").getOriginalFilename().equals("")) {
			fileMap.put("ORGNL_FILE_NM", mpr.getFileMap().get("CNSTRCT_ENTRPS_BSNM_CEREGRT_2").getOriginalFilename());
			fileMap.put("FILE_SZ",mpr.getFileMap().get("CNSTRCT_ENTRPS_BSNM_CEREGRT_2").getSize());
			fileMap.put("FILE_SE", "CNSTRCT_ENTRPS_BSNM_CEREGRT_2");
			
			filesaveMap = fileUtil.uploadFile(UPLOAD_PATH, mpr.getFile("CNSTRCT_ENTRPS_BSNM_CEREGRT_2"));
			fileMap.put("FILE_NM",filesaveMap.get("uuid"));
			dao.fileInsert(fileMap);
		}
		if(!mpr.getFileMap().get("BSNM_CEREGRT").getOriginalFilename().equals("")) {
			fileMap.put("ORGNL_FILE_NM", mpr.getFileMap().get("BSNM_CEREGRT").getOriginalFilename());
			fileMap.put("FILE_SZ",mpr.getFileMap().get("BSNM_CEREGRT").getSize());
			fileMap.put("FILE_SE", "BSNM_CEREGRT");
			
			filesaveMap = fileUtil.uploadFile(UPLOAD_PATH, mpr.getFile("BSNM_CEREGRT"));
			fileMap.put("FILE_NM",filesaveMap.get("uuid"));
			dao.fileInsert(fileMap);
		}
		if(!mpr.getFileMap().get("VAT_CRTF").getOriginalFilename().equals("")) {
			fileMap.put("ORGNL_FILE_NM", mpr.getFileMap().get("VAT_CRTF").getOriginalFilename());
			fileMap.put("FILE_SZ",mpr.getFileMap().get("VAT_CRTF").getSize());
			fileMap.put("FILE_SE", "VAT_CRTF");
			
			filesaveMap = fileUtil.uploadFile(UPLOAD_PATH, mpr.getFile("VAT_CRTF"));
			fileMap.put("FILE_NM",filesaveMap.get("uuid"));
			dao.fileInsert(fileMap);
		}
		if(!mpr.getFileMap().get("CPR_ADIT_PAPERS").getOriginalFilename().equals("")) {
			fileMap.put("ORGNL_FILE_NM", mpr.getFileMap().get("CPR_ADIT_PAPERS").getOriginalFilename());
			fileMap.put("FILE_SZ",mpr.getFileMap().get("CPR_ADIT_PAPERS").getSize());
			fileMap.put("FILE_SE", "CPR_ADIT_PAPERS");
			
			filesaveMap = fileUtil.uploadFile(UPLOAD_PATH, mpr.getFile("CPR_ADIT_PAPERS"));
			fileMap.put("FILE_NM",filesaveMap.get("uuid"));
			dao.fileInsert(fileMap);
		}
		if(!mpr.getFileMap().get("SOCTY_WKSN").getOriginalFilename().equals("")) {
			fileMap.put("ORGNL_FILE_NM", mpr.getFileMap().get("SOCTY_WKSN").getOriginalFilename());
			fileMap.put("FILE_SZ",mpr.getFileMap().get("SOCTY_WKSN").getSize());
			fileMap.put("FILE_SE", "SOCTY_WKSN");
			
			filesaveMap = fileUtil.uploadFile(UPLOAD_PATH, mpr.getFile("SOCTY_WKSN"));
			fileMap.put("FILE_NM",filesaveMap.get("uuid"));
			dao.fileInsert(fileMap);
		}
		if(!mpr.getFileMap().get("EDC_CNSL_1").getOriginalFilename().equals("")) {
			fileMap.put("ORGNL_FILE_NM", mpr.getFileMap().get("EDC_CNSL_1").getOriginalFilename());
			fileMap.put("FILE_SZ",mpr.getFileMap().get("EDC_CNSL_1").getSize());
			fileMap.put("FILE_SE", "EDC_CNSL_1");
			
			filesaveMap = fileUtil.uploadFile(UPLOAD_PATH, mpr.getFile("EDC_CNSL_1"));
			fileMap.put("FILE_NM",filesaveMap.get("uuid"));
			dao.fileInsert(fileMap);
		}
		if(!mpr.getFileMap().get("EDC_CNSL_2").getOriginalFilename().equals("")) {
			fileMap.put("ORGNL_FILE_NM", mpr.getFileMap().get("EDC_CNSL_2").getOriginalFilename());
			fileMap.put("FILE_SZ",mpr.getFileMap().get("EDC_CNSL_2").getSize());
			fileMap.put("FILE_SE", "EDC_CNSL_2");
			
			filesaveMap = fileUtil.uploadFile(UPLOAD_PATH, mpr.getFile("EDC_CNSL_2"));
			fileMap.put("FILE_NM",filesaveMap.get("uuid"));
			dao.fileInsert(fileMap);
		}
		if(!mpr.getFileMap().get("CARBON_PNT").getOriginalFilename().equals("")) {
			fileMap.put("ORGNL_FILE_NM", mpr.getFileMap().get("CARBON_PNT").getOriginalFilename());
			fileMap.put("FILE_SZ",mpr.getFileMap().get("CARBON_PNT").getSize());
			fileMap.put("FILE_SE", "CARBON_PNT");
			
			filesaveMap = fileUtil.uploadFile(UPLOAD_PATH, mpr.getFile("CARBON_PNT"));
			fileMap.put("FILE_NM",filesaveMap.get("uuid"));
			dao.fileInsert(fileMap);
		}
		
		//#################   pdf 파일저장 세팅 (#################################################
		//### 지원신청서
		List<Map<String,Object>> pdfMap = new ArrayList<Map<String,Object>>();
		
		Map<String,Object> map1 = new HashMap<String, Object>();
		
		map1.put("templatesFile", PDF_TEMPLATES_PATH+"\\biz001\\templates\\biz001_templates_new.xlsx"); // 경영환경개선
		map1.put("sheetOrder","1"); // 신청서
		map1.put("PDF_UPLOAD_PATH",PDF_UPLOAD_PATH);
		map1.put("savePdf",map1.get("PDF_UPLOAD_PATH")+"/"+params.get("BIZ_YR")+"-"+params.get("BIZ_NO")+"-"+params.get("BIZ_CYCL")+"-지원신청서-"+params.get("userId").toString()+".pdf");
		
		Map<String,Object> map2 = new HashMap<String, Object>();
		
		params.put("RCEPT_DT",DateUtil.formatDate("yyyy년 MM월 dd일"));		
		
		params.put("#{R_1}",params.get("REQST_REALM"));		
		if(params.get("REQST_REALM").equals("점포환경개선")) {
			params.put("#{R_2}","(공급가 100% \r\n최대 300만원)");	
		}else {
			params.put("#{R_2}","(공급가 100% \r\n최대 200만원)");
		}
			
		
		params.put("#{R_3}",params.get("REQST_REALM_DTL"));					


		map2 = params;
		
		
		pdfMap.add(map1);
		pdfMap.add(map2);
		
		
		System.out.println(pdfMap);
		
		String result = ExeclToPdf.realConvertExcelToPdf(pdfMap);
		
		fileMap.put("ORGNL_FILE_NM", params.get("BIZ_YR")+"-"+params.get("BIZ_NO")+"-"+params.get("BIZ_CYCL")+"-지원신청서-"+params.get("userId").toString()+".pdf");
		fileMap.put("FILE_SZ",0);
		fileMap.put("FILE_SE", "지원신청서");
		fileMap.put("FILE_NM",result+".pdf");
		fileMap.put("FILE_PATH",map1.get("PDF_UPLOAD_PATH").toString());
		dao.fileInsert(fileMap);
		
		String fileFrom = params.get("BIZ_YR")+"-"+params.get("BIZ_NO")+"-"+params.get("BIZ_CYCL")+"-지원신청서-"+params.get("userId").toString()+".pdf";
		String fileTo = result+".pdf";
		
		
		File oldfile = new File(map1.get("PDF_UPLOAD_PATH")+"/"+params.get("BIZ_YR")+"-"+params.get("BIZ_NO")+"-"+params.get("BIZ_CYCL")+"-지원신청서-"+params.get("userId").toString()+".pdf");
		File newfile = new File(map1.get("PDF_UPLOAD_PATH")+"/"+result+".pdf");

		if(oldfile.renameTo(newfile)){
			System.out.println("File rename success");
		}else{
			System.out.println("File rename fail");
		}
		
		params.put("SPORT_REQSTDOC", result+".pdf");

		
		//fileUtil.copy(fileFrom, fileTo, map1.get("PDF_UPLOAD_PATH").toString());
			
		
		ObjectMapper mapper = new ObjectMapper();
		//String json = mapper.writeValueAsString(params);
        //System.out.println(json);   // compact-print
        String json = mapper.writerWithDefaultPrettyPrinter().writeValueAsString(params);
        System.out.println(json);   // pretty-print
		params.put("RCPT_DATA",json);					// 접수데이터
		
		Map<String, Object> map = new HashMap<>();
		if (dao.indvdlInsert(params) == 0) {
			map.put("result", false);
		} else {
			if(!result.equals("")) {
				map.put("result", true);	
			}else {
				map.put("result", false);
			}
			
		}
		return map;
	}
	
	public Map<String, Object> indvdlUpdate(Map<String, Object> params) throws Exception {
		Map<String, Object> map = new HashMap<>();
		if (dao.indvdlUpdate(params) == 0) {
			map.put("result", false);
		} else {
			map.put("result", true);
		}
		return map;
	}
	
	public Map<String, Object> grpSelectOne(Map<String, Object> params) throws Exception {
		return dao.grpSelectOne(params);
	}
	
	public Map<String, Object> grpInsert(Map<String, Object> params) throws Exception {
		Map<String, Object> map = new HashMap<>();
		if (dao.grpInsert(params) == 0) {
			map.put("result", false);
		} else {
			map.put("result", true);
		}
		return map;
	}
	
	public Map<String, Object> grpUpdate(Map<String, Object> params) throws Exception {
		Map<String, Object> map = new HashMap<>();
		if (dao.grpUpdate(params) == 0) {
			map.put("result", false);
		} else {
			map.put("result", true);
		}
		return map;
	}

	public String applyEasy(Map<String, Object> params) throws Exception {
		return "programs/apply/applyEasyIndex";
	}
	
	public String applyEasySelfAuth(Map<String, Object> params) throws Exception {
		return "programs/apply/applyEasyAuth";
	}
	
	public String applyEasyPrvlg(Map<String, Object> params) throws Exception {
		return "programs/apply/applyEasyPrvlg";
	}
	
	public String applyEasyMydataReqPage(Map<String, Object> params) throws Exception {
		return "programs/apply/applyEasyLoading";
	}

}
