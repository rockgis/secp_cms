package com.mc.web.programs.front.mybiz;

import java.util.List;
import java.util.Map;

/**
 *
 * @Description : 나의 신청 현황 프로그램 인터페이스
 * @ClassName   : com.mc.web.programs.mybiz.MybizService.java
 * @Modification Information
 *
 * @author khkim
 * @since 2018. 3. 29.
 * @version 1.0 *  
 * Copyright (C)  All right reserved.
 */
public interface MybizService {

	public String index(Map<String, String> params) throws Exception;
	
	/**
	 * 지원사업 리스트 조회
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> getBizList(Map<String, Object> params) throws Exception;
	
	public String bizGiveUpPopup(Map<String, String> params) throws Exception;
	
	public String bizChngPopup(Map<String, String> params) throws Exception;
	
	public String cmpltRptPopup(Map<String, String> params) throws Exception;
	
	public String pymtFormPopup(Map<String, String> params) throws Exception;
}
