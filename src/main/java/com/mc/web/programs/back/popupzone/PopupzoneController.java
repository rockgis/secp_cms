package com.mc.web.programs.back.popupzone;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
/**
 * 
 * @Description : 
 * @ClassName   : com.mc.web.programs.back.popupzone.PopupzoneController.java
 * @author 오승택
 * @since 2015. 6. 15.
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
public class PopupzoneController {
	Logger log = Logger.getLogger(this.getClass());

	@Autowired
	private PopupzoneService service;
	
	@ResponseBody
	@RequestMapping("/super/homepage/popup/list.do")
	@Transactional(rollbackFor = { Exception.class })
	public Map list(ModelMap model, HttpServletRequest request, HttpSession session, @RequestParam Map<String, String> params) throws Exception{
		return service.list(params);
	}
	
	@ResponseBody
	@RequestMapping("/super/homepage/popup/view.do")
	@Transactional(rollbackFor = { Exception.class })
	public Map view(ModelMap model, HttpServletRequest request, HttpSession session, @RequestParam Map<String, String> params) throws Exception{
		return service.view(params);
	}
	
	@ResponseBody
	@RequestMapping("/super/homepage/popup/insert.do")
	@Transactional(rollbackFor = { Exception.class })
	public Map write(ModelMap model, HttpServletRequest request, @RequestParam Map<String, Object> jsonObject) throws Exception{
		Map params = (JSONObject) JSONValue.parse((String)jsonObject.get("jData"));	//JSON으로 보내준 데이터를 사용
		return service.write(request, params);
	}	

	@ResponseBody
	@RequestMapping("/super/homepage/popup/modify.do")
	@Transactional(rollbackFor = { Exception.class })
	public Map modify(ModelMap model, HttpServletRequest request,  @RequestParam Map<String, Object> jsonObject) throws Exception{
		Map params = (JSONObject) JSONValue.parse((String)jsonObject.get("jData"));	//JSON으로 보내준 데이터를 사용
		return service.modify(request, params);
	}
	
	@ResponseBody
	@RequestMapping("/super/homepage/popup/delete.do")
	@Transactional(rollbackFor = { Exception.class })
	public Map del(ModelMap model, HttpServletRequest request, @RequestParam Map<String, Object> jsonObject) throws Exception{
		Map params = (JSONObject) JSONValue.parse((String)jsonObject.get("jData"));	//JSON으로 보내준 데이터를 사용
		return service.del(params);
	}
	
	
	@ResponseBody
	@RequestMapping("/super/homepage/popup/sort.do")
	@Transactional(rollbackFor = { Exception.class })
	public Map sort(ModelMap model, HttpServletRequest request, @RequestParam Map<String, Object> jsonObject) throws Exception{
		Map params = (JSONObject) JSONValue.parse((String)jsonObject.get("jData"));	//JSON으로 보내준 데이터를 사용
		return service.sort(params);
	}
}