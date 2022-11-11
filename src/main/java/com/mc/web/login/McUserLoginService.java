package com.mc.web.login;

import java.util.Map;

import javax.servlet.http.HttpServletResponse;

public interface McUserLoginService{
	
	public String loginSuccess(Map<String, String> params) throws Exception;
	public Map login(Map<String, String> params) throws Exception;
	public String logout(Map params, HttpServletResponse response) throws Exception;	
	public String login_fail(Map<String, String> params);	
	public Map check_id(Map<String, String> params) throws Exception;	
	public String login_duplicate(Map<String, String> params);	
}