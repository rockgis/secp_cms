package com.mc.web.page.web.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mc.web.MCMap;
import com.mc.web.programs.back.homepage.HomepageDAO;
import com.mc.web.programs.back.satifaction.SatisfactionDAO;
import com.mc.web.programs.back.site.basic_setting.SiteBasicDAO;
import com.mc.web.page.TemplateDAO;
import com.mc.web.page.TemplateService;
import com.mc.web.page.web.WebTemplateHelper;

import egovframework.com.cmm.util.EgovHttpRequestHelper;

/**
*
* @Description : MC@CMS 템플릿 구현클래스
* @ClassName   : com.mc.web.page.web.impl.WebTemplateService.java
* @Modification Information
*
* @author 이창기
* @since 2018. 3. 29.
* @version 1.0 *  
* Copyright (C)  All right reserved.
*/
@Service("webTemplateService")
public class WebTemplateServiceImpl implements TemplateService{

	@Autowired
	private TemplateDAO dao;
	
	@Autowired
	private SatisfactionDAO satifactionDAO;

	@Resource(name="webTemplateHelper")
	private WebTemplateHelper helper;
	
	@Autowired
	private HomepageDAO homepageDAO;
	
	@Autowired
	private SiteBasicDAO basicDAO;

	private String rootPath = "/web";
	
	public String getRootPath(){
		return rootPath;
	}
	
	private String menuGrantFilter(Map params, String html) {
		HttpSession session = EgovHttpRequestHelper.getCurrentSession();
		MCMap member = (MCMap) session.getAttribute("member");
		Map<String, String> p = new HashMap<String, String>();
		
		//return html;
		
		/*
		 * 일반회원/비회원 메뉴권한 관리
		 */
		if(member != null) {
			p.put("group_seq", member.getStr("group_seq"));
			p.put("site_id", (String)params.get("site_id"));
			List<MCMap> list = dao.menuGrantList(p);
			
			Document doc = Jsoup.parse(html);
			for (MCMap m : list) {
				doc.select("li[menu-seq="+m.getStr("cms_menu_seq")+"]").attr("grant", "Y");
			}
			
			for (Element e: doc.select("li")) {
				if(!e.hasAttr("grant") && e.select("li:has([grant])").size()==0) {
					e.remove();
				}
			}
			return doc.select("body").html();
		}else {
			p.put("group_seq", "3");
			p.put("site_id", (String)params.get("site_id"));
			List<MCMap> list = dao.menuGrantList(p);
			
			Document doc = Jsoup.parse(html);
			for (MCMap m : list) {
				doc.select("li[menu-seq="+m.getStr("cms_menu_seq")+"]").attr("grant", "Y");
			}
			
			for (Element e: doc.select("li")) {
				if(!e.hasAttr("grant") && e.select("li:has([grant])").size()==0) {
					e.remove();
				}
			}
			return doc.select("body").html();			
			//return html;
		}
	}
	
	public String mobile_menu(Map<String, String> params) throws Exception {
		HttpServletRequest request = EgovHttpRequestHelper.getCurrentRequest();
		String html = helper.makeMobileMenu(dao.list(params.get("site_id")), params);
		request.setAttribute("mobile_menu", menuGrantFilter(params, html));
		return getRootPath()+"/inc/mobile_menu";
	}
	
	public String libs(Map<String, String> params) throws Exception {
		HttpServletRequest request = EgovHttpRequestHelper.getCurrentRequest();
		request.setAttribute("libs", helper.makeLibs(homepageDAO.lib_list(params)));
		return "/share/libs";
	}
	
	public String header(Map<String, String> params) throws Exception {
		HttpServletRequest request = EgovHttpRequestHelper.getCurrentRequest();
		String html = helper.makeTopMenu(dao.list(params.get("site_id")), params);
		request.setAttribute("topmenu", menuGrantFilter(params, html));
		return getRootPath()+"/inc/header";
	}
	
	public String footer(Map<String, String> params) throws Exception {
		HttpServletRequest request = EgovHttpRequestHelper.getCurrentRequest();
		request.setAttribute("footer", basicDAO.basic_view(params.get("site_id")));
		return getRootPath()+"/inc/footer";
	}
	
	public String leftmenu(Map<String, String> params) throws Exception {
		HttpServletRequest request = EgovHttpRequestHelper.getCurrentRequest();
		String html = helper.makeLeftMenu(dao.list(params.get("site_id")), params);
		request.setAttribute("leftmenu", menuGrantFilter(params, html));
		return getRootPath()+"/inc/left";
	}
	
