package com.mc.web.programs.back.code;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.mc.web.MCMap;
import com.mc.web.service.CmsAbstractDAO;

@Repository
public class CodeDAO extends CmsAbstractDAO {
	public List<MCMap> list(Map params) {
		return selectList("Code.list", params);
	}
	public MCMap pagination(Map params) {
		return selectOne("Code.pagination", params);
	}
	public int group_write(Map params) {
		return update("Code.group_write", params);
	}
	public int group_modify(Map params) {
		return update("Code.group_modify", params);
	}
	public int group_del(Map params) {
		return update("Code.group_del", params);
	}
	public int code_write(Map params) {
		return update("Code.code_write", params);
	}
	public int code_modify(Map params) {
		return update("Code.code_modify", params);
	}
	public int code_del(Map params) {
		return update("Code.code_del", params);
	}
	public int updateCodeOrderSeq(Map<String, String> params) {
		return update("Code.updateCodeOrderSeq", params);
	}
}