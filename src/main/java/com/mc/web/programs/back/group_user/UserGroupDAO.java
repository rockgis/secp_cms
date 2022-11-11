package com.mc.web.programs.back.group_user;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.mc.web.MCMap;
import com.mc.web.service.CmsAbstractDAO;

@Repository
public class UserGroupDAO extends CmsAbstractDAO {
	public List<MCMap> list(Map params) {
		return selectList("UserGroup.list", params);
	}
	public MCMap view(Map params) {
		return selectOne("UserGroup.view", params);
	}
	public int write(Map params) {
		return update("UserGroup.write", params);
	}
	public int modify(Map params) {
		return update("UserGroup.modify", params);
	}
	public int del(Map params) {
		return update("UserGroup.del", params);
	}
	public int del_member(Map params) {
		return update("UserGroup.del_member", params);
	}
	public int move_member(Map params) {
		return update("UserGroup.move_member", params);
	}
	public List<MCMap> menuGrantList(Map params) {
		return selectList("UserGroup.menuGrantList", params);
	}
	public int deleteMenuGrant(Map params) {
		return update("UserGroup.deleteMenuGrant", params);
	}
	public int insertMenuGrant(Map params) {
		return update("UserGroup.insertMenuGrant", params);
	}
}