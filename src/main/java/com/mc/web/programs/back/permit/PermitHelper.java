package com.mc.web.programs.back.permit;

import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.springframework.stereotype.Service;

import com.mc.web.MCMap;

/**
 *
 * @Description : 
 * @ClassName   : com.mc.web.programs.back.permit.PermitHelper.java
 * @Modification Information
 *
 * @author 이창기
 * @since 2017. 4. 19.
 * @version 1.0 *  
 * Copyright (C)  All right reserved.
 */
@Service
public class PermitHelper {
	Logger logger = Logger.getLogger(this.getClass());
	
	public List<MCMap> makeList(List<MCMap> list) {
		List<MCMap> rstList = new ArrayList();
		Document doc = Jsoup.parse("<div class='menuwrap'></div>");
		
		for (MCMap mcmap : list) {
			String menu = makeLi(mcmap);
			makeUlRefact(doc, mcmap, menu);
		}
		//삭제메뉴 처리
		doc.select("li[del_yn=Y]").remove();
		doc.select("li[use_yn=N]").remove();
		outer : for (Element e : doc.select("li")) {
			String menu_seq = e.attr("menu-seq");
			for (MCMap item : list) {
				if(menu_seq.equals(item.getStr("cms_menu_seq"))){
					rstList.add(item);
					continue outer;
				}
			}
		}
		return rstList;
	}

	private String makeLi(MCMap map){
		StringBuilder sb = new StringBuilder();
		sb.append("	<li menu-seq='"+map.getStrNull("cms_menu_seq")+"' del_yn='"+map.getStrNull("del_yn")+"' use_yn='"+map.getStrNull("use_yn")+"'>");
		sb.append(map.getStrNull("title"));
		sb.append("	</li>");
		return sb.toString();
	}

	/**
	 * 
	 * Comment  : Ul생성 리팩토링
	 * @tags    : @param list
	 * @tags    : @return
	 * @date    : 2015. 6. 13.
	 *
	 */
	private void makeUlRefact(Document doc, MCMap mcmap, String menu) {
		String sb = ".menuwrap";
		for (int i = 1; i < mcmap.getIntNumber("menu_level"); i++) {
			sb += ">ul>li";
		}
		Element o = doc.select(sb).last();
		if(o.select("ul").size()==0) 
			o.append("<ul></ul>");
		o.select(">ul").append(menu);
	}

}