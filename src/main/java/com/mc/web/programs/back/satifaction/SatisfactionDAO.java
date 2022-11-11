package com.mc.web.programs.back.satifaction;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.mc.web.MCMap;
import com.mc.web.service.CmsAbstractDAO;

@Repository
public class SatisfactionDAO extends CmsAbstractDAO {
	
	public MCMap page_satisfaction(Map params) {
		return selectOne("Satisfaction.page_satisfaction", params);
	}

	public int isOverlap(Map params) {
		return selectOne("Satisfaction.isOverlap", params);
	}
	
	public int estimate(Map params) {
		return update("Satisfaction.estimate", params);
	}
	
	public List<MCMap> stat_list(Map params) {
		return selectList("Satisfaction.stats", params);
	}
	public MCMap stat_pagination(Map params) {
		return selectOne("Satisfaction.stat_pagination", params);
	}
	
	public List<MCMap> etc_list(Map params) {
		return selectList("Satisfaction.etc_list", params);
	}
	public MCMap etc_pagination(Map params) {
		return selectOne("Satisfaction.etc_pagination", params);
	}
	public List<MCMap> detail_list(Map params) {
		return selectList("Satisfaction.detail_list", params);
	}
	public MCMap detail_pagination(Map params) {
		return selectOne("Satisfaction.detail_pagination", params);
	}
	
	public List<MCMap> excel_list(Map<String, String> params){
		return selectList("Satisfaction.execel_list", params);
	}

}