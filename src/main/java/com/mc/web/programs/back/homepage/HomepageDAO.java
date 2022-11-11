package com.mc.web.programs.back.homepage;

import com.mc.web.MCMap;
import com.mc.web.service.CmsAbstractDAO;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public class HomepageDAO extends CmsAbstractDAO {
	public List<MCMap> left_list(Map params) {
		return selectList("Menu.left_list", params);
	}
	public MCMap view(Map params) {
		return selectOne("Menu.view", params);
	}
	public List<MCMap> staff_list(Map params) {
		return selectList("Menu.staff_list", params);
	}
	public List<MCMap> staffGroup_list(Map params) {
		return selectList("Menu.staffGroup_list", params);
	}
	public List<MCMap> permission_list(Map params) {
		return selectList("Menu.permission_list", params);
	}
	@CacheEvict(value="menuCache", allEntries=true)
	public int write(Map params) {
		return update("Menu.write", params);
	}
	public int backup(Map params) {
		return update("Menu.backup", params);
	}
	public int contentBackup(Map params) {
		return update("Menu.contentBackup", params);
	}
	public int insertStaff(Map params) {
		return update("Menu.insertStaff", params);
	}
	public int insertPermission(Map params) {
		return update("Menu.insertPermission", params);
	}
	public int staff_del_all(Map params) {
		return delete("Menu.staff_del_all", params);
	}
	public int permission_del_all(Map params) {
		return delete("Menu.permission_del_all", params);
	}
	public int staff_del(Map params) {
		return delete("Menu.staff_del", params);
	}
	public int staff_del_user(Map params) {
		return delete("Menu.staff_del_user", params);
	}
	public int permission_del(Map params) {
		return delete("Menu.permission_del", params);
	}
	public int permission_del_user(Map params) {
		return delete("Menu.permission_del_user", params);
	}
	public int insertStaffGroup(Map params) {
		return update("Menu.insertStaffGroup", params);
	}
	public int staffGroup_del(Map params) {
		return delete("Menu.staffGroup_del", params);
	}
	@CacheEvict(value="menuCache", allEntries=true)
	public int modify(Map params) {
		return update("Menu.modify", params);
	}
	@CacheEvict(value="menuCache", allEntries=true)
	public int contentSave(Map params) {
		return update("Menu.contentSave", params);
	}
	public int temp_save(Map params) {
		return update("Menu.temp_save", params);
	}
	public List<MCMap> backup_list(Map params) {
		return selectList("Menu.backup_list", params);
	}
	public MCMap backup_pagination(Map params) {
		return selectOne("Menu.backup_pagination", params);
	}
	public List<MCMap> content_backup_list(Map params) {
		return selectList("Menu.content_backup_list", params);
	}
	public MCMap content_backup_pagination(Map params) {
		return selectOne("Menu.content_backup_pagination", params);
	}
//	public int revert(Map params) {
//		return update("Menu.revert", params);
//	}
	public List<Map> getChildMenus(Map params) {
		return selectList("Menu.getChildMenus", params);
	}
	public int del(Map params) {
		return update("Menu.del", params);
	}
	public int update_menu_order(Map params) {
		return update("Menu.update_menu_order", params);
	}
	public int updateMenuUrl(Map params) {
		return update("Menu.updateMenuUrl", params);
	}
	public List<MCMap> site_list() {
		return selectList("Menu.site_list");
	}
	public List<MCMap> site_list(Map params) {
		return selectList("Menu.site_list", params);
	}
	public List<MCMap> menu_staff_list(Map params) {
		return selectList("Menu.menu_staff_list", params);
	}
	public List<MCMap> menu_permission_list(Map params) {
		return selectList("Menu.menu_permission_list", params);
	}
	public List<String> my_manage_page(Map params) {
		return selectList("Menu.my_manage_page", params);
	}
	public List<String> my_permission_page(Map params) {
		return selectList("Menu.my_permission_page", params);
	}
	public MCMap page_navi(Map params) {
		return selectOne("Menu.page_navi", params);
	}
	public List get_favorites(Map params) {
		return selectList("Menu.get_favorites", params);
	}
	public void update_favorites(Map params) {
		update("Menu.update_favorites", params);
	}
	public void delete_favorites(Map params) {
		update("Menu.delete_favorites", params);
	}
	public MCMap get_menu_toggle(Map params) {
		return selectOne("Menu.get_menu_toggle", params);
	}
	public void update_menu_toggle(Map params) {
		update("Menu.update_menu_toggle", params);
	}
	public int delete_lib_all(Map params) {
		return update("Menu.delete_lib_all", params);
	}
	public int insert_lib(Map params) {
		return update("Menu.insert_lib", params);
	}
	public List lib_list(Map params) {
		return selectList("Menu.lib_list", params);
	}
	public List menu_status(Map params) {
		return selectList("Dashboard.menu_status", params);
	}
	public List latest_article(Map params) {
		return selectList("Dashboard.latest_article", params);
	}
	public List popular_article(Map params) {
		return selectList("Dashboard.popular_article", params);
	}
	public int visit_cnt(Map params) {
		return selectOne("Dashboard.visit_cnt", params);
	}
	public List alram_list(Map params) {
		return selectList("Alram.alram_list", params);
	}
	public int alram_close(Map params) {
		return update("Alram.alram_close", params);
	}
}