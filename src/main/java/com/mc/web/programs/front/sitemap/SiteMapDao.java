package com.mc.web.programs.front.sitemap;

import java.util.List;

import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Repository;

import com.mc.web.MCMap;
import com.mc.web.service.CmsAbstractDAO;

@Repository
public class SiteMapDao extends CmsAbstractDAO {

	@Cacheable(value="menuCache")
	public List<MCMap> list(String site_id) {
		return selectList("Menu.list", site_id);
	}
}