	public String tabmenu(Map<String, String> params) throws Exception {
		HttpServletRequest request = EgovHttpRequestHelper.getCurrentRequest();
		String html = helper.makeTabMenu(dao.tabmenu(params), params);
		request.setAttribute("tabmenu", menuGrantFilter(params, html));
		return getRootPath()+"/inc/tabmenu";
	}
	
	public String sub_tit(Map<String, String> params) throws Exception {
		HttpServletRequest request = EgovHttpRequestHelper.getCurrentRequest();
		request.setAttribute("page_navi", helper.getPageNavi(dao.list(params.get("site_id")), params));
		return getRootPath()+"/inc/sub_tit";
	}
	
	public String page_navi(Map<String, String> params) throws Exception {
		HttpServletRequest request = EgovHttpRequestHelper.getCurrentRequest();
		request.setAttribute("page_navi", helper.getPageNavi(dao.list(params.get("site_id")), params));
		return getRootPath()+"/inc/page_navi";
	}
	
	public String page_title(Map<String, String> params) throws Exception {
		HttpServletRequest request = EgovHttpRequestHelper.getCurrentRequest();
		request.setAttribute("page_title", helper.getPageTitle(dao.list(params.get("site_id")), params.get("cms_menu_seq")));
		return getRootPath()+"/inc/page_title";
	}
	
	public String page_manager(Map<String, String> params) throws Exception {
		HttpServletRequest request = EgovHttpRequestHelper.getCurrentRequest();
		MCMap basic_view = basicDAO.basic_view(params.get("site_id"));
		request.setAttribute("basic_view", basic_view);
		if("Y".equals(basic_view.getStrNullVal("satisfaction_yn", "N"))){
			request.setAttribute("satisfaction", satifactionDAO.page_satisfaction(params));
		}
		if("Y".equals(basic_view.getStrNullVal("manage_yn", "N"))){
			request.setAttribute("manager_list", dao.page_manager(params));
		}
		return getRootPath()+"/inc/page_manager";
	}
	
	public String cont_header(Map<String, String> params) throws Exception {
		HttpServletRequest request = EgovHttpRequestHelper.getCurrentRequest();
		request.setAttribute("cont_header", helper.getContHeader(dao.list(params.get("site_id")), params.get("cms_menu_seq")));
		return getRootPath()+"/inc/cont_header";
	}
	
	public String general() throws Exception {
		HttpServletRequest request = EgovHttpRequestHelper.getCurrentRequest();
		String requestURI = request.getRequestURI();
		Pattern pattern = Pattern.compile("/lay\\d+/S(\\d+)T(\\d+)C(\\d+)/contents.do");
		Matcher match = pattern.matcher(requestURI);
		if(match.find()) {
			request.setAttribute("data", dao.general(match.group(3)));
		}else{
			return "";
		}
		return "gernal/contents";
	}
	
	public String sublink() throws Exception {
		String menu_seq = "";
		String site_id = "";
		HttpServletRequest request = EgovHttpRequestHelper.getCurrentRequest();
		String root = request.getContextPath();
		String requestURI = request.getRequestURI();
		Pattern pattern = Pattern.compile("(/.+)?/lay\\d+/S(\\d+)T(\\d+)C(\\d+)/sublink.do");
		Matcher match = pattern.matcher(requestURI);
		if(match.find()) {
			site_id = match.group(2);
			request.setAttribute("site_id", site_id);
			menu_seq = match.group(4);
		}else{
			return "";
		}
		String url = helper.getSubLink(dao.list(site_id), menu_seq);
		url = url.replaceAll("^".concat(root), "");
		return "redirect:" + url;
	}

	public String program() throws Exception {
		HttpServletRequest request = EgovHttpRequestHelper.getCurrentRequest();
		String requestURI = request.getRequestURI();
		Pattern pattern = Pattern.compile("(/.+)?/lay\\d+/program/S(\\d+)T(\\d+)C(\\d+)");
		Matcher match = pattern.matcher(requestURI);
		
		if(match.find()) {
			requestURI=match.replaceAll("");
		}else{
			return "";
		}
		request.setAttribute("program_url", requestURI);
		return "gernal/program";
	}
	
	public String bbs() throws Exception {
		HttpServletRequest request = EgovHttpRequestHelper.getCurrentRequest();
		String requestURI = request.getRequestURI();
		Pattern pattern = Pattern.compile("(/.+)?/lay\\d+/bbs/S(\\d+)T(\\d+)C(\\d+)/(.+)/(\\d+)/");
		Matcher match = pattern.matcher(requestURI);
		
		if(match.find()) {
			request.setAttribute("board_type", match.group(5));
			request.setAttribute("board_seq", match.group(6));
			requestURI=match.replaceAll("");
		}else{
			return "";
		}
		request.setAttribute("bbs_url", requestURI);
		return "gernal/bbs";
	}
	
}
