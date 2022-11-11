package com.mc.web.programs.back.site;

import java.util.List;
import java.util.Map;

import org.springframework.cache.annotation.CacheEvict;
import org.springframework.stereotype.Repository;

import com.mc.web.MCMap;
import com.mc.web.service.CmsAbstractDAO;

@Repository
public class SiteManagerDAO extends CmsAbstractDAO {
	
	public List<MCMap> list(Map params) {
		return selectList("Site.list", params);
	}
	public MCMap pagination(Map params) {
		return selectOne("Site.pagination", params);
	}
	public MCMap view(Map params) {
		return selectOne("Site.view", params);
	}
	public int write(Map params) {
		return update("Site.write", params);
	}
	@CacheEvict(value="basicCache", allEntries=true)
	public int modify(Map params) {
		return update("Site.modify", params);
	}
	public int del(Map params) {
		return update("Site.del", params);
	}
	public MCMap security_status(Map params) {
		return selectOne("Dashboard.security_status", params);
	}
	public MCMap reserve_count(Map params) {
		return selectOne("Dashboard.reserve_count", params);
	}
	public List<MCMap> banner_status(Map params) {
		return selectList("Dashboard.banner_status", params);
	}
	public List<MCMap> banner_end_schedule(Map params) {
		return selectList("Dashboard.banner_end_schedule", params);
	}
}