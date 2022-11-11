package com.mc.web.programs.front.member;

import java.util.Map;

public interface UserJoinService {
	public String join_step2(Map params) throws Exception;
	public String join(Map params) throws Exception;
	public String joinProc(Map<String, String> params) throws Exception;
	public String modifyStep1(Map params) throws Exception;
	public String modifyForm(Map params) throws Exception;
	public String modifyProc(Map<String, String> params) throws Exception;
	public String leavePage(Map<String, String> params) throws Exception;
	public String leaveProc(Map<String, String> params) throws Exception;
	public String change_pw(Map<String, String> params) throws Exception;
	public Map modify_pw(Map<String, String> params) throws Exception;
	public Map id_check(Map<String, String> params) throws Exception;
	public Map niceDIChk(Map<String, String> params) throws Exception;
	public Map getDiMember(Map params) throws Exception;
	public String id_search(Map params) throws Exception;
	public String id_find(Map params) throws Exception;
	public String pw_search(Map params) throws Exception;
	public String pw_find(Map params) throws Exception;
	
	public String login(Map params) throws Exception;
}