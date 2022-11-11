package com.mc.web.programs.back.permit;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.mc.web.MCMap;
import com.mc.web.service.CmsAbstractDAO;

@Repository
public class PermitDAO extends CmsAbstractDAO {

	public List<MCMap> menu_list(Map params) {
		return selectList("Permit.menu_list", params);
	}
	public List<MCMap> list(Map params) {
		return selectList("Permit.list", params);
	}
	public MCMap pagination(Map params) {
		return selectOne("Permit.pagination", params);
	}
	public MCMap view(Map params) {
		return selectOne("Permit.view", params);
	}
	public int write(Map params) {
		return update("Permit.write", params);
	}
	public int insert_permit(Map params) {
		return update("Permit.insert_permit", params);
	}
	public int modify(Map params) {
		return update("Permit.modify", params);
	}
	public int permit_del_all(Map params) {
		return update("Permit.permit_del_all", params);
	}
	public int permit_del_group_member_all(Map params) {
		return update("Permit.permit_del_group_member_all", params);
	}
	public int permit_del_manage_member_all(Map params) {
		return update("Permit.permit_del_manage_member_all", params);
	}
	public int del(Map params) {
		return update("Permit.del", params);
	}
	public int hasMemberPermit(Map params) {
		return selectOne("Permit.hasMemberPermit", params);
	}
	public List memberPermitList1(Map params) {
		return selectList("Permit.memberPermitList1", params);
	}
	public List memberPermitList2(Map params) {
		return selectList("Permit.memberPermitList2", params);
	}
	public int permit_del_member_all(Map params) {
		return update("Permit.permit_del_member_all", params);
	}
	public int insert_permit_member(Map params) {
		return update("Permit.insert_permit_member", params);
	}
	
}