package com.mc.web.programs.back.system;

import java.util.Map;


public interface AdminSystemService{
	
	public String dashboard(Map params) throws Exception;
	public String system_info(Map params) throws Exception;
}