package com.mc.web.login;

import java.util.Map;

import com.mc.web.MCMap;
import com.mc.web.service.CmsAbstractDAO;

public class McAdminLoginDAO extends CmsAbstractDAO {

	public MCMap getMemberById(Map<String, String> params){
		return selectOne("AdminUser.getMemberById", params);
	}
	
	public MCMap getMemberByIdPw(Map<String, String> params){
		return selectOne("AdminUser.getMemberByIdPw", params); 
	}
	
	public int updateMemberLastLogin(Map<String, String> params){
		return update("AdminUser.updateMemberLastLogin", params);
	}
	
	   
    /**
     * 사용자 비밀번호 불일치 카운트 증가
     * @param memberId
     * @return
     */
    public int loginFailCntIncrease (Map<String, String> params) {
        return update("AdminUser.loginFailCntIncrease", params);
    }
  
    /**
     * 사용자 비밀번호 불일치 카운트 초기화
     * @param memberId
     * @return
     */
    public int loginFailCntInit (String memberId) {
        return update("AdminUser.loginFailCntInit", memberId);
    }
    
    public int memberWakeup (String memberId) {
    	return update("AdminUser.memberWakeup", memberId);
    }
}
