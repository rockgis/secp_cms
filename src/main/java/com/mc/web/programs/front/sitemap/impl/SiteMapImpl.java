package com.mc.web.programs.front.sitemap.impl;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mc.web.MCMap;
import com.mc.web.programs.front.sitemap.SiteMapDao;
import com.mc.web.programs.front.sitemap.SiteMapService;

import egovframework.com.cmm.util.EgovHttpRequestHelper;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service("SiteMapService")
public class SiteMapImpl extends EgovAbstractServiceImpl implements SiteMapService{

	@Autowired
	SiteMapDao dao;
	
	public String sitemap(Map<String, String> params) throws Exception {
		HttpServletRequest request = EgovHttpRequestHelper.getCurrentRequest();
		params.put("site_id", "1");
		String sitemap = makeSiteMap(dao.list("1"), params);
		request.setAttribute("sitemap", sitemap);
		return "sitemap/intro";
	}
	
	public String makeSiteMap(List<MCMap> list, Map<String, String> params) {
		Document doc = Jsoup.parse("<div class='menuwrap'></div>");
		for (MCMap mcmap : list) {
			String menu = makeSiteMapTree(mcmap);
			makeUlSiteMap(doc, mcmap, menu);
		}
		Elements li1 = doc.select(".menuwrap>ol>li");
		for (int i = 0; i < li1.size(); i++) {
			Element li = li1.get(i);
			li.addClass("title");
			li.select(">ol").addClass("list");
		}
//		doc.select(".menuwrap ol>li>ol>li>ol").remove();//3뎁스이상 삭제
		
		//상단메뉴에서 안보이는 설정되있으면 제거
//		doc.select(".menuwrap li[top_yn=N]").remove();
		doc.select(".menuwrap li").removeAttr("top_yn");
		//삭제메뉴 처리
		doc.select(".menuwrap li[del_yn=Y]").remove();
		doc.select(".menuwrap li").removeAttr("del_yn");
		//사용안함메뉴 처리
		doc.select(".menuwrap li[use_yn=N]").remove();
		doc.select(".menuwrap li").removeAttr("use_yn");

		return doc.select(".menuwrap").html();
	}
	
	private String makeSiteMapTree(MCMap map) {
		String root = EgovHttpRequestHelper.getCurrentRequest().getContextPath(); 
		StringBuilder sb = new StringBuilder();
		/*
		 * 2020.01.09 유명한
		 * 웹접근성 관련 menu-seq 삭제
		 * sb.append("	<li top_yn='"+map.getStrNull("top_yn")+"' menu-seq='"+map.getStrNull("cms_menu_seq")+"' del_yn='"+map.getStrNull("del_yn")+"' use_yn='"+map.getStrNull("use_yn")+"'>");
		 */
		sb.append("	<li top_yn='"+map.getStrNull("top_yn")+"' del_yn='"+map.getStrNull("del_yn")+"' use_yn='"+map.getStrNull("use_yn")+"'>");
		sb.append("		<a href='"+root+map.getStrNull("menu_url")+"' "+("Y".equals(map.getStrNull("blank_yn"))?"target=\"_blank\"":"")+">");
		sb.append(			map.getStrNull("title"));
		sb.append("		</a>");
		sb.append("	</li>");
		return sb.toString();
	}
	
	private void makeUlSiteMap(Document doc, MCMap mcmap, String menu) {
		String sb = ".menuwrap";
	
		for (int i = 1; i < mcmap.getIntNumber("menu_level"); i++) {
			sb += ">ol>li";
		}			
		
		Element o = doc.select(sb).last();
		if(o.select("ol").size()==0) {
			o.append("<ol></ol>");
		}
		o.select(">ol").append(menu);
	}
}