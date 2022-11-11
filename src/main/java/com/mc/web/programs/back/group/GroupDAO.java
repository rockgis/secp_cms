package com.mc.web.programs.back.group;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.mc.web.MCMap;
import com.mc.web.service.CmsAbstractDAO;

@Repository
public class GroupDAO extends CmsAbstractDAO {
	public List<MCMap> list(Map params) {
		return selectList("Group.list", params);
	}
	public MCMap view(Map params) {
		return selectOne("Group.view", params);
	}
	public int write(Map params) {
		return update("Group.write", params);
	}
	public int modify(Map params) {
		return update("Group.modify", params);
	}
	public int del(Map params) {
		return update("Group.del", params);
	}
	public int del_member(Map params) {
		return update("Group.del_member", params);
	}
	public int move_member(Map params) {
		return update("Group.move_member", params);
	}
	public List<MCMap> staffList(Map params) {
		return selectList("Group.staffList", params);
	}
	public int group_staff_delete(Map params) {
		return update("Group.group_staff_delete", params);
	}
}