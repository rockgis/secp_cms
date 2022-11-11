package com.mc.web.programs.front.biz006;

import java.util.Map;

import org.springframework.web.multipart.MultipartHttpServletRequest;

/**
 *
 * @Description : 청년사관학교 프로그램 인터페이스
 * @ClassName   : com.mc.web.programs.biz006.Biz006Service.java
 * @Modification Information
 *
 * @author MSLK_JJS
 * @since 2018. 3. 29.
 * @version 1.0 *  
 * Copyright (C)  All right reserved.
 */
public interface Biz006Service {

	public String intro(Map<String, String> params) throws Exception;
	
	/**
	 * 개인 지원사업 insert
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> insertTest(Map<String, Object> params, MultipartHttpServletRequest mpr) throws Exception;
	//public Map<String, Object> indvdlInsert(Map<String, Object> params, List<MultipartFile> attachList) throws Exception;
	
	
}
