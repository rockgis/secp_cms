package com.mc.web.programs.back.homepage.impl;

import com.mc.common.util.RequestSnack;
import com.mc.common.util.StringUtil;
import com.mc.web.MCMap;
import com.mc.web.common.FileUtil;
import com.mc.web.common.SessionInfo;
import com.mc.web.login.McAdminLoginService;
import com.mc.web.login.session.SessionInformationSupport;
import com.mc.web.programs.back.homepage.HomepageDAO;
import com.mc.web.programs.back.homepage.HomepageHelper;
import com.mc.web.programs.back.homepage.HomepageService;
import com.mc.web.programs.back.site.basic_setting.SiteBasicDAO;
import com.mc.web.service.Globals;
import egovframework.com.cmm.util.EgovHttpRequestHelper;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.json.simple.JSONArray;
import org.json.simple.JSONValue;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.security.core.session.SessionRegistry;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service("HomepageService")
public class HomepageServiceImpl extends EgovAbstractServiceImpl implements HomepageService{
	
	@Autowired
	private HomepageDAO dao;
	
	@Autowired
	private HomepageHelper helper;
	
	@Autowired
	private FileUtil fileUtil;
	
	@Autowired
	private SiteBasicDAO basicDAO;
	
	@Autowired
	private McAdminLoginService loginService;

	@Autowired
	private SessionRegistry sessionRegistry;

	public String dashboard(Map params) throws Exception {
		HttpServletRequest request = EgovHttpRequestHelper.getCurrentRequest();
		params.put("mode", "home");
		params.put("site_id", StringUtil.isEmptyByParam(RequestSnack.getCookie(request, "adh_menu_current_siteid"))?"1":RequestSnack.getCookie(request, "adh_menu_current_siteid"));
		request.setAttribute("data", helper.dashboardData(params));
		return "/super/homepage/index";
	}

	@Cacheable(value="menuCache")
	public List left_list(Map params) throws Exception {
		return dao.left_list(params);
	}
	
	public Map view(Map params) throws Exception {
		Map rstMap = new HashMap();
		rstMap.put("view", dao.view(params));
		rstMap.put("staff_group", dao.staffGroup_list(params)); // 담당그룹
		rstMap.put("staffs", dao.staff_list(params)); // 페이지 담당
		rstMap.put("permissions", dao.permission_list(params)); // 페이지 권한

		rstMap.put("libs", dao.lib_list(params));
		return rstMap;
	}

	public String modifyFrm(Map params) throws Exception {
		HttpServletRequest request = EgovHttpRequestHelper.getCurrentRequest();
		request.setAttribute("view", dao.view(params));
		return "/super/homepage/modify";
	}
	public String contentFrm(Map params) throws Exception {
		HttpServletRequest request = EgovHttpRequestHelper.getCurrentRequest();
		request.setAttribute("view", dao.view(params));
		return "/super/homepage/contentFrm";
	}
	public Map write(Map params) throws Exception {
		HttpServletRequest request = EgovHttpRequestHelper.getCurrentRequest();
		SessionInfo.sessionAuth(params);
		dao.write(params);
		params.put("menu_url", helper.createMenuUrl(params));
		dao.updateMenuUrl(params);

		List list = (List) params.get("staff_group");
		if(list != null){
			for (int i = 0; i < list.size(); i++) {
				Map m = (Map) list.get(i);
				m.put("order_seq", i+1);
				m.put("cms_menu_seq", params.get("cms_menu_seq"));
				m.put("session_member_id", params.get("session_member_id"));
				m.put("session_member_nm", params.get("session_member_nm"));
				dao.insertStaffGroup(m);
			}
		}

		list = (List) params.get("staffs");
		if(list != null){
			for (int i = 0; i < list.size(); i++) {
				Map m = (Map) list.get(i);
				m.put("order_seq", i+1);
				m.put("cms_menu_seq", params.get("cms_menu_seq"));
				m.put("session_member_id", params.get("session_member_id"));
				m.put("session_member_nm", params.get("session_member_nm"));
				dao.insertStaff(m);
			}
		}

		list = (List) params.get("permissions");
		if(list != null){
			for (int i = 0; i < list.size(); i++) {
				Map m = (Map) list.get(i);
				m.put("order_seq", i+1);
				m.put("cms_menu_seq", params.get("cms_menu_seq"));
				m.put("session_member_id", params.get("session_member_id"));
				m.put("session_member_nm", params.get("session_member_nm"));
				dao.insertPermission(m);
			}
		}
		
		list = (List) params.get("libs");
		if(list != null){
			for (int i = 0; i < list.size(); i++) {
				Map m = (Map) list.get(i);
				m.put("order_seq", i+1);
				m.put("cms_menu_seq", params.get("cms_menu_seq"));
				String path = request.getSession().getServletContext().getRealPath(Globals.LIBS_PATH);
				dao.insert_lib(m);
				fileUtil.copy(request.getSession().getServletContext().getRealPath(Globals.TEMP_PATH) + File.separator + m.get("uuid"), path + File.separator + m.get("uuid"),path);
			}
		}
		
		Map rstMap = new HashMap();
		return rstMap;
	}

	public Map modify(Map params) throws Exception {
		HttpServletRequest request = EgovHttpRequestHelper.getCurrentRequest();
		SessionInfo.sessionAuth(params);
		params.put("menu_url", helper.createMenuUrl(params));
		Map rstMap = new HashMap();
		params.put("json_staff_group", params.get("staff_group").toString());
		params.put("json_staffs", params.get("staffs").toString());
		params.put("json_permissions", params.get("permissions").toString());
		params.put("json_libs", params.get("libs").toString());

		dao.backup(params);
		rstMap.put("rst", dao.modify(params));

		dao.staffGroup_del(params);
		List list = (List) params.get("staff_group");
		if(list != null){
			for (int i = 0; i < list.size(); i++) {
				Map m = (Map) list.get(i);
				m.put("order_seq", i+1);
				m.put("cms_menu_seq", params.get("cms_menu_seq"));
				m.put("session_member_id", params.get("session_member_id"));
				m.put("session_member_nm", params.get("session_member_nm"));
				dao.insertStaffGroup(m);
			}
		}

		dao.staff_del_all(params);
		list = (List) params.get("staffs");
		if(list != null){
			for (int i = 0; i < list.size(); i++) {
				Map m = (Map) list.get(i);
				m.put("order_seq", i+1);
				m.put("cms_menu_seq", params.get("cms_menu_seq"));
				m.put("session_member_id", params.get("session_member_id"));
				m.put("session_member_nm", params.get("session_member_nm"));
				dao.insertStaff(m);
			}
		}

		dao.permission_del_all(params);
		list = (List) params.get("permissions");
		if(list != null){
			for (int i = 0; i < list.size(); i++) {
				Map m = (Map) list.get(i);
				m.put("order_seq", i+1);
				m.put("cms_menu_seq", params.get("cms_menu_seq"));
				m.put("session_member_id", params.get("session_member_id"));
				m.put("session_member_nm", params.get("session_member_nm"));
				dao.insertPermission(m);
			}
		}

		dao.delete_lib_all(params);
		list = (List) params.get("libs");
		if(list != null){
			for (int i = 0; i < list.size(); i++) {
				Map m = (Map) list.get(i);
				m.put("order_seq", i+1);
				m.put("cms_menu_seq", params.get("cms_menu_seq"));
				String path = request.getSession().getServletContext().getRealPath(Globals.LIBS_PATH);
				dao.insert_lib(m);
				fileUtil.copy(request.getSession().getServletContext().getRealPath(Globals.TEMP_PATH) + File.separator + m.get("uuid"), path + File.separator + m.get("uuid"),path);
			}
		}
		
		return rstMap;
	}
	
	public Map contentSave(Map params) throws Exception {
		HttpServletRequest request = EgovHttpRequestHelper.getCurrentRequest();
		SessionInfo.sessionAuth(params);
		Map rstMap = new HashMap();
		dao.contentBackup(params);
		rstMap.put("rst", dao.contentSave(params));
		return rstMap;
	}
	
	public Map temp_save(Map params) throws Exception {
		HttpServletRequest request = EgovHttpRequestHelper.getCurrentRequest();
		Map rstMap = new HashMap();
		rstMap.put("rst", dao.temp_save(params));
		return rstMap;
	}
	
	public Map backup_list(Map params) throws Exception {
		Map rstMap = new HashMap();
		List<MCMap> list = dao.backup_list(params);
		for (MCMap map : list) {
			map.put("staffs", (JSONArray) JSONValue.parse(String.valueOf(map.get("json_staffs"))));
			map.put("staff_group", (JSONArray) JSONValue.parse(String.valueOf(map.get("json_staff_group"))));
			map.put("libs", (JSONArray) JSONValue.parse(String.valueOf(map.get("json_libs"))));
		}
		rstMap.put("list", list);
		rstMap.put("pagination", dao.backup_pagination(params));
		return rstMap;
	}
	
	public Map content_backup_list(Map params) throws Exception {
		Map rstMap = new HashMap();
		rstMap.put("list", dao.content_backup_list(params));
		rstMap.put("pagination", dao.content_backup_pagination(params));
		return rstMap;
	}

	/*@CacheEvict(value="menuCache", allEntries=true)
	public Map revert(Map params) throws Exception {
		SessionInfo.sessionAuth(params);
		Map rstMap = new HashMap();
		rstMap.put("rst", dao.revert(params));
		return rstMap;
	}*/

	@CacheEvict(value="menuCache", allEntries=true)
	public Map menu_move(Map params) throws Exception {
		SessionInfo.sessionAuth(params);
		Map rstMap = new HashMap();
		
		List list = (List) params.get("list");
		if(list != null){
			for (int i = 0; i < list.size(); i++) {
				Map m = (Map) list.get(i);
				dao.update_menu_order(m);
			}
		}
		
		rstMap.put("rst", "1");
		return rstMap;
	}

	@CacheEvict(value="menuCache", allEntries=true)
	public Map del(Map params) throws Exception {
		SessionInfo.sessionAuth(params);
		List<Map> childMenus = dao.getChildMenus(params);
		if (!CollectionUtils.isEmpty(childMenus)) {
			for (Map childMenu: childMenus) {
				childMenu.put("session_member_id", params.get("session_member_id"));
				childMenu.put("session_member_nm", params.get("session_member_nm"));
				dao.del(childMenu);
			}
		}
		Map rstMap = new HashMap();
		rstMap.put("rst", dao.del(params));
		return rstMap;
	}
	
	public Map page_navi(Map params) throws Exception {
		Map rstMap = new HashMap();
		rstMap.put("page_navi", dao.page_navi(params));
		return rstMap;
	}

	public String left() throws Exception {
		HttpServletRequest request = EgovHttpRequestHelper.getCurrentRequest();
		Map params = new HashMap();
		SessionInfo.sessionAuth(params);
//		request.setAttribute("site_list", dao.site_list());
		request.setAttribute("my_manage_page", dao.my_manage_page(params));
		request.setAttribute("my_permission_page", dao.my_permission_page(params));
		return "/super/homepage/left";
	}
	
	public Map update_favorites(Map params) {
		SessionInfo.sessionAuth(params);
		Map rstMap = new HashMap();
		dao.delete_favorites(params);
		List list = (List) params.get("list");
		if(list != null){
			for (int i = 0; i < list.size(); i++) {
				Map m = (Map) list.get(i);
				m.put("order_seq", i+1);
				m.put("member_id", params.get("session_member_id"));
				dao.update_favorites(m);
			}
		}
		rstMap.put("rst", "1");
		return rstMap;
	}
	
	public List get_favorites(Map params) {
		SessionInfo.sessionAuth(params);
		return dao.get_favorites(params);
	}
	
	public Map get_menu_toggle(Map params) {
		SessionInfo.sessionAuth(params);
		return dao.get_menu_toggle(params);
	}
	
	public Map update_menu_toggle(Map params) {
		Map rstMap = new HashMap();
		SessionInfo.sessionAuth(params);
		dao.update_menu_toggle(params);
		rstMap.put("rst", "1");
		return rstMap;
	}
	
	public String help(Map params) throws Exception {
		HttpServletRequest request = EgovHttpRequestHelper.getCurrentRequest();
		request.setAttribute("view", dao.view(params));
		return "/super/homepage/help";
	}
	
	public String header(Map params) throws Exception {
		HttpServletRequest request = EgovHttpRequestHelper.getCurrentRequest();
		SessionInfo.sessionAuth(params);
		request.setAttribute("site_list", dao.site_list(params));
		request.setAttribute("basic_view", basicDAO.basic_view("1"));
		return "/super/inc/header";
	}
	
	public Map overplus(Map params) {
		Map rstMap = new HashMap();
		SessionInfo.sessionAuth(params);
		rstMap.put("alram_list", dao.alram_list(params));

		SessionInformationSupport sessionInformationSupport = new SessionInformationSupport(sessionRegistry);
		Map p = new HashMap();
		//실시간 사용자 접속카운트
		p.put("gubun", "admin");
		rstMap.put("online_count", sessionInformationSupport.getSessionInformations(p).size());
		return rstMap;
	}
	
	public Map alram_close(Map params) {
		Map rstMap = new HashMap();
		SessionInfo.sessionAuth(params);
		dao.alram_close(params);
		rstMap.put("rst", "1");
		return rstMap;
	}
}