package com.mc.web.programs.front.comments;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.mc.web.MCMap;
import com.mc.web.service.CmsAbstractDAO;

@Repository
public class CommentsDAO extends CmsAbstractDAO {
	
	public MCMap sns_account() {
		return selectOne("Comments.account_view");
	}
	public List<MCMap> list(Map params) {
		return selectList("Comments.list", params);
	}
	
	public MCMap pagination(Map params) {
		return selectOne("Comments.pagination", params);
	}
	
	public int write(Map params) {
		return update("Comments.write", params);
	}
	
	public int sns_update(Map params) {
		return update("Comments.sns_update", params);
	}
	
	public int modify(Map params) {
		return update("Comments.modify", params);
	}
	
	public int del(Map params) {
		return update("Comments.del", params);
	}

}