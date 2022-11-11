package com.mc.web.programs.front.bbs;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.mc.web.MCMap;
import com.mc.web.service.CmsAbstractDAO;

@Repository
public class BbsDAO extends CmsAbstractDAO {

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
	public MCMap passCheck(Map<String, String> params){
		return selectOne("Bbs.passCheck", params);
	}
	public int modify(Map<String, String> params){
		return update("Bbs.modify", params);
	}
	public int delete(Map<String, Object> params){
		return update("Bbs.delete", params);
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
	
	public int viewcount(Map<String, String> params) {
		return update("Bbs.viewcount",params);		
	}
	
	public int personal_report(Map params){
		return insert("Filter.report_insert",params);
	}
	
	
	/*
	 * 커스텀 게시판 관련
	 */
	
	public List<Map> customColumnList(){
		return selectList("board.custom_column_list");
	}
	
	public List<Map> customElementList(Map<String, String> params){
		return selectList("board.element_list",params);
	}
	
	public int insertCustom(Map<String,String> params){
		return insert("board.insert_custom",params);
	}
	
	public int modifyCustom(Map<String,String> params){
		return update("board.modify_custom",params);
	}
	
	
	
	public List<Map> typeList() {
		return selectList("board.typeList");
	}

	public List<Map> typeCheck(Map<String, String> params) {
		return selectList("board.typeCheck",params);
	}

	public int typeInsert(Map<String, String> params) {
		return insert("board.typeInsert",params);
	}

	public int typeModify(Map<String, String> params) {
		return update("board.typeModify",params);
	}
	
	public int typeDelete(Map<String, String> params) {
		return delete("board.typeDelete",params);
	}
	
	/*커스텀게시판 동의란*/
	public List<MCMap> selectCustomAgree(Map<String, String> params) {
		return selectList("board.select_custom_agree", params);
	}
	
	public int insertCustomAgree(Map<String, String> params) {
		return insert("board.insert_custom_agree", params);
	}
	
	public int modifyCustomAgree(Map<String, String> params){
		return update("board.modify_custom_agree", params);
	}
	
	public int deleteCustomAgree(Map<String, String> params) {
		return update("board.delete_custom_agree", params);
	}
	public MCMap prev_seq(Map params) {
		return selectOne("Bbs.prev_seq", params);
	}
	public MCMap next_seq(Map params) {
		return selectOne("Bbs.next_seq", params);
	}
}