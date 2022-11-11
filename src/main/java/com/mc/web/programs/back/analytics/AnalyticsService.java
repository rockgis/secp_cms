package com.mc.web.programs.back.analytics;

import java.util.Map;

import javax.servlet.http.HttpServletResponse;

public interface AnalyticsService{
	public String add_weblog(Map params) throws Exception;
	public Map intro(Map params) throws Exception;
	public Map day(Map params) throws Exception;
	public Map time(Map params) throws Exception;
	public Map browser(Map params) throws Exception;
	public Map os(Map params) throws Exception;
	public Map page(Map params) throws Exception;
	public String execeldown(HttpServletResponse res, Map<String, String> params) throws Exception;
}
