package com.mc.web.programs.back.phistory;

import java.util.Map;

import com.mc.web.MCMap;

/**
 *
 * @Description : 페이지이력 프로그램 인터페이스
 * @ClassName   : com.mc.web.programs.back.phistory.AdminPhistoryService.java
 * @Modification Information
 *
 * @author sdlck
 * @since 2018. 3. 29.
 * @version 1.0 *  
 * Copyright (C)  All right reserved.
 */
public interface AdminPhistoryService{ 

	public Map list(Map params) throws Exception;
	
	public MCMap view(Map params) throws Exception;

	public Map write(Map params) throws Exception;

	public Map modify(Map params) throws Exception;

	public Map del(Map params) throws Exception;
}
