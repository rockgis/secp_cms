package com.mc.web.programs.back.filemanager;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.mc.web.MCMap;
import com.mc.web.service.CmsAbstractDAO;

@Repository
public class FilemanagerDAO extends CmsAbstractDAO {

	public List<MCMap> source_list(Map params) {
		return selectList("Site.source_list", params);
	}
	public MCMap source_pagination(Map params) {
		return selectOne("Site.source_pagination", params);
	}
	public int insert_file_history(Map<String, String> params) {
		return update("Site.insert_source_history", params);
	}
	public MCMap previous_source(Map params) {
		return selectOne("Site.previous_source", params);
	}
}