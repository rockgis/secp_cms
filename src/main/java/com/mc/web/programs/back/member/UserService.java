package com.mc.web.programs.back.member;

import java.util.Map;

import com.mc.web.MCMap;

public interface UserService{
	
	public Map list(Map params) throws Exception;
	
	public MCMap view(Map params) throws Exception;
	
	public Map write(Map<String, String> params) throws Exception;
	
	public Map modify(Map<String, String> params) throws Exception;
	
	public Map init_pw(Map<String, String> params) throws Exception;
	public Map pw_check(Map<String, String> params) throws Exception;
	public Map modify_pw(Map<String, String> params) throws Exception;
	
	public Map del(Map params) throws Exception;
	public Map leave(Map params) throws Exception;
	public Map updateOrder(Map params) throws Exception;
	public Map updateGroup(Map params) throws Exception;
	public void memberBlockInit(String memberId) throws Exception;
	public void memberWakeup(String memberId) throws Exception;

	public Map id_check(Map<String, String> params) throws Exception;

	public void dormancy_update();
	public Map memberHistory(Map params) throws Exception;
}