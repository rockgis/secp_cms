package com.mc.web.login;

import java.util.Map;

import com.mc.web.MCMap;
import com.mc.web.service.CmsAbstractDAO;

public class McUserLoginDAO extends CmsAbstractDAO {

	public MCMap getMemberById(Map<String, String> params){
		return selectOne("User.getMemberById", params);
	}
	
	public MCMap getMemberByIdPw(Map<String, String> params){
		return selectOne("User.getMemberByIdPw", params);
	} 
	
	public MCMap getMemberByGroup(Map<String, String> params){
		return selectOne("User.getMemberByGroup", params);
	}	
	
	public int updateMemberLastLogin(Map<String, String> params){
		return update("User.updateMemberLastLogin", params);
	}
	
	   
    /**
     * 사용자 비밀번호 불일치 카운트 증가
     * @param memberId
     * @return
     */
    public int loginFailCntIncrease (Map<String, String> params) {
        return update("User.loginFailCntIncrease", params);
    }
  
    /**
     * 사용자 비밀번호 불일치 카운트 초기화
     * @param memberId
     * @return
     */
    public int loginFailCntInit (String memberId) {
        return update("User.loginFailCntInit", memberId);
    }
}
