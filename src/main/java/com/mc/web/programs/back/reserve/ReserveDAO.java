package com.mc.web.programs.back.reserve;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.mc.web.MCMap;
import com.mc.web.service.CmsAbstractDAO;

@Repository
public class ReserveDAO extends CmsAbstractDAO {

	public List<MCMap> list(Map params) {
		return selectList("Reserve.list", params);
	}
	public MCMap pagination(Map params) {
		return selectOne("Reserve.pagination", params);
	}
	public MCMap view(Map params) {
		return selectOne("Reserve.view", params);
	}
	public int reserve(Map params) {
		return update("Reserve.reserve", params);
	}
	public List reserve_list() {
		return selectList("Reserve.reserve_list");
	}
	public int reserve_ok(Map params) {
		return update("Reserve.reserve_ok", params);
	}
	public int reserve_fail(Map params) {
		return update("Reserve.reserve_fail", params);
	}
	public int del(Map params) {
		return update("Reserve.del", params);
	}
}