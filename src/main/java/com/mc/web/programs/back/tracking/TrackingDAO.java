package com.mc.web.programs.back.tracking;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.mc.web.service.CmsAbstractDAO;

@Repository
public class TrackingDAO extends CmsAbstractDAO{

	public List loginList(Map<String, String> params) {
		return selectList("tracking.loginList", params);
	}
	public Map loginPagination(Map<String, String> params) {
		return selectOne("tracking.loginPagination", params);
	}
	
	public List viewList(Map<String, String> params) {
		return selectList("tracking.viewList", params);
	}
	
	public Map viewPagination(Map<String, String> params) {
		return selectOne("tracking.viewPagination", params);
	}
	
	public List viewAuth(Map<String, String> params) {
		return selectList("tracking.viewAuth", params);
	}
	
	
	
	public Map getLogin(Map<String, String> params) {
		return selectOne("tracking.getLogin",params);
	}
	
	public int setLogin(Map<String, String> params){
		return insert("tracking.setLogin",params);
	}
	
	public int setLocation(Map<String, String> params) {
		return insert("tracking.setLocation", params);
	}	
	
	public void removeSchedule() {
		delete("tracking.removeSchedule1", null);
		delete("tracking.removeSchedule2", null);
	}	
}
