package com.mc.web.programs.back.userreport;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.mc.web.MCMap;
import com.mc.web.service.CmsAbstractDAO;

@Repository
public class UserreportDAO extends CmsAbstractDAO {

	public int isOverlap(Map params) {
		return selectOne("Userreport.isOverlap", params);
	}
	
	public int write(Map params) {
		return update("Userreport.write", params);
	}
	
	public List<MCMap> viewlist(Map params) {
		return selectList("Userreport.viewlist", params);
	}
}
