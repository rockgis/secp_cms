package com.mc.web.programs.front.search;

import java.util.List;
import java.util.Map;

import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Repository;

import com.mc.web.MCMap;
import com.mc.web.service.CmsAbstractDAO;

@Repository
public class SearchDAO extends CmsAbstractDAO {

	public List<MCMap> getList(Map<String, String> params) {
		return selectList("Search.list", params);
	}
	
	public MCMap getPageInfo(Map<String, String> params) {
		return selectOne("Search.page_info", params);
	}
	
	public List<MCMap> getDitList(Map<String, String> params) {
		return selectList("Search.dit_list", params);
	}
	
	public MCMap getDitPageInfo(Map<String, String> params) {
		return selectOne("Search.dit_page_info", params);
	}
	
	public List<MCMap> getMemList(Map<String, String> params) {
		return selectList("Search.mem_list", params);
	}
	
	public MCMap getMemPageInfo(Map<String, String> params) {
		return selectOne("Search.mem_page_info", params);
	}

	public List rank_month(Map<String, String> params) {
		return selectList("Search.rank_month", params);
	}
	public List rank_week(Map<String, String> params) {
		return selectList("Search.rank_week", params);
	}
	public List rank_day(Map<String, String> params) {
		return selectList("Search.rank_day", params);
	}
	public MCMap checkSearchText(Map<String, String> params) {
		return selectOne("Search.search_text_select", params);
	}
	
	public int searchTextInsert(Map<String, String> params) {
		return insert("Search.search_text_insert", params);
	}
	
	public int searchTextUpdate(Map<String, String> params) {
		return update("Search.search_text_update", params);
	}
	
	public List<MCMap> searchKeywordApply(Map<String, Object> params) {
		return selectList("Search.searchKeywordApply", params);
	}
	
	public List<MCMap> searchKeywordBoard(Map<String, Object> params) {
		return selectList("Search.searchKeywordBoard", params);
	}
	
	public List<MCMap> searchKeywordFile(Map<String, Object> params) {
		return selectList("Search.searchKeywordFile", params);
	}
}