package com.mc.web.programs.back.filemanager.impl;

import java.io.File;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mc.web.MCMap;
import com.mc.web.programs.back.filemanager.FilemanagerDAO;
import com.mc.web.programs.back.filemanager.FilemanagerHelper;
import com.mc.web.programs.back.filemanager.FilemanagerService;
import com.mc.web.common.SessionInfo;

import egovframework.com.cmm.util.EgovHttpRequestHelper;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service("FilemanagerService")
public class FilemanagerServiceImpl extends EgovAbstractServiceImpl implements FilemanagerService{

	@Autowired
	private FilemanagerDAO dao;
	
	@Autowired
	private FilemanagerHelper helper;
	
	public Map list(Map<String, String> params) throws Exception {
		Map rstMap = new HashMap();
		HttpServletRequest request = EgovHttpRequestHelper.getCurrentRequest();
		String path = request.getSession().getServletContext().getRealPath(params.get("path"));

		rstMap.put("list", helper.getRoot(path));
		return rstMap;
	}
	
	public Map filelist(Map<String, String> params) throws Exception {
		Map rstMap = new HashMap();
		HttpServletRequest request = EgovHttpRequestHelper.getCurrentRequest();
		String path = request.getSession().getServletContext().getRealPath(params.get("path"));

		rstMap.put("list", helper.getFileList(path)); 
		return rstMap;
	}
	
	public Map getRealFile(Map<String, String> params) throws Exception {
		HttpServletRequest request = EgovHttpRequestHelper.getCurrentRequest();
		String path = request.getSession().getServletContext().getRealPath(params.get("file_path"));
		return helper.getRealFile(path);
	}
	
	public Map modifyRealFile(Map<String, String> params) throws Exception {
		Map m = new HashMap();
		HttpServletRequest request = EgovHttpRequestHelper.getCurrentRequest();
		String path = request.getSession().getServletContext().getRealPath(params.get("file_path"));
		MCMap bakMap = helper.getRealFile(path);
		int rst = helper.modifyRealFile(params);
		if(rst>0){
			SessionInfo.sessionAuth(params);
			params.put("source", bakMap.getStr("source"));
			m.put("rst", dao.insert_file_history(params));
		}else{
			m.put("rst", rst);
		}
		return m;
	}
	
	public Map source_list(Map params) throws Exception {
		Map rstMap = new HashMap();
		rstMap.put("list", dao.source_list(params));
		rstMap.put("pagination", dao.source_pagination(params));
		return rstMap;
	}
	
	public Map previous_source(Map params) throws Exception {
		return dao.previous_source(params);
	}
	
	public Map createFolder(Map<String, String> params) throws Exception {
		HttpServletRequest request = EgovHttpRequestHelper.getCurrentRequest();
		String path = request.getSession().getServletContext().getRealPath(params.get("path"));
		return helper.createFolder(path);
	}
	
	public Map renameTo(Map<String, String> params) throws Exception {
		HttpServletRequest request = EgovHttpRequestHelper.getCurrentRequest();
		String path = request.getSession().getServletContext().getRealPath(params.get("dir"));
		return helper.renameTo(path, params.get("old"), params.get("new"));
	}
	
	public Map delete(Map<String, String> params) throws Exception {
		Map rstMap = new HashMap();
		HttpServletRequest request = EgovHttpRequestHelper.getCurrentRequest();
		String path = request.getSession().getServletContext().getRealPath(params.get("path"));
		if(helper.deleteFolder(new File(path))){
			rstMap.put("rst", "1");
		}else{
			rstMap.put("rst", "-1");
		}
		return rstMap;
	}
	
}
