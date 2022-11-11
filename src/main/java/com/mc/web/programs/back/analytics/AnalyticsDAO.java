package com.mc.web.programs.back.analytics;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.mc.web.MCMap;
import com.mc.web.service.CmsAbstractDAO;

@Repository
public class AnalyticsDAO extends CmsAbstractDAO {

	public int has_ymd(Map params) {
		return selectOne("Analytics.has_ymd", params);
	}
	
	public int add_weblog(Map params) {
		return update("Analytics.add_weblog", params);
	}
	
	public int plus_weblog(Map params) {
		return update("Analytics.plus_weblog", params);
	}
	
	public MCMap time(Map params) {
		return selectOne("Analytics.time", params);
	}
	
	public List<MCMap> times(Map params) {
		return selectList("Analytics.time", params);
	}
	
	public MCMap day(Map params) {
		return selectOne("Analytics.day", params);
	}
	
	public List<MCMap> days(Map params) {
		return selectList("Analytics.days", params);
	}
	
	public List<MCMap> browser(Map params) {
		return selectList("Analytics.browser", params);
	}
	
	public List<MCMap> os(Map params) {
		return selectList("Analytics.os", params);
	}

	public List<MCMap> list(Map params) {
		return selectList("Analytics.list", params);
	}
	public MCMap pagination(Map params) {
		return selectOne("Analytics.pagination", params);
	}
	public int total_visit_cnt(Map params) {
		return selectOne("Analytics.total_visit_cnt", params);
	}

}