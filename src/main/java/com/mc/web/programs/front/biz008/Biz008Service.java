package com.mc.web.programs.front.biz008;

import java.util.Map;

/**
 *
 * @Description : 명품점포 프로그램 인터페이스
 * @ClassName   : com.mc.web.programs.biz008.Biz008Service.java
 * @Modification Information
 *
 * @author MSLK_JJS
 * @since 2018. 3. 29.
 * @version 1.0 *  
 * Copyright (C)  All right reserved.
 */
public interface Biz008Service {

	public String intro(Map<String, String> params) throws Exception;
	
	/* 명품점포 인서트 테스트 */
	public String myTest(Map<String, Object> params) throws Exception;
	
}
