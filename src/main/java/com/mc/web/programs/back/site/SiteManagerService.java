package com.mc.web.programs.back.site;

import java.util.Map;

public interface SiteManagerService{
	
	public String dashboard(Map params) throws Exception;
	
	public Map list(Map<String, String> params) throws Exception;
	
	public Map view(Map<String, String> params) throws Exception;

	public Map write(Map<String, String> params) throws Exception;

	public Map modify(Map<String, String> params) throws Exception;

	public Map del(Map<String, String> params) throws Exception;
}
