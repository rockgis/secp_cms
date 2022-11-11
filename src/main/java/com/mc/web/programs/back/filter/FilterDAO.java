package com.mc.web.programs.back.filter;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.mc.web.MCMap;
import com.mc.web.service.CmsAbstractDAO;

@Repository
public class FilterDAO extends CmsAbstractDAO {

	public List<MCMap> list(Map params) {
		return selectList("Filter.list", params);
	}
	public MCMap pagination(Map params) {
		return selectOne("Filter.pagination", params);
	}
	public MCMap get_default_filter(Map params) {
		return selectOne("Filter.get_default_filter", params);
	}
	public MCMap get_menu_filter(Map params) {
		return selectOne("Filter.get_menu_filter", params);
	}
	
	public int set_default_filter(Map params) {
		return update("Filter.set_default_filter", params);
	}
	public int set_default_filter_all(Map params) {
		return update("Filter.set_default_filter_all", params);
	}
	public int set_menu_filter(Map params) {
		return update("Filter.set_menu_filter", params);
	}
	public int del_filter(Map params) {
		return update("Filter.del_filter", params);
	}
	
	public int modify(Map params) {
		return update("Filter.modify", params);
	}
	
	public int report_record(Map params) {
		return update("Filter.report_record", params);
	}
	public int report_delete(Map params) {
		return update("Filter.report_delete", params);
	}

	public List<MCMap> report_list_all(Map params) {
		return selectList("Filter.report_list_all", params);
	}
	public List<MCMap> report_list(Map params) {
		return selectList("Filter.report_list", params);
	}
	public MCMap report_pagination(Map params) {
		return selectOne("Filter.report_pagination", params);
	}
	public List<MCMap> detail_list_all(Map params) {
		return selectList("Filter.detail_list_all", params);
	}
	public List<MCMap> detail_list(Map params) {
		return selectList("Filter.detail_list", params);
	}
	public MCMap detail_pagination(Map params) {
		return selectOne("Filter.detail_pagination", params);
	}
	
	
	public MCMap dashboardSetStatus(Map params) {
		return selectOne("Filter.dashboardSetStatus", params);
	}
	public MCMap dashboardChart1(Map params) {
		return selectOne("Filter.dashboardChart1", params);
	}
	public List<MCMap> dashboardChart2(Map params) {
		return selectList("Filter.dashboardChart2", params);
	}
	public List<MCMap> daylistChart(Map params) {
		return selectList("Filter.daylistChart", params);
	}

	public List<MCMap> daylist(Map params) {
		return selectList("Filter.daylist", params);
	}
	public MCMap daylist_pagination(Map params) {
		return selectOne("Filter.daylist_pagination", params);
	}
}