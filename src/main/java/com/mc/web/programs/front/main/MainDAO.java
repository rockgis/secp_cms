package com.mc.web.programs.front.main;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.mc.web.MCMap;
import com.mc.web.service.CmsAbstractDAO;

@Repository
public class MainDAO extends CmsAbstractDAO {

	public List boardList(Map params) {
		return selectList("Bbs.list", params);
	}
	
	public List boardAllList(Map params) {
		return selectList("Bbs.boardAllList", params);
	}

	public List popupList(Map params) {
		return selectList("popupzone.main_popup", params);
	}
	
	public MCMap popupType(Map params) {
		return selectOne("popupzone.popup_type", params);
	}
	
	public List<MCMap> boardRlist(Map<String, String> params) {
		return selectList("PortalBoard.selectIntroBoard", params);
	}
}