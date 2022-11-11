package com.mc.web.programs.back.biz001.impl;

import java.util.*;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.mc.web.programs.back.biz001.AdminBiz001Controller;
import jdk.nashorn.internal.parser.JSONParser;
import net.sf.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.mc.web.MCMap;
import com.mc.web.programs.back.biz001.AdminBiz001DAO;
import com.mc.web.programs.back.biz001.AdminBiz001Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;





/**
 *
 * @Description : bizmanage 프로그램 구현
 * @ClassName   : com.mc.web.programs.back.bizmanage.impl.AdminBizmanageServiceImpl.java
 * @Modification Information
 *
 * @author MSLK_JJS
 * @since 2018. 3. 29.
 * @version 1.0 *  
 * Copyright (C)  All right reserved.
 */
@Service
public class AdminBiz001ServiceImpl extends EgovAbstractServiceImpl implements AdminBiz001Service {

	@Autowired
	private AdminBiz001DAO dao;

	@Value("#{config['bizUpload.data']}")
	private String UPLOAD_PATH;

	private static final Logger logger = LoggerFactory.getLogger(AdminBiz001ServiceImpl.class);
	
//	public Map list(Map params) throws Exception {
//		Map rstMap = new HashMap();
//		rstMap.put("list", dao.list(params));
//		rstMap.put("pagination", dao.pagination(params));
//		return rstMap;
//	}
	
	public Map<String,Object> selectGridHeader() throws Exception{
		//Map rstMap = new HashMap();
		//rstMap.put("columnLayout", dao.selectGridHeader());
		Map<String,Object> rstMap = dao.selectGridHeader();
		return rstMap;
		
		
	}
	
	public List<MCMap> selectGridData(Map<String, String> params) throws Exception{
		List<MCMap> rstMap = dao.selectGridData(params);
		return rstMap;
	}
	
	public Map selectBizInfo(Map params) throws Exception{
		Map rstMap = new  HashMap();
		rstMap.put("bizInfo", dao.selectBizInfo(params));
		return rstMap;
	}

	public Map<String, Object> indvdlSelectOne(Map<String, Object> params) throws Exception {
		return dao.indvdlSelectOne(params);
	}

