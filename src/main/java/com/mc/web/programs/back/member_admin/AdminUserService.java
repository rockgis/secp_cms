package com.mc.web.programs.back.member_admin;

import java.util.Map;

import com.mc.web.MCMap;

public interface AdminUserService{
	
	public Map list(Map params) throws Exception;
	
	public Map view(Map params) throws Exception;
	
	public Map write(Map<String, String> params) throws Exception;
	
	public Map modify(Map<String, String> params) throws Exception;
	
	public Map init_pw(Map<String, String> params) throws Exception;
	public Map pw_check(Map<String, String> params) throws Exception;
	public Map modify_pw(Map<String, String> params) throws Exception;
	
	public Map del(Map params) throws Exception;
	public Map updateOrder(Map params) throws Exception;
	public Map updateGroup(Map params) throws Exception;
	public Map site_list(Map params) throws Exception;
	public Map staff(Map params) throws Exception;
	public Map permission_list(Map params) throws Exception;
	public Map updatePermission(Map params) throws Exception;
	public Map staff_list(Map params) throws Exception;
	public Map updateStaff(Map params) throws Exception;
	public Map memberPermitList(Map params) throws Exception;
	public Map memberHistory(Map params) throws Exception;
	public Map updateMemberPermission(Map params) throws Exception;
	public Map memberBlockInit(String memberId) throws Exception;
	public Map memberWakeup(String memberId) throws Exception;

	public Map id_check(Map<String, String> params) throws Exception;
	public Map modify_pw_adm(Map<String, String> params) throws Exception;
	public String dormancy_adm(Map<String, String> params) throws Exception;
	public Map dormancy_adm_init(Map<String, String> params) throws Exception;

	public void dormancy_update();
}