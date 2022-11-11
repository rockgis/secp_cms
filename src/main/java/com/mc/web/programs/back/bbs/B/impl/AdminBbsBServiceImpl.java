package com.mc.web.programs.back.bbs.B.impl;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mc.common.util.RequestSnack;
import com.mc.web.programs.back.bbs.AdminBbsDAO;
import com.mc.web.programs.back.bbs.AdminBbsHelper;
import com.mc.web.programs.back.bbs.B.AdminBbsBService;
import com.mc.web.programs.back.filter.FilterService;
import com.mc.web.programs.back.userreport.UserreportDAO;
import com.mc.web.attach.AttachDAO;
import com.mc.web.common.FileUtil;
import com.mc.web.common.SessionInfo;
import com.mc.web.service.Globals;

import egovframework.com.cmm.util.EgovHttpRequestHelper;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service("AdminBbsBService")
public class AdminBbsBServiceImpl extends EgovAbstractServiceImpl implements AdminBbsBService{
	
	@Autowired
	private AdminBbsDAO dao;

	@Autowired
	private AttachDAO attachDAO;
	
	@Autowired
	private UserreportDAO reportDAO;
	
	@Autowired
	private FileUtil fileUtil;
	
	@Autowired
	private AdminBbsHelper helper;
	
	@Autowired
	private FilterService filterService;
	
	public Map list(Map params) throws Exception {
		Map rstMap = new HashMap();
		RequestSnack.setPageParams(params);
		rstMap.put("list", dao.list(params));
		rstMap.put("pagination", dao.pagination(params));
		return rstMap;
	}
	
	public Map write(Map params) throws Exception {
		Map rstMap = new HashMap();
		HttpServletRequest request = EgovHttpRequestHelper.getCurrentRequest();
		SessionInfo.sessionAuth(params);
		rstMap.put("rst", dao.write(params));
		helper.articleFileUpload(params, request);
		//필터사용시 등록,수정시 콜
		Map p = new HashMap();
		p.put("site_id", params.get("site_id"));
		p.put("t_menu_seq", params.get("cms_menu_seq"));
		p.put("sub_seq", params.get("article_seq"));
		p.put("title", params.get("title"));
		filterService.report_update(p);
		return rstMap;
	}

	public Map view(Map params) throws Exception {
		Map rstMap = new HashMap();
		Map view = dao.view(params);
		rstMap.put("view", view);
		params.put("table_nm", "MC_ARTICLE");
		params.put("table_seq", params.get("article_seq"));
		rstMap.put("files", attachDAO.list(params));
		rstMap.put("reports", reportDAO.viewlist(params));
		/*	이전글 다음글 */
		Map prev = new HashMap();
		Map next = new HashMap();
		if(params.containsKey("del_yn")){
			prev.put("del_yn", params.get("del_yn"));
			next.put("del_yn", params.get("del_yn"));
		}
		prev.put("board_seq", params.get("board_seq"));
		prev.put("prev_article", view.get("rn"));
		rstMap.put("prev", dao.view(prev));
		next.put("board_seq", params.get("board_seq"));
		next.put("next_article", view.get("rn"));
		rstMap.put("next", dao.view(next));
		return rstMap;
	}

	public Map modify(Map params) throws Exception {
		Map rstMap = new HashMap();
		HttpServletRequest request = EgovHttpRequestHelper.getCurrentRequest();
		SessionInfo.sessionAuth(params);
			helper.articleThumb(params, request);
			dao.modify(params);
			params.put("table_seq", params.get("article_seq"));
			params.put("table_nm", "MC_ARTICLE");
			attachDAO.delete_all(params);
			
			helper.articleFileUpload(params, request);
			List list = (List) params.get("removeFiles");
			if(list != null){
				for (int i = 0; i < list.size(); i++) {
					Map m = (Map) list.get(i);
					fileUtil.delete(request.getSession().getServletContext().getRealPath(Globals.FILE_PATH) + File.separator + m.get("yyyy") + File.separator + m.get("mm") + File.separator + m.get("uuid"));
				}
			}
			
			//필터사용시 등록,수정시 콜
			Map p = new HashMap();
			p.put("site_id", params.get("site_id"));
			p.put("t_menu_seq", params.get("cms_menu_seq"));
			p.put("sub_seq", params.get("article_seq"));
			p.put("title", params.get("title"));
			filterService.report_update(p);
			rstMap.put("rst", "1");
		return rstMap;
	}
}
