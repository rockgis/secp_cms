package com.mc.web.page.web;

import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.mc.web.page.TemplateService;

/**
 *
 * @Description : MC@CMS 템플릿 컨트롤러
 * @ClassName   : com.mc.web.page.web.WebTemplateController.java
 * @Modification Information
 *
 * @author 이창기
 * @since 2018. 3. 29.
 * @version 1.0 *  
 * Copyright (C)  All right reserved.
 */
@Controller
@RequestMapping(value="/web")
public class WebTemplateController{
	Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name="webTemplateService")
	private TemplateService service;
	
	@RequestMapping("/inc/mobile_menu.do")
	public String mobile_menu(@RequestParam Map<String, String> params) throws Exception{
		return service.mobile_menu(params);
	}
	
	@RequestMapping("/inc/libs.do")
	public String libs(@RequestParam Map<String, String> params) throws Exception{
		return service.libs(params);
	}
	
	@RequestMapping("/inc/header.do")
	public String header(@RequestParam Map<String, String> params) throws Exception{
		return service.header(params);
	}
	
	@RequestMapping("/inc/footer.do")
	public String footer(@RequestParam Map<String, String> params) throws Exception{
		return service.footer(params);
	}
	
	@RequestMapping("/inc/left.do")
	public String left(@RequestParam Map<String, String> params) throws Exception{
		return service.leftmenu(params);
	}
	
	@RequestMapping("/inc/sub_tit.do")
	public String sub_tit(@RequestParam Map<String, String> params) throws Exception{
		return service.sub_tit(params);
	}
	
	@RequestMapping("/inc/page_navi.do")
	public String page_navi(@RequestParam Map<String, String> params) throws Exception{
		return service.page_navi(params);
	}
	
	@RequestMapping("/inc/page_title.do")
	public String title(@RequestParam Map<String, String> params) throws Exception{
		return service.page_title(params);
	}
	
	@RequestMapping("/inc/tabmenu.do")
	public String tabmenu(@RequestParam Map<String, String> params) throws Exception{
		return service.tabmenu(params);
	}
	
	@RequestMapping("/inc/page_manager.do")
	public String page_manager(@RequestParam Map<String, String> params) throws Exception{
		return service.page_manager(params);
	}
	
	@RequestMapping("/inc/cont_header.do")
	public String cont_header(@RequestParam Map<String, String> params) throws Exception{
		return service.cont_header(params);
	}
	
	/**
	 * 
	 * Comment  : 일반 고정 페이지 호출 
	 * @version : 1.0
	 * @tags    : @param request
	 * @tags    : @param params
	 * @tags    : @param   _seq
	 * @tags    : @return
	 * @tags    : @throws Exception
	 * @date    : 2015. 6. 4.
	 *
	 */
	@RequestMapping("/lay{layout}/**/contents.do")
	public String general() throws Exception {
		return service.general();
	}
	
	/**
	 * 
	 * Comment  : 하위링크 페이지 호출 
	 * @version : 1.0
	 * @tags    : @param request
	 * @tags    : @param params
	 * @tags    : @param menu_seq
	 * @tags    : @return
	 * @tags    : @throws Exception
	 * @date    : 2015. 6. 4.
	 *
	 */
	@RequestMapping("/lay{layout}/**/sublink.do")
	public String sublink() throws Exception {
		return service.sublink();
	}

	/**
	 * 
	 * Comment  : 프로그램 페이지 호출
	 * @version : 1.0
	 * @tags    : @param request
	 * @tags    : @param params
	 * @tags    : @return
	 * @tags    : @throws Exception
	 * @date    : 2015. 6. 5.
	 *
	 */
	@RequestMapping("/lay{layout}/program/**/*.do")
	public String program() throws Exception {
		return service.program();
	}

	/**
	 * 
	 * Comment  : 게시판 페이지 호출
	 * @version : 1.0
	 * @tags    : @param request
	 * @tags    : @param params
	 * @tags    : @return
	 * @tags    : @throws Exception
	 * @date    : 2017. 3. 29.
	 *
	 */
	@RequestMapping("/lay{layout}/bbs/**/*.do")
	public String bbs() throws Exception {
		return service.bbs();
	}
}