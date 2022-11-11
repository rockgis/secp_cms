package com.mc.web.programs.back.holiday;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.mc.web.MCMap;
import com.mc.web.service.CmsAbstractDAO;

@Repository
public class HolidayCheckDAO extends CmsAbstractDAO {

	public List<MCMap> list(Map params) {
		return selectList("Holiday.list", params);
	}
	public MCMap pagination(Map params) {
		return selectOne("Holiday.pagination", params);
	}
	public MCMap view(Map params) {
		return selectOne("Holiday.view", params);
	}
	public int write(Map params) {
		return update("Holiday.write", params);
	}
	public int modify(Map params) {
		return update("Holiday.modify", params);
	}
	public int del(Map params) {
		return update("Holiday.del", params);
	}
	
}