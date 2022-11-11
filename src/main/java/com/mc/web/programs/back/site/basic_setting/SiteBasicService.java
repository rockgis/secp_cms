package com.mc.web.programs.back.site.basic_setting;

import java.util.Map;

public interface SiteBasicService{
	
	public Map basic_view(Map params) throws Exception;
	public Map basic_modify(Map params) throws Exception;
	public Map clear_chche(Map params) throws Exception;
}
