package com.mc.web.programs.back.program;

import java.util.Map;

import com.mc.web.MCMap;

public interface ProgramService{

	public Map list(Map params) throws Exception;
	public Map menu_list(Map params) throws Exception;
	
	public MCMap view(Map params) throws Exception;

	public Map write(Map params) throws Exception;

	public Map modify(Map params) throws Exception;

	public Map del(Map params) throws Exception;

}
