package com.mc.web.programs.back.email;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.mc.web.MCMap;
import com.mc.web.service.CmsAbstractDAO;

@Repository
public class EmailAdminDAO extends CmsAbstractDAO {

	public List<MCMap> list(Map params) {
		return selectList("Email.list", params);
	}
	public List<MCMap> user_list(Map params) {
		return selectList("Email.user_list", params);
	}
	public MCMap pagination(Map params) {
		return selectOne("Email.pagination", params);
	}
	public int write(Map params) {
		return update("Email.write", params);
	}
	public MCMap view(Map params) {
		return selectOne("Email.view", params);
	}
	public int modify(Map params) {
		return update("Email.modify", params);
	}
	public int del(Map params) {
		return update("Email.del", params);
	}
	public List<MCMap> target_list(Map params) {
		return selectList("Email.target_list", params);
	}
	public MCMap target_pagination(Map params) {
		return selectOne("Email.target_pagination", params);
	}
	public int target_write(Map params) {
		return update("Email.target_write", params);
	}
	public int target_list_write(Map params) {
		return update("Email.target_list_write", params);
	}
	public MCMap target_view(Map params) {
		return selectOne("Email.target_view", params);
	}
	public List target_list_dtl(Map params) {
		return selectList("Email.target_list_dtl", params);
	}
	public int target_modify(Map params) {
		return update("Email.target_modify", params);
	}
	public int target_del(Map params) {
		return update("Email.target_del", params);
	}
	public int target_list_del(Map params) {
		return update("Email.target_list_del", params);
	}
	public List queue_list(Map params) {
		return selectList("Email.queue_list", params);
	}
	public List<MCMap> form_list(Map params) {
		return selectList("Email.form_list", params);
	}
	public MCMap form_pagination(Map params) {
		return selectOne("Email.form_pagination", params);
	}
	public int form_write(Map params) {
		return update("Email.form_write", params);
	}
	public MCMap form_view(Map params) {
		return selectOne("Email.form_view", params);
	}
	public int form_modify(Map params) {
		return update("Email.form_modify", params);
	}
	public int form_del(Map params) {
		return update("Email.form_del", params);
	}
	public List<MCMap> smtp_list(Map params) {
		return selectList("Email.smtp_list", params);
	}
	public MCMap smtp_pagination(Map params) {
		return selectOne("Email.smtp_pagination", params);
	}
	public int smtp_write(Map params) {
		return update("Email.smtp_write", params);
	}
	public MCMap smtp_view(Map params) {
		return selectOne("Email.smtp_view", params);
	}
	public int smtp_modify(Map params) {
		return update("Email.smtp_modify", params);
	}
	public int smtp_del(Map params) {
		return update("Email.smtp_del", params);
	}
	public List send_info_list(Map params) {
		return selectList("Email.send_info_list", params);
	}
	public int send_result(Map params) {
		return update("Email.send_result", params);
	}
	public int delete_mail_queue(Map params) {
		return update("Email.delete_mail_queue", params);
	}
	public int insert_mail_queue(Map params) {
		return update("Email.insert_mail_queue", params);
	}
	public int send_success(Map params) {
		return update("Email.send_success", params);
	}
	public int send_fail(Map params) {
		return update("Email.send_fail", params);
	}
	public List smtp_list_all() {
		return selectList("Email.smtp_list_all");
	}
	public int receive(Map<String, String> params) {
		return update("Email.receive", params);
	}
	public MCMap get_smtp_config(Map params) {
		return selectOne("Email.get_smtp_config", params);
	}
}