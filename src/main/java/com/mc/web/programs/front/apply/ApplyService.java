package com.mc.web.programs.front.apply;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.mc.web.MCMap;

/**
 *
 * @Description : 온라인 접수 프로그램 인터페이스
 * @ClassName   : com.mc.web.programs.apply.ApplyService.java
 * @Modification Information
 *
 * @author khkim
 * @since 2018. 3. 29.
 * @version 1.0 *  
 * Copyright (C)  All right reserved.
 */
public interface ApplyService {
	
	public int selectBizSnNow(Map<String, Object> params) throws Exception;
	
	
	/**
	 * 사업 동의 여부 select
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public String isAgree(Map<String, Object> params) throws Exception;

	public String list(Map<String, String> params) throws Exception;
	
	/**
	 * 온라인 접수 지원사업 리스트 데이터
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> getListData(Map<String, Object> params) throws Exception;
	
	public String mngEnv(Map<String, String> params) throws Exception;
	
	/**
	 * 개인 지원사업 select one
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> indvdlSelectOne(Map<String, Object> params) throws Exception;
	
	/**
	 * 개인 지원사업 insert
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> indvdlInsert(Map<String, Object> params, MultipartHttpServletRequest mpr) throws Exception;
	//public Map<String, Object> indvdlInsert(Map<String, Object> params, List<MultipartFile> attachList) throws Exception;
	
	/**
	 * 개인 지원사업 update
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> indvdlUpdate(Map<String, Object> params) throws Exception;
	
	/**
	 * 단체 지원사업 select one
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> grpSelectOne(Map<String, Object> params) throws Exception;
	
	/**
	 * 단체 지원사업 insert
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> grpInsert(Map<String, Object> params) throws Exception;
	
	/**
	 * 단체 지원사업 update
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> grpUpdate(Map<String, Object> params) throws Exception;
	
	/**
	 * 간편접수 이용동의 페이지
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public String applyEasy(Map<String, Object> params) throws Exception;
	
	/**
	 * 간편접수 본인인증 페이지
	 * @param prarams
	 * @return
	 * @throws Exception
	 */
	public String applyEasySelfAuth(Map<String, Object> prarams) throws Exception;
	
	/**
	 * 간편접수 필수 자격 확인 페이지
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public String applyEasyPrvlg(Map<String, Object> params) throws Exception;
	
	/**
	 * 간편접수 마이데이터 요청 페이지
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public String applyEasyMydataReqPage(Map<String, Object> params) throws Exception;
	
}
