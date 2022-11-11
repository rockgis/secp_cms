package com.mc.web.programs.back.board;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.mc.web.MCMap;
import com.mc.web.service.CmsAbstractDAO;

@Repository
public class BoardDAO extends CmsAbstractDAO {
	public List<MCMap> menu_list(Map params) {
		return selectList("board.menu_list", params);
	}
	public List<MCMap> list(Map<String, String> params) {
		return selectList("board.list", params);
	}
	public MCMap pagination(Map<String, String> params) {
		return selectOne("board.pageinfo", params);
	}
	public int insert(Map<String, String> params) {
		return insert("board.insert", params);
	}
	public int modify(Map<String, String> params) {
		return update("board.modify", params);
	}
	public MCMap info(Map<String, String> params) {
		return selectOne("board.info", params);
	}
	public int delete(Map<String, String> params) {
		return update("board.delete",params);
	}
	public List<MCMap> state_info(Map<String, String> params) {
		return selectList("board.selectStateList", params);
	}
	public void state_insert(Map<String, String> params) {
		insert("board.insertState", params);
	}
	public void state_update(Map<String, String> params) {
		insert("board.updateState", params);
	}	
	public void state_delete(Map<String, String> params) {
		insert("board.deleteState", params);
	}
	public List<MCMap> cat_info(Map<String, String> params) {
		return selectList("board.selectCatList", params);
	}
	public void cat_insert(Map<String, String> params) {
		insert("board.insertCat", params);
	}
	public void cat_update(Map<String, String> params) {
		insert("board.updateCat", params);
	}
	public void cat_delete(Map<String, String> params) {
		insert("board.deleteCat", params);
	}
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
}
