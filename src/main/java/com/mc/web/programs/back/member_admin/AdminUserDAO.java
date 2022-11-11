package com.mc.web.programs.back.member_admin;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.mc.web.MCMap;
import com.mc.web.service.CmsAbstractDAO;

@Repository
public class AdminUserDAO extends CmsAbstractDAO {
	public List<MCMap> list(Map params) {
		return selectList("AdminUser.list", params);
	}
	public List<String> allow_menu_list(String group_seq) {
		return selectList("AdminUser.allow_menu_list", group_seq);
	}
	public MCMap pagination(Map params) {
		return selectOne("AdminUser.pagination", params);
	}
	public MCMap view(Map params) {
		return selectOne("AdminUser.view", params);
	}
	public int write(Map params) {
		return update("AdminUser.write", params);
	}
	public int modify(Map params) {
		return update("AdminUser.modify", params);
	}
	public int init_pw(Map params) {
		return update("AdminUser.init_pw", params);
	}
	public int del(Map params) {
		return update("AdminUser.del", params);
	}
	public int updateOrder(Map<String, String> params) {
		return update("AdminUser.updateOrder", params);
	}
	public int updateGroupOrder(Map<String, String> params) {
		return update("Group.updateGroupOrder", params);
	}
	public int updateGroup(Map<String, String> params) {
		return update("AdminUser.updateGroup", params);
	}
    public MCMap getMemberIdCnt(Map<String, String> params){
    	return selectOne("AdminUser.getMemberIdCnt", params);
    }
	public List<MCMap> memberHistoryList(Map<String, String> params) {
		return selectList("AdminUser.memberHistoryList", params);
	}
	public MCMap memberHistoryPagination(Map<String, String> params){
		return selectOne("AdminUser.memberHistoryPagination", params);
	}
	
	public MCMap getMemberById(Map<String, String> params){
		return selectOne("AdminUser.getMemberById", params); 
	}
	public int dormancy_adm_init(Map<String, String> params) {
		return update("AdminUser.dormancy_adm_init", params);
	}
	public int dormancy_update(String dt) {
        return update("AdminUser.dormancy_update", dt);
	}
}