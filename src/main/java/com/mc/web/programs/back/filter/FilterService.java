package com.mc.web.programs.back.filter;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface FilterService{
	
	public Map dashboardData(Map params) throws Exception;
	public Map daylistData(Map params) throws Exception;
	public Map menulistData(Map params) throws Exception;
	
	public Map setting(Map params) throws Exception;
	public Map set_default_filter(Map params) throws Exception;
	public Map set_menu_filter(Map params) throws Exception;
	public Map set_each_filter(Map params) throws Exception;
	public Map get_menu_filter(Map params) throws Exception;
	public Map modify(Map params) throws Exception;
	public Map check(HttpServletRequest request, Map params) throws Exception;
	public Map report_record(Map params) throws Exception;
	public Map report_delete(String cms_menu_seq, String sub_seq) throws Exception;
	public void report_update(Map params) throws Exception;
	public Map reportList(Map params) throws Exception;
	public Map detailList(Map params) throws Exception;
	public String report_excel(HttpServletResponse res, Map<String, String> params) throws Exception;
	public String detail_excel(HttpServletResponse res, Map<String, String> params) throws Exception;
}
