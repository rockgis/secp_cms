package com.mc.web.programs.back.popupzone.impl;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.mc.common.util.StringUtil;
import com.mc.web.FileDAO;
import com.mc.web.programs.back.popupzone.PopupzoneDAO;
import com.mc.web.programs.back.popupzone.PopupzoneService;
import com.mc.web.common.FileUtil;
import com.mc.web.common.SessionInfo;

import egovframework.com.cmm.util.EgovHttpRequestHelper;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service("PopupzoneService")
public class PopupzoneServiceImpl extends EgovAbstractServiceImpl implements PopupzoneService{
	
	@Autowired
	private PopupzoneDAO dao;
	
	@Autowired
	private FileDAO fileDAO;
	
	@Autowired
	private FileUtil fileUtil;
	
	@Value("#{config['upload.temp']}")
	private String TEMP_PATH;
	@Value("#{config['upload.popup']}")
	private String UPLOAD_PATH;

	@Override
	public Map list(Map params) throws Exception {
		Map rstMap = new HashMap();
		rstMap.put("list", dao.list(params));
		rstMap.put("pagination", dao.pagination(params));
		return rstMap;
	}
	
	public Map view(Map params) throws Exception {
		Map rstMap = new HashMap();
		SessionInfo.sessionAuth(params);
		rstMap.put("view", dao.view(params));
		params.put("table_nm", "MC_ARTICLE");
		params.put("table_seq", params.get("article_seq"));
		rstMap.put("files", fileDAO.list(params));
		return rstMap;
	}
	
	public Map write(HttpServletRequest request, Map params) throws Exception {
		Map rstMap = new HashMap();
		SessionInfo.sessionAuth(params);
		popupzoneFileUpload(request, params);
		rstMap.put("rst", dao.write(params));
		return rstMap;
	}
	
	public Map modify(HttpServletRequest request, Map params) throws Exception {
		Map rstMap = new HashMap();
		SessionInfo.sessionAuth(params);
		popupzoneFileUpload(request, params);
		rstMap.put("rst", dao.modify(params));
		return rstMap;
	}
	public Map del(Map params) throws Exception {
		Map rstMap = new HashMap();
		SessionInfo.sessionAuth(params);
		List deleteList = StringUtil.strToList((String)params.get("popupzone_seq"), ",");
		params.put("seq_list", deleteList);
		rstMap.put("rst", dao.del(params));
		return rstMap;
	}

	public Map sort(Map params) {
		Map rstMap = new HashMap();
		SessionInfo.sessionAuth(params);
		List list = (List) params.get("list");
		if(list != null){
			for (int i = 0; i < list.size(); i++) {
				Map m = (Map) list.get(i);
				m.put("session_member_id", params.get("session_member_id"));
				m.put("session_member_nm", params.get("session_member_nm"));
				m.put("ip", EgovHttpRequestHelper.getRequestIp());
				dao.sort(m);
			}
		}
		rstMap.put("rst", "1");
		return rstMap;
	}
	
	private void popupzoneFileUpload(HttpServletRequest request, Map params) throws IOException {
		List list = (List) params.get("files");
		if(list != null){
			for (int i = 0; i < list.size(); i++) {
				Map m = (Map) list.get(i);
				String path = request.getSession().getServletContext().getRealPath(UPLOAD_PATH+"/"+m.get("yyyy")+"/"+m.get("mm"));
				fileUtil.copy(request.getSession().getServletContext().getRealPath(TEMP_PATH) + File.separator + m.get("uuid"), path + File.separator + m.get("uuid"),path);
				params.put("file_path", UPLOAD_PATH+"/"+m.get("yyyy")+"/"+m.get("mm")+"/"+m.get("uuid"));
			}
		}
	}

}