package com.mc.web.programs.back.ipcheck;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.mc.web.MCMap;
import com.mc.web.service.CmsAbstractDAO;

@Repository
public class IpCheckDAO extends CmsAbstractDAO {

	public List<MCMap> list(Map params) {
		return selectList("IpCheck.list", params);
	}
	public MCMap pagination(Map params) {
		return selectOne("IpCheck.pagination", params);
	}
	public MCMap view(Map params) {
		return selectOne("IpCheck.view", params);
	}
	public int write(Map params) {
		return update("IpCheck.write", params);
	}
	public int modify(Map params) {
		return update("IpCheck.modify", params);
	}
	public int del(Map params) {
		return update("IpCheck.del", params);
	}
	public List<String> ipcheck() {
		return selectList("IpCheck.ipcheck");
	}
}