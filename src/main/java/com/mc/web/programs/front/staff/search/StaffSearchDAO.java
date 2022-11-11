package com.mc.web.programs.front.staff.search;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.mc.web.MCMap;
import com.mc.web.service.CmsAbstractDAO;

@Repository
public class StaffSearchDAO extends CmsAbstractDAO {

	public List<MCMap> group_list(Map params) {
		return selectList("Staff.group_list", params);
	}
	
	public List<MCMap> list(Map params) {
		return selectList("Staff.list", params);
	}
}
