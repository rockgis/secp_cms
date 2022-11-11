package com.mc.web.programs.back.site.layout_setting.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mc.web.MCMap;
import com.mc.web.programs.back.site.layout_setting.LayoutSettingDAO;
import com.mc.web.programs.back.site.layout_setting.LayoutSettingService;
import com.mc.web.common.SessionInfo;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service("LayoutSettingService")
public class LayoutSettingServiceImpl extends EgovAbstractServiceImpl implements LayoutSettingService {

	@Autowired
	private LayoutSettingDAO dao;
	
	public Map layout_list(Map params) throws Exception {
		Map rstMap = new HashMap();
		List<MCMap> list = dao.layout_list(params);
		for (MCMap map : list) {
			map.put("modules", dao.layout_dtl_list(map));
		}
		rstMap.put("list", list);
		return rstMap;
	}

	public Map layout_insert(Map params) throws Exception {
		SessionInfo.sessionAuth(params);
		Map rstMap = new HashMap();

		dao.layout_dtl_delete(params);
		dao.layout_delete(params);
		List list = (List) params.get("items");
		if(list != null){
			for (int i = 0; i < list.size(); i++) {
				Map m = (Map) list.get(i);
				m.put("site_id", params.get("site_id"));
				dao.layout_insert(m);

				List<Map> modules_list = (List) m.get("modules");
				for (int j = 0; j < modules_list.size(); j++) {
					Map dtlMap = (Map) modules_list.get(j);
					dtlMap.put("idx", j+1);
					dtlMap.put("parent_seq", m.get("parent_seq"));
					dao.layout_dtl_insert(dtlMap);
				}
				
			}
		}
		return rstMap;
	}
}
