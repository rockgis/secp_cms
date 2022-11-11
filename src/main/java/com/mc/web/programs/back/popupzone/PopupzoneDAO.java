package com.mc.web.programs.back.popupzone;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.mc.web.service.CmsAbstractDAO;

@Repository
public class PopupzoneDAO extends CmsAbstractDAO {

	public List list(Map params){
		return selectList("popupzone.list", params);
	}
	
	public Map pagination(Map params){
		return selectOne("popupzone.pageinfo",params);
	}
	
	public Map view(Map<String, String> params){
		return (Map) selectOne("popupzone.view", params);
	}
	
	public int write(Map<String, String> params){
		return update("popupzone.insert", params);
	}
	
	public int modify(Map<String, String> params){
		return update("popupzone.update", params);
	}
	
	public int del(Map<String, String> params){
		return update("popupzone.delete", params);
	}
	
	public int mobileInit(){
		return update("popupzone.mobile_init", null);
	}

	public int sort(Map<String, String> params) {
		return update("popupzone.sort", params);
	}
	
}
