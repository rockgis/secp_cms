package com.mc.web.programs.front.member;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.mc.web.MCMap;
import com.mc.web.service.CmsAbstractDAO;

@Repository
public class UserJoinDAO extends CmsAbstractDAO {
	
	public int joinProc(Map<String, String> params){
		return update("User.write", params);
	}
	
	public int modifyProc(Map<String, String> params){
		return update("User.modify", params);
	}
	public MCMap view(Map params) {
		return selectOne("User.view", params);
	}
    public int niceDIChk(Map<String, String> params){
    	return selectOne("User.niceDIChk", params);
    }
	public MCMap getDiMember(Map params) {
		return selectOne("User.getDiMember", params);
	}
	public MCMap getMemberByNameEmail(Map params) {
		return selectOne("User.getMemberByNameEmail", params);
	}
	public MCMap getMemberByIdEmail(Map params) {
		return selectOne("User.getMemberByIdEmail", params);
	}
	
	
}