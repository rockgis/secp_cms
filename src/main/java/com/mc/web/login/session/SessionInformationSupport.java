package com.mc.web.login.session;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.support.PagedListHolder;
import org.springframework.security.core.session.SessionInformation;
import org.springframework.security.core.session.SessionRegistry;

import com.mc.common.util.StringUtil;
import com.mc.web.MCMap;

/**
 *
 * @Description : 
 * @ClassName   : com.mc.web.login.session.SessionInformationSupport.java
 * @Modification Information
 *
 * @author 이창기
 * @since 2017. 5. 17.
 * @version 1.0 *  
 * Copyright (C)  All right reserved.
 */
public class SessionInformationSupport {
	private final SessionRegistry sessionRegistry;

	public SessionInformationSupport(SessionRegistry sessionRegistry) {
		this.sessionRegistry = sessionRegistry;
	}

	public List<MCMap> getSessionAllInformations(String paramGubun) {

		List<SessionInformation> sessionInformations = new ArrayList();
		for(Object principal : sessionRegistry.getAllPrincipals()) {
			sessionInformations.addAll(sessionRegistry.getAllSessions(principal, false));
		}

		List<MCMap> informations = new ArrayList();
		for(SessionInformation sessionInformation : sessionInformations) {
			Date lastRequest = sessionInformation.getLastRequest();
			String sessionId = sessionInformation.getSessionId();

			String member_id = null;
			String member_nm = null;
			String gubun = null;

			Object principal = sessionInformation.getPrincipal();
			if (principal instanceof Map) {
				Map<String, String> map = (Map) principal;
				member_id = map.get("member_id");
				member_nm = map.get("member_nm");
				gubun = map.get("gubun");

				if(!StringUtil.isEmpty(paramGubun)){
					if(!gubun.equals(paramGubun)){
						continue;
					}
				}
			}

			MCMap map = new MCMap();
			map.put("member_id", member_id);
			map.put("member_nm", member_nm);
			map.put("sessionId", sessionId);
			map.put("lastRequest", lastRequest);

			informations.add(map);
		}
		return informations;
	}

	public List<MCMap> getSessionInformations(Map params) {

		List<SessionInformation> sessionInformations = new ArrayList();
		for(Object principal : sessionRegistry.getAllPrincipals()) {
			sessionInformations.addAll(sessionRegistry.getAllSessions(principal, false));
		}

		List<MCMap> informations = new ArrayList();
		int rn = 1;
		for (int i = 0; i < sessionInformations.size(); i++) {
			SessionInformation sessionInformation = sessionInformations.get(i);
			Date lastRequest = sessionInformation.getLastRequest();
			String sessionId = sessionInformation.getSessionId();

			String member_id = null;
			String member_nm = null;
			String gubun = null;
			String group_seq = null;

			Object principal = sessionInformation.getPrincipal();
			
			if (principal instanceof Map) {
				Map<String, String> map = (Map) principal;
				member_id = map.get("member_id");
				member_nm = map.get("member_nm");
				gubun = map.get("gubun");
				group_seq = String.valueOf(map.get("group_seq"));

				String paramGubun = (String)params.get("gubun");
				String groupSeq = (String)params.get("group_seq");
				if(!StringUtil.isEmpty(paramGubun)){
					if(!gubun.equals(paramGubun)){
						continue;
					}
				}
				if(!StringUtil.isEmpty(groupSeq)){
					if(!group_seq.equals(groupSeq)){
						continue;
					}
				}
				
				String keyword = (String)params.get("keyword");
				if(!StringUtil.isEmpty(keyword)){
					if("member_id".equals((String)params.get("condition"))){
						if(member_id.indexOf(keyword)<0){
							continue;
						}
					}else if("member_nm".equals((String)params.get("condition"))){
						if(member_nm.indexOf(keyword)<0){
							continue;
						}
					}
				}
			}

			MCMap map = new MCMap();
			map.put("rn", rn++);
			map.put("gubun", gubun);
			map.put("member_id", member_id);
			map.put("member_nm", member_nm);
			map.put("sessionId", sessionId);
			map.put("lastRequest", lastRequest);

			informations.add(map);
		}
		
		int rows = StringUtil.isEmptyByParam(params, "rows")?10:Integer.parseInt((String)params.get("rows"));
		int cpage = StringUtil.isEmptyByParam(params, "cpage")?1:Integer.parseInt((String)params.get("cpage"));
		
		PagedListHolder paging = new PagedListHolder(informations);
		paging.setPageSize(rows);
		paging.setPage(cpage-1);
		return paging.getPageList();
	}

	public Map getPagination(Map params) {
		Map map = new HashMap();
		int totalSize = getSessionInformations(params).size();
		int rows = StringUtil.isEmptyByParam(params, "rows")?10:Integer.parseInt((String)params.get("rows"));
		int totalPage = (totalSize%rows)==0?totalSize/rows:+(totalSize/rows)+1;
		map.put("totalcount", totalSize);
		map.put("totalpage", totalPage);
		return map;
	}
	
	public boolean userExists(String member_id, String gubun) {
		for(MCMap information : getSessionAllInformations(gubun)) {
			String _member_id = information.getStrNull("member_id");

			if (member_id.equals(_member_id)) {
				return true;
			}
		}

		return false;
	}
}
