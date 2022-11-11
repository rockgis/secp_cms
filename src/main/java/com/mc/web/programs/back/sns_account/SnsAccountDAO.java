package com.mc.web.programs.back.sns_account;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.mc.web.MCMap;
import com.mc.web.service.CmsAbstractDAO;

@Repository
public class SnsAccountDAO extends CmsAbstractDAO {
	
	public MCMap view() {
		return selectOne("Comments.account_view");
	}
	public int modify(Map params) {
		return update("Comments.account_modify", params);
	}
	public int face_access_token_exchange(Map params) {
		return update("Comments.face_access_token_exchange", params);
	}
}