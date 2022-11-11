package com.mc.web.programs.back.site.layout_setting;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.mc.web.service.CmsAbstractDAO;

@Repository
public class LayoutSettingDAO extends CmsAbstractDAO {

	public List layout_list(Map params) {
		return selectList("Site.layout_list", params);
	}
	public List layout_dtl_list(Map params) {
		return selectList("Site.layout_dtl_list", params);
	}

	public int layout_insert(Map params) {
		return update("Site.layout_insert", params);
	}
	public int layout_dtl_insert(Map params) {
		return update("Site.layout_dtl_insert", params);
	}
	public int layout_delete(Map params) {
		return update("Site.layout_delete", params);
	}
	public int layout_dtl_delete(Map params) {
		return update("Site.layout_dtl_delete", params);
	}
}