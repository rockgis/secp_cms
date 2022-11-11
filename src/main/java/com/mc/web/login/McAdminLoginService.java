package com.mc.web.login;

import java.util.Map;

import javax.servlet.http.HttpServletResponse;

public interface McAdminLoginService{
	 
	public Map login(Map<String, String> params) throws Exception;
	public String logout(Map params, HttpServletResponse response) throws Exception;	
	public String login_fail(Map<String, String> params);	
	public Map check_id(Map<String, String> params) throws Exception;	
	public String login_duplicate(Map<String, String> params);	
	public Map login_userlist(Map<String, String> params);	
	public Map force_logout(Map<String, String> params);	
	public Map session_keep(Map<String, String> params);	
}