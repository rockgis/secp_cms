package com.mc.web.programs.back.bbs;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.mc.web.MCMap;
import com.mc.web.service.CmsAbstractDAO;

@Repository
public class AdminBbsDAO extends CmsAbstractDAO {

	public MCMap boardType(Map params) {
		return selectOne("Bbs.boardType", params);
	}
	public MCMap boardInfo(Map params) {
		return selectOne("Bbs.boardInfo", params);
	}
	public List<MCMap> catList(Map<String, String> params) {
		return selectList("Bbs.catList", params);
	}
	public List<MCMap> stateList(Map<String, String> params) {
		return selectList("Bbs.stateList", params);
	}
	public List<MCMap> notice_list(Map params) {
		return selectList("Bbs.notice_list", params);
	}
	public List<MCMap> list(Map params) {
		return selectList("Bbs.list", params);
	}
	public MCMap pagination(Map params) {
		return selectOne("Bbs.pagination", params);
	}
	public int write(Map<String, String> params) {
		return insert("Bbs.write", params);
	}
	public Map view(Map<String, String> params) {
		return selectOne("Bbs.view", params);
	}
	public int modify(Map<String, String> params){
		return update("Bbs.modify", params);
	}
	public int delete(Map<String, Object> params){
		return update("Bbs.delete", params);
	}
	public int articleCopy(Map<String, String> params) {
		return insert("Bbs.articleCopy", params);
	}
	public int articleMove(Map params) {
		return update("Bbs.articleMove", params);
	}
	
	public int articleDelete(Map params) {
		return delete("Bbs.articleDelete", params);
	}
	
	public int articleRestore(Map params) {
		return delete("Bbs.articleRestore", params);
	}
	public int answer(Map params) {
		return update("Bbs.answer", params);
	}
	
	public Map replyStep(Map<String, Object> params){
		return selectOne("Bbs.replyStep", params);
	}
	
	public Map selectStep(Map<String, String> params) {
		return selectOne("Bbs.selectStep", params);
	}
	
	public int replySort(Map<String, String> params){
		return update("Bbs.replySort", params);		
	}
	
	public int personal_report(Map params){
		return insert("Filter.report_insert",params);
	}
}