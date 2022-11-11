package com.mc.web.programs.back.program;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.mc.web.MCMap;
import com.mc.web.service.CmsAbstractDAO;

@Repository
public class ProgramDAO extends CmsAbstractDAO {

	public List<MCMap> list(Map params) {
		return selectList("Program.list", params);
	}
	public List<MCMap> menu_list(Map params) {
		return selectList("Program.menu_list", params);
	}
	public MCMap pagination(Map params) {
		return selectOne("Program.pagination", params);
	}
	public MCMap view(Map params) {
		return selectOne("Program.view", params);
	}
	public int write(Map params) {
		return update("Program.write", params);
	}
	public int modify(Map params) {
		return update("Program.modify", params);
	}
	public int del(Map params) {
		return update("Program.del", params);
	}
}