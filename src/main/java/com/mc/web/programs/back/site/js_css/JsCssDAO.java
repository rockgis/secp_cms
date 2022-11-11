package com.mc.web.programs.back.site.js_css;

import java.util.List;
import java.util.Map;

import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Repository;

import com.mc.web.MCMap;
import com.mc.web.service.CmsAbstractDAO;

@Repository
public class JsCssDAO extends CmsAbstractDAO {

	public List<MCMap> js_css_main(Map<String, String> params) {
		return selectList("Site.js_css_main", params);
	}
	public List<MCMap> js_css_list(Map params) {
		return selectList("Site.js_css_list", params);
	}
	public MCMap js_css_pagination(Map params) {
		return selectOne("Site.js_css_pagination", params);
	}
	public MCMap js_css_get_item(Map<String, String> params) {
		return selectOne("Site.js_css_get_item", params);
	}
	@CacheEvict(value="jsCssCache", keyGenerator="jsCssKeyGenerator")
	public int js_css_write(Map<String, String> params) {
		return update("Site.js_css_write", params);
	}
	@Cacheable(value="jsCssCache", keyGenerator="jsCssKeyGenerator")
	public MCMap js_css_view(Map<String, String> params) {
		return selectOne("Site.js_css_view", params);
	}

}