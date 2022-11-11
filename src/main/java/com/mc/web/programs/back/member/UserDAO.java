package com.mc.web.programs.back.member;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.mc.web.MCMap;
import com.mc.web.service.CmsAbstractDAO;

@Repository
public class UserDAO extends CmsAbstractDAO {
	public List<MCMap> list(Map params) {
		return selectList("User.list", params);
	}
	public MCMap pagination(Map params) {
		return selectOne("User.pagination", params);
	}
	public MCMap view(Map params) {
		return selectOne("User.view", params);
	}
	public int write(Map params) {
		return update("User.write", params);
	}
	public int modify(Map params) {
		return update("User.modify", params);
	}
	public int init_pw(Map params) {
		return update("User.init_pw", params);
	}
	public int del(Map params) {
		return update("User.del", params);
	}
    public MCMap getMemberIdCnt(Map<String, String> params){
    	return selectOne("User.getMemberIdCnt", params);
    }
    public int loginFailCntInit (String memberId) {
        return update("User.loginFailCntInit", memberId);
    }
    public int memberWakeup (String memberId) {
    	return update("User.memberWakeup", memberId);
    }
	public int dormancy_update(String dt) {
        return update("User.dormancy_update", dt);
	}
	public int leave(Map<String, String> params) {
        return update("User.leave", params);
	}
	public int updateOrder(Map<String, String> params) {
		return update("User.updateOrder", params);
	}
	public int updateGroupOrder(Map<String, String> params) {
		return update("UserGroup.updateGroupOrder", params);
	}
	public int updateGroup(Map<String, String> params) {
		return update("User.updateGroup", params);
	}
	public List<MCMap> memberHistoryList(Map<String, String> params) {
		return selectList("User.memberHistoryList", params);
	}
	public MCMap memberHistoryPagination(Map<String, String> params){
		return selectOne("User.memberHistoryPagination", params);
	}
}