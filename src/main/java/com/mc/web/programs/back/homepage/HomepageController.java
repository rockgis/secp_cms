package com.mc.web.programs.back.homepage;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.json.simple.JSONValue;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * 
 * @Description : 관리자 메뉴관리 
 * @ClassName   : com.mc.web.programs.back.homepage.HomepageController.java
 * @author 이창기
 * @since 2015. 5. 21.
 * @version 1.0 *
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일        수정자       수정내용
 *  -------       --------    ---------------------------
 * </pre>
 */
@Controller
public class HomepageController {
	
	@Autowired
	private HomepageService service;
	
	@RequestMapping("/super/homepage/index.do")
	public String dashboard(@RequestParam Map<String, String> params, HttpServletRequest request, HttpSession session) throws Exception{
		return service.dashboard(params);
	}
	
	@RequestMapping("/super/homepage/left.do")
	public String left(@RequestParam Map<String, String> params, HttpServletRequest request, HttpSession session) throws Exception{
		return service.left();
	}
	
	@ResponseBody
	@RequestMapping("/super/homepage/left_list.do")
	public List left_list(@RequestParam Map<String, String> params, HttpServletRequest request, HttpSession session) throws Exception{
		return service.left_list(params);
	}

	@ResponseBody
	@RequestMapping("/super/homepage/menu_move.do")
	@Transactional(rollbackFor = { Exception.class })
	public Map menu_move(HttpServletRequest request, @RequestParam Map<String, Object> jsonObject) throws Exception{
		Map params = (JSONObject) JSONValue.parse((String)jsonObject.get("jData"));	//JSON으로 보내준 데이터를 사용
		return service.menu_move(params);
	}
	
	@RequestMapping("/super/homepage/writeFrm.do")
	public String writeFrm(@RequestParam Map<String, String> params, HttpServletRequest request, HttpSession session) throws Exception{
		return "/super/homepage/write";
	}
	
	@ResponseBody
	@RequestMapping("/super/homepage/write.do")
	@Transactional(rollbackFor = { Exception.class })
	public Map write(HttpServletRequest request, HttpSession session, @RequestParam Map<String, Object> jsonObject) throws Exception{
		Map params = (JSONObject) JSONValue.parse((String)jsonObject.get("jData"));	//JSON으로 보내준 데이터를 사용
		return service.write(params);
	}
	
	@RequestMapping("/super/homepage/modifyFrm.do")
	public String modifyFrm(@RequestParam Map<String, String> params) throws Exception{
		return service.modifyFrm(params);
	}
	
	@RequestMapping("/super/homepage/contentFrm.do")
	public String contentFrm(@RequestParam Map<String, String> params) throws Exception{
		return service.contentFrm(params);
	}
	
	@ResponseBody
	@RequestMapping("/super/homepage/view.do")
	public Map view(@RequestParam Map<String, String> params, HttpServletRequest request, HttpSession session) throws Exception{
		return service.view(params);
	}
	
	@ResponseBody
	@RequestMapping("/super/homepage/modify.do")
	@Transactional(rollbackFor = { Exception.class })
	public Map modify(HttpServletRequest request, HttpSession session, @RequestParam Map<String, Object> jsonObject) throws Exception{
		Map params = (JSONObject) JSONValue.parse((String)jsonObject.get("jData"));	//JSON으로 보내준 데이터를 사용
		return service.modify(params);
	}
	
	@ResponseBody
	@RequestMapping("/super/homepage/contentSave.do")
	@Transactional(rollbackFor = { Exception.class })
	public Map contentSave(HttpServletRequest request, HttpSession session, @RequestParam Map<String, Object> jsonObject) throws Exception{
		Map params = (JSONObject) JSONValue.parse((String)jsonObject.get("jData"));	//JSON으로 보내준 데이터를 사용
		return service.contentSave(params);
	}
	
	@ResponseBody
	@RequestMapping("/super/homepage/temp_save.do")
	@Transactional(rollbackFor = { Exception.class })
	public Map temp_save(HttpServletRequest request, HttpSession session, @RequestParam Map<String, Object> jsonObject) throws Exception{
		Map params = (JSONObject) JSONValue.parse((String)jsonObject.get("jData"));	//JSON으로 보내준 데이터를 사용
		return service.temp_save(params);
	}
	
	@ResponseBody
	@RequestMapping("/super/homepage/backup_list.do")
	public Map backup_list(HttpServletRequest request, HttpSession session, @RequestParam Map<String, String> params) throws Exception{
		return service.backup_list(params);
	}
	
	@ResponseBody
	@RequestMapping("/super/homepage/content_backup_list.do")
	public Map content_backup_list(HttpServletRequest request, HttpSession session, @RequestParam Map<String, String> params) throws Exception{
		return service.content_backup_list(params);
	}
	
	/*@ResponseBody
	@RequestMapping("/super/homepage/revert.do")
	public Map revert(HttpServletRequest request, HttpSession session, @RequestParam Map<String, String> params) throws Exception{
		return service.revert(params);
	}*/
	
	@ResponseBody
	@RequestMapping("/super/homepage/del.do")
	public Map del(HttpServletRequest request, HttpSession session, @RequestParam Map<String, String> params) throws Exception{
		return service.del(params);
	}
	
	@ResponseBody
	@RequestMapping("/super/homepage/page_navi.do")
	public Map page_navi(HttpServletRequest request, HttpSession session, @RequestParam Map<String, String> params) throws Exception{
		return service.page_navi(params);
	}
	
	@ResponseBody
	@RequestMapping("/super/homepage/get_favorites.do")
	public List get_favorites(HttpServletRequest request, HttpSession session, @RequestParam Map<String, String> params) throws Exception{
		return service.get_favorites(params);
	}
	
	@ResponseBody
	@RequestMapping("/super/homepage/update_favorites.do")
	@Transactional(rollbackFor = { Exception.class })
	public Map update_favorites(HttpServletRequest request, HttpSession session, @RequestParam Map<String, Object> jsonObject) throws Exception{
		Map params = (JSONObject) JSONValue.parse((String)jsonObject.get("jData"));	//JSON으로 보내준 데이터를 사용
		return service.update_favorites(params);
	}
	
	@ResponseBody
	@RequestMapping("/super/homepage/get_menu_toggle.do")
	public Map get_menu_toggle(HttpServletRequest request, HttpSession session, @RequestParam Map<String, String> params) throws Exception{
		return service.get_menu_toggle(params);
	}
	
	@ResponseBody
	@RequestMapping("/super/homepage/update_menu_toggle.do")
	@Transactional(rollbackFor = { Exception.class })
	public Map update_menu_toggle(HttpServletRequest request, HttpSession session, @RequestParam Map<String, String> params) throws Exception{
		return service.update_menu_toggle(params);
	}
	
	@RequestMapping("/super/inc/header.do")
	public String header(@RequestParam Map<String, String> params, HttpServletRequest request, HttpSession session) throws Exception{
		return service.header(params);
	}
	
	@ResponseBody
	@RequestMapping("/super/inc/overplus.do")
	public Map overplus(HttpServletRequest request, HttpSession session, @RequestParam Map<String, String> params) throws Exception{
		return service.overplus(params);
	}
	
	@ResponseBody
	@RequestMapping("/super/alram/alram_close.do")
	@Transactional(rollbackFor = { Exception.class })
	public Map alram_close(HttpServletRequest request, HttpSession session, @RequestParam Map<String, String> params) throws Exception{
		return service.alram_close(params);
	}
	
}
