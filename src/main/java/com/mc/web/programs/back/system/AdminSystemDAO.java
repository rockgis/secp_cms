package com.mc.web.programs.back.system;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.mc.web.MCMap;
import com.mc.web.service.CmsAbstractDAO;

@Repository
public class AdminSystemDAO extends CmsAbstractDAO {
//	public MCMap member_status(Map params) {
//		return selectOne("Dashboard.member_status", params);
//	}
//	public MCMap member_join_status(Map params) {
//		return selectOne("Dashboard.member_join_status", params);
//	}
//	public int visit_cnt(Map params) {
//		return selectOne("Dashboard.visit_cnt", params);
//	}
//	public List<MCMap> most_vistor(Map params) {
//		return selectList("Dashboard.most_vistor", params);
//	}
	public int admin_connection_count(Map params) {
		return selectOne("Dashboard.admin_connection_count", params);
	}
	public MCMap users_status(Map params) {
		return selectOne("Dashboard.users_status", params);
	}
	public MCMap security_status(Map params) {
		return selectOne("Dashboard.security_status", params);
	}
	public List<MCMap> board_count(Map params) {
		return selectList("Dashboard.board_count", params);
	}
	public MCMap system_status(Map params) {
		return selectOne("Dashboard.system_status", params);
	}
	public int filter_row(Map params) {
		return selectOne("Dashboard.filter_row", params);
	}	
	public int filter_count(Map params) {
		return selectOne("Dashboard.filter_count", params);
	}
}