	@Transactional(rollbackFor = { Exception.class })
	public Map<String, Object> indvdlInsert(Map<String, Object> params) throws Exception {

		ArrayList<Object> addList = (ArrayList<Object>) params.get("addList"); // 추가 리스트 얻기

		//ArrayList<Object> updateList = (ArrayList<Object>) params.get("updateList"); // 수정 리스트 얻기
		//logger.info("수정 : " + updateList.toString());
		//ArrayList<Object> removeList = (ArrayList<Object>) params.get("removeList"); // 제거 리스트 얻기
		//logger.info("삭제 : " + removeList.toString());
		// 여기서 비지니스 로직을 작성하거나, 서비스 로직을 실행하세요.


		logger.info("=========================================================");
		logger.info("addList count : " + addList.size());
		logger.info("addList String : " + addList.toString());
		String strJson = addList.toString();
		logger.info("strJson : " + strJson.toString());
		Object[] strArray = addList.toArray();
		logger.info("strArray : " + strArray.toString());
		logger.info("strArray[0].toString() : " + strArray[0].toString());
		logger.info("strArray[0].toString() : " + strArray[0].toString());

		strJson= strJson.replaceAll("0=","REQST_REALM=");
		logger.info("strJson : " + strJson.toString());

		//2. Parser
		//JSONParser jsonParser = new JSONParser();

		//3. To Object
		//Object obj = jsonParser.parse(strJson);

		//4. To JsonObject
		//JSONObject jsonObj = (JSONObject) obj;

		logger.info("=========================================================");

		/// 콘솔로 찍어보기

		Map<String, Object> insertdata = new HashMap<>();
		Map<String, Object> bizsnnow = new HashMap<>();

		bizsnnow.put("BIZ_YR", "2023");				// 사업년도
		bizsnnow.put("BIZ_NO","01");					// 사업번호
		bizsnnow.put("BIZ_CYCL","01");					// 사업차수

		insertdata.put("RCEPT_SN", dao.selectBizSnNow(bizsnnow)+1);// 사업일련번호
		insertdata.put("RCEPT_NO", bizsnnow.get("BIZ_YR").toString()+bizsnnow.get("BIZ_NO").toString()+bizsnnow.get("BIZ_CYCL").toString()+insertdata.get("RCEPT_SN").toString());				// 접수번호

		Map<String, Object> rceptSeMap = new HashMap();
		rceptSeMap.put("code_group_seq", 15);
		rceptSeMap.put("code", "03");
		insertdata.put("RCEPT_SE",dao.selectCodeNm(rceptSeMap).get("CODE_NM")); // 접수구분

		logger.info("=========================================================");
		logger.info("RCEPT_SE : " + insertdata.get("RCEPT_SE").toString());
		logger.info("=========================================================");


		Map<String, Object> indvdlGrpSeCdMap = new HashMap();
		indvdlGrpSeCdMap.put("code_group_seq", 9);
		indvdlGrpSeCdMap.put("code", "01");
		insertdata.put("INDVDL_GRP_SE_CD",dao.selectCodeNm(indvdlGrpSeCdMap).get("CODE_NM"));		// 개인,단체 구분코드
		//params.put("INDVDL_GRP_SE_CD","01");		// 개인,단체 구분코드
		logger.info("=========================================================");
		logger.info("INDVDL_GRP_SE_CD : " + insertdata.get("INDVDL_GRP_SE_CD").toString());
		logger.info("=========================================================");


		Map<String, Object> bizSeCdMap = new HashMap();
		bizSeCdMap.put("code_group_seq", 12);
		bizSeCdMap.put("code", "01");
		insertdata.put("BIZ_SE_CD",dao.selectCodeNm(bizSeCdMap).get("CODE_NM"));				// 사업 구분코드
		//params.put("BIZ_SE_CD","01");				// 사업 구분코드

		insertdata.put("DATA_SE_CD","01");				// 자료구분코드


		Map<String, Object> rcptStep = new HashMap();
        Map<String, Object> rcptSttsMap = new HashMap();

		rcptStep.put("code_group_seq", 14);
		rcptStep.put("code", "01");
		rcptSttsMap.put("code_group_seq", 13);
		rcptSttsMap.put("code", "03");

		insertdata.put("RCPT_STEP","01");				// 접수단계
		insertdata.put("RCPT_STTS","03");				// 접수상태
		insertdata.put("STEP",dao.selectCodeNm(rcptStep).get("CODE_NM"));					// 접수단계
		insertdata.put("STTUS",dao.selectCodeNm(rcptSttsMap).get("CODE_NM"));					// 접수상태

		insertdata.put("BIZ_REL_AGRE_YN","Y");			// 사업관련동의여부
		insertdata.put("MYDATA_AGRE_YN","N");			// 마이데이터동의여부
		insertdata.put("RGTR","admin");					// 등록자
		insertdata.put("MDFR","admin");					// 수정자
		insertdata.put("RCEPT_DT",new Date());			// 접수일시

		logger.info("=========================================================");
		logger.info("insertdata : " + insertdata.toString());
		logger.info("=========================================================");

/*


		ObjectMapper mapper = new ObjectMapper();

		//String json = mapper.writeValueAsString(params);

		//System.out.println(json);   // compact-print

		String json = mapper.writerWithDefaultPrettyPrinter().writeValueAsString(params);

		System.out.println(json);   // pretty-print



		inserdata.put("RCPT_DATA",json);					// 접수데이터

*/
		Map<String, Object> map = new HashMap<>();
//		if (dao.indvdlInsert(params) == 0) {
//			map.put("result", false);
//		} else {
		map.put("result", true);
//		}
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

}
