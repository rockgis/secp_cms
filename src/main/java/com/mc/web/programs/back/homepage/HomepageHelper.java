package com.mc.web.programs.back.homepage;

import java.util.HashMap;
import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import com.mc.common.util.DateUtil;
import com.mc.common.util.StringUtil;

/**
 * 
 * @Class Name : MainHelper.java
 * @Description : 화면구성에 필요한 계산식이나 html가공시 이 클래스사용
 * @Modification Information
 *
 *    수정일         수정자         수정내용
 *    -------        -------     -------------------
 *    
 * @author LCK
 * @since 2015. 5. 21.
 * @version 1.0
 * @see 
 * <pre>
 * </pre>
 */
@Service
public class HomepageHelper {
	Logger logger = Logger.getLogger(this.getClass());
	
	@Autowired
	private HomepageDAO dao;

	/**
	 * Comment  : 대시보드 데이터 캐시메모리에 담기위해 헬퍼쪽으로 이동 
	 * @version : 1.0
	 * @tags    : @param params
	 * @tags    : @return
	 * @tags    : @throws Exception
	 * @date    : 2017. 5. 10.
	 *
	 *
	 * @date    : 2021. 3. 18. 유명한 (메뉴관리 대시보드 캐시 삭제)
	 */
	/* @Cacheable(value="dashboardCache", keyGenerator="defaultKeyGenerator") */
	public Map dashboardData(Map params) throws Exception {
		Map rstMap = new HashMap();
		//메뉴현황
		rstMap.put("menu_status", dao.menu_status(params));
		
		Map p = new HashMap();
		
		//최신게시글
		p.put("rows", 10);
		p.put("site_id", params.get("site_id"));
		rstMap.put("latest_article", dao.latest_article(p));
		
		//인기페이지
		p.put("rows", 5);
		rstMap.put("popular_article", dao.popular_article(p));
		p.clear();
		
		//접속자통계
		//오늘
		p.put("site_id", params.get("site_id"));
		p.put("start_dt", DateUtil.getTime("yyMMdd00"));
		p.put("end_dt", DateUtil.getTime("yyMMdd99"));
		rstMap.put("today_cnt", dao.visit_cnt(p));
		//어제
		p.put("start_dt", DateUtil.subtract(DateUtil.getTime("yyyy-MM-dd"), "yyMMdd00", -1));
		p.put("end_dt", DateUtil.subtract(DateUtil.getTime("yyyy-MM-dd"), "yyMMdd99", -1));
		rstMap.put("yesterday_cnt", dao.visit_cnt(p));
		//이번주
		p.put("start_dt", DateUtil.getFirstWeekDay(DateUtil.getTime("yyyy-MM-dd"), "yyMMdd00"));
		p.put("end_dt", DateUtil.getLastWeekDay(DateUtil.getTime("yyyy-MM-dd"), "yyMMdd99"));
		rstMap.put("week_cnt", dao.visit_cnt(p));
		//전체
		rstMap.put("total_cnt", dao.visit_cnt(null));
		return rstMap;
	}

	/**
	 * 
	 * Comment  : 타입에 맞는 메뉴 URL을 생성 
	 * @version : 1.0
	 * @tags    : @param params
	 * @tags    : @return
	 * @date    : 2015. 6. 5.
	 *
	 */
	public String createMenuUrl(Map params) {
		String menu_url="/lay" + params.get("template_type");
		if("1".equals(params.get("menu_type"))){//일반페이지
			menu_url += "/S"+params.get("site_id")+"T" + params.get("parent_menu_seq") + "C" + params.get("cms_menu_seq") + "/contents.do";
		}else if("2".equals(params.get("menu_type"))){//게시판
			menu_url += "/bbs/S"+params.get("site_id")+"T" + params.get("parent_menu_seq") + "C"+ params.get("cms_menu_seq") + "/" + params.get("board_type") + "/" + params.get("board_seq") + "/list.do";
		}else if("3".equals(params.get("menu_type"))){//프로그램
			menu_url += "/program/S"+params.get("site_id")+"T" + params.get("parent_menu_seq") + "C"+ params.get("cms_menu_seq") + "/" + params.get("target_url");
			menu_url = menu_url.replaceAll("//", "/");
		}else if("4".equals(params.get("menu_type"))){//링크
			menu_url = (String) params.get("target_url");
		}else if("5".equals(params.get("menu_type"))){//하위메뉴링크
			menu_url += "/S"+params.get("site_id")+"T" + params.get("parent_menu_seq") + "C"+ params.get("cms_menu_seq") + "/sublink.do";
		}
//		if(!"1".equals(params.get("site_id"))){//마이크로 사이트
			Map p = new HashMap();
			p.put("cms_menu_seq", params.get("site_id"));
			if(!"4".equals(params.get("menu_type"))){//링크
				menu_url = dao.view(p).getStrNull("sub_path") + menu_url;
			}
//		}
		if(!StringUtil.isEmptyByParam(params, "add_param")){
			menu_url = menu_url + ("?" + (String)params.get("add_param")).replaceAll("\\?\\?", "?");
		}
		
		
		return menu_url;
	}
	
}