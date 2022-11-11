package com.mc.web.programs.back.biz002;

import com.mc.web.MCMap;

import java.util.List;
import java.util.Map;

/**
 *
 * @Description : 소상공인사업정리(재기장려 지원) 프로그램 인터페이스
 * @ClassName   : com.mc.web.programs.back.biz002.AdminBiz002Service.java
 * @Modification Information
 *
 * @author MSLK_JJS
 * @since 2018. 3. 29.
 * @version 1.0 *  
 * Copyright (C)  All right reserved.
 */
public interface AdminBiz002Service{
	public Map<String,Object> selectGridHeader() throws Exception;

	public List<MCMap> selectGridData(Map<String, String> params) throws Exception;


	public Map selectBizInfo(Map params) throws Exception;
}
