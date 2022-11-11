package com.mc.web.programs.back.biz001;

import java.util.List;
import java.util.Map;

import com.mc.web.MCMap;
import org.springframework.web.multipart.MultipartHttpServletRequest;

/**
 *
 * @Description : bizmanage 프로그램 인터페이스
 * @ClassName   : com.mc.web.programs.back.bizmanage.AdminBizmanageService.java
 * @Modification Information
 *
 * @author MSLK_JJS
 * @since 2018. 3. 29.
 * @version 1.0 *  
 * Copyright (C)  All right reserved.
 */
public interface AdminBiz001Service{
//	public Map list(Map params) throws Exception;
	
	public Map<String,Object> selectGridHeader() throws Exception;
	
	public List<MCMap> selectGridData(Map<String, String> params) throws Exception;
	
	
	public Map selectBizInfo(Map params) throws Exception;


	/**
	 * 개인 지원사업 insert
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> indvdlInsert(Map<String, Object> params) throws Exception;

	/**
	 * 개인 지원사업 update
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> indvdlUpdate(Map<String, Object> params) throws Exception;
	
}
