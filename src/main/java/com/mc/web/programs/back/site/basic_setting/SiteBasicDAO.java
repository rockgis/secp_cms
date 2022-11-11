package com.mc.web.programs.back.site.basic_setting;

import java.util.List;
import java.util.Map;

import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Repository;

import com.mc.web.MCMap;
import com.mc.web.service.CmsAbstractDAO;

@Repository
public class SiteBasicDAO extends CmsAbstractDAO {

	@Cacheable(value="basicCache")
	public MCMap basic_view(String site_id) {
		return selectOne("Site.basic_view", site_id);
	}

	@CacheEvict(value="basicCache", allEntries=true)
	public int basic_modify(Map params) {
		return update("Site.basic_modify", params);
	}
	
	public List<MCMap> site_list(Map params) {
		return selectList("Menu.site_list", params);
	}
}