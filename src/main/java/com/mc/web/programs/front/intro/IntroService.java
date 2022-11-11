package com.mc.web.programs.front.intro;

import java.util.Map;

/**
 *
 * @Description : 포털 소개 프로그램 인터페이스
 * @ClassName   : com.mc.web.programs.intro.IntroService.java
 * @Modification Information
 *
 * @author khkim
 * @since 2018. 3. 29.
 * @version 1.0 *  
 * Copyright (C)  All right reserved.
 */
public interface IntroService {

	public String index(Map<String, String> params) throws Exception;
	
	public String bizIntro(Map<String, String> params) throws Exception;
	
	public String siteGuide(Map<String, String> params) throws Exception;
}
