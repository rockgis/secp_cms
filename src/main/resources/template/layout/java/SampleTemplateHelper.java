package com.mc.web.page.{{SUB_NAME_LOWER}};

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.mc.web.MCMap;
import com.mc.web.page.TemplateHelperAbst;

/**
 *
 * @Description : 화면구성에 필요한 계산식이나 html가공시 TemplateHelperAbst의 메소드 오버라이딩하여 사용하시기바랍니다.
 * @ClassName   : com.mc.web.page.{{SUB_NAME_CAMEL}}TemplateHelper.java
 * @Modification Information
 *
 * @author {{USER_NAME}}
 * @since 2015. 6. 8.
 * @version 1.0 *  
 * Copyright (C)  All right reserved.
 */
@Service(value="{{SUB_NAME_LOWER}}TemplateHelper")
public class {{SUB_NAME_CAMEL}}TemplateHelper extends TemplateHelperAbst{
	
	/**
	 * 
	 * Comment  : 상단메뉴 html 생성
	 * @version : 1.0
	 * @tags    : @param list
	 * @tags    : @return
	 * @date    : 2015. 6. 3.
	 *
	 */
	public String makeTopMenu(List<MCMap> list, Map params) {
		return super.makeTopMenu(list, params);
	}

	/**
	 * 
	 * Comment  : 모바일메뉴 html 생성
	 * @version : 1.0
	 * @tags    : @param list
	 * @tags    : @return
	 * @date    : 2015. 6. 3.
	 *
	 */
	public String makeMobileMenu(List<MCMap> list, Map params) {
		return super.makeMobileMenu(list, params);
	}

	/**
	 * 
	 * Comment  : 왼쪽 메뉴 html 생성 
	 * @tags    : @param list
	 * @tags    : @return
	 * @date    : 2015. 5. 21.
	 *
	 */
	public String makeLeftMenu(List<MCMap> list, Map params) {
		return super.makeLeftMenu(list, params);
	}

	/**
	 * 
	 * Comment  : 탭 메뉴 html 생성 
	 * @tags    : @param list
	 * @tags    : @return
	 * @date    : 2015. 6. 13.
	 *
	 */
	public String makeTabMenu(List<MCMap> list, Map params) {
		return super.makeTabMenu(list, params);
	}

	/**
	 * 
	 * Comment  : 현재 페이지 위치정보 
	 * @version : 1.0
	 * @tags    : @param list
	 * @tags    : @param params
	 * @tags    : @return
	 * @date    : 2015. 6. 9.
	 *
	 */
	public MCMap getPageNavi(List<MCMap> list, Map params) {
		return super.getPageNavi(list, params);
	}
	
	/**
	 * 
	 * Comment  : 주소창 타이틀  
	 * @version : 1.0
	 * @tags    : @param list
	 * @tags    : @param params
	 * @tags    : @return
	 * @date    : 2015. 6. 9.
	 *
	 */
	public String getPageTitle(List<MCMap> list, String cms_menu_seq) {
		return super.getPageTitle(list, cms_menu_seq);
	}

	/**
	 * 
	 * Comment  : 하위링크 주소 빼오기 
	 * @version : 1.0
	 * @tags    : @param list
	 * @tags    : @param menu_seq
	 * @tags    : @return
	 * @date    : 2015. 6. 17.
	 *
	 */
	public String getSubLink(List<MCMap> list, String menu_seq) {
		return super.getSubLink(list, menu_seq);
	}
	
	/**
	 * 
	 * Comment  : 컨텐츠 상단 표시할 대표내용
	 * 			  가까운 부모의 대표 컨텐츠를 가져온다.
	 * @version : 1.0
	 * @tags    : @param list
	 * @tags    : @param menu_seq
	 * @tags    : @return
	 * @date    : 2015. 6. 25.
	 *
	 */
	public String getContHeader(List<MCMap> list, String menu_seq) {
		return super.getContHeader(list, menu_seq);
	}

	public String makeLibs(List<MCMap> list) {
		return super.makeLibs(list);
	}
	
}