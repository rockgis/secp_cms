package com.mc.web.programs.back.group_user.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.stereotype.Service;

import com.mc.common.util.StringUtil;
import com.mc.web.programs.back.group_user.UserGroupDAO;
import com.mc.web.programs.back.group_user.UserGroupService;
import com.mc.web.common.SessionInfo;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service("UserGroupService")
public class UserGroupServiceImpl extends EgovAbstractServiceImpl implements UserGroupService{
	
	@Autowired
	private UserGroupDAO dao;
	
	public List list(Map params) throws Exception {
		return dao.list(params);
	}
	
	public Map view(Map params) throws Exception {
		Map rstMap = new HashMap();
		rstMap.put("view", dao.view(params));
		rstMap.put("staff_list", dao.menuGrantList(params));
		return rstMap;
	}
	
	public Map write(Map params) throws Exception {
		SessionInfo.sessionAuth(params);
		if(!StringUtil.isEmpty((String)params.get("tel1")) && !StringUtil.isEmpty((String)params.get("tel2")) && !StringUtil.isEmpty((String)params.get("tel3"))){
			params.put("tel", params.get("tel1")+"-"+params.get("tel2")+"-"+params.get("tel3"));
		}
		if(!StringUtil.isEmpty((String)params.get("fax1")) && !StringUtil.isEmpty((String)params.get("fax2")) && !StringUtil.isEmpty((String)params.get("fax3"))){
			params.put("fax", params.get("fax1")+"-"+params.get("fax2")+"-"+params.get("fax3"));
		}
		Map rstMap = new HashMap();
		dao.write(params);

		List list = (List) params.get("staff_list");
		if(list != null){
			for (int i = 0; i < list.size(); i++) {
				Map m = (Map) list.get(i);
				m.put("order_seq", i+1);
				m.put("group_seq", params.get("group_seq"));
				m.put("group_nm", params.get("group_nm"));
				m.put("session_member_id", params.get("session_member_id"));
				m.put("session_member_nm", params.get("session_member_nm"));
				dao.insertMenuGrant(m);
			}
		}
		rstMap.put("rst", 1);
		return rstMap;
	}

	@CacheEvict(value= {"menuCache","menuGrantCache"}, allEntries=true)
	public Map modify(Map params) throws Exception {
		SessionInfo.sessionAuth(params);
		if(!StringUtil.isEmpty((String)params.get("tel1")) && !StringUtil.isEmpty((String)params.get("tel2")) && !StringUtil.isEmpty((String)params.get("tel3"))){
			params.put("tel", params.get("tel1")+"-"+params.get("tel2")+"-"+params.get("tel3"));
		}
		if(!StringUtil.isEmpty((String)params.get("fax1")) && !StringUtil.isEmpty((String)params.get("fax2")) && !StringUtil.isEmpty((String)params.get("fax3"))){
			params.put("fax", params.get("fax1")+"-"+params.get("fax2")+"-"+params.get("fax3"));
		}
		Map rstMap = new HashMap();
//		if(!params.get("manage_seq").equals(params.get("current_manage_seq")) || ("".equals(params.get("manage_seq")))){
//			permitDAO.permit_del_group_member_all(params);
//		}
		dao.modify(params);
		dao.deleteMenuGrant(params);

		List list = (List) params.get("staff_list");
		if(list != null){
			for (int i = 0; i < list.size(); i++) {
				Map m = (Map) list.get(i);
				m.put("order_seq", i+1);
				m.put("group_seq", params.get("group_seq"));
				m.put("group_nm", params.get("group_nm"));
				m.put("session_member_id", params.get("session_member_id"));
				m.put("session_member_nm", params.get("session_member_nm"));
				dao.insertMenuGrant(m);
			}
		}
		rstMap.put("rst", 1);
		return rstMap;
	}
	
	public Map del(Map params) throws Exception {
		SessionInfo.sessionAuth(params);
		Map rstMap = new HashMap();
		if("YES".equals(params.get("mode"))){
			dao.del(params);
			dao.del_member(params);
			rstMap.put("rst", "1");
		}else if("NO".equals(params.get("mode"))){
			dao.del(params);
			dao.move_member(params);
			rstMap.put("rst", "1");
		}
		return rstMap;
	}
	
	public Map updateMenuGrant(Map params) throws Exception {
		SessionInfo.sessionAuth(params);
		Map rstMap = new HashMap();
		
		dao.deleteMenuGrant(params);

		List list = (List) params.get("list");
		if(list != null){
			for (int i = 0; i < list.size(); i++) {
				Map m = (Map) list.get(i);
				m.put("order_seq", i+1);
				m.put("group_seq", params.get("group_seq"));
				m.put("group_nm", params.get("group_nm"));
				m.put("session_member_id", params.get("session_member_id"));
				m.put("session_member_nm", params.get("session_member_nm"));
				dao.insertMenuGrant(m);
			}
		}
		
		rstMap.put("rst", "1");
		return rstMap;
	}
	
	public List menuGrantList(Map params) throws Exception {
		return dao.menuGrantList(params);
	}
}