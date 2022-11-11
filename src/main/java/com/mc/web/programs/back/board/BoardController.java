package com.mc.web.programs.back.board;

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

@Controller
public class BoardController {

	@Autowired
	private BoardService service;
	
	@RequestMapping("/super/system/board/index.do")
	public String index(@RequestParam Map<String, String> params, HttpServletRequest request) throws Exception{
		return "/super/system/board/index";
	}

	@ResponseBody
	@RequestMapping("/super/system/board/list.do")
	public Map list(@RequestParam Map<String, String> params, HttpServletRequest request) throws Exception{
		return service.list(params);
	}
	
	@ResponseBody
	@RequestMapping("/super/system/board/menu_list.do")
	public Map menu_list(@RequestParam Map<String, String> params, HttpServletRequest request, HttpSession session) throws Exception{
		return service.menu_list(params);
	}
	
	@ResponseBody
	@RequestMapping("/super/system/board/insert.do")
	@Transactional(rollbackFor=Exception.class)
	public Map insert(@RequestParam Map<String, Object> jsonObject, HttpServletRequest request) throws Exception{
		Map params = (JSONObject) JSONValue.parse((String)jsonObject.get("jData"));	//JSON으로 보내준 데이터를 사용
		return service.insert(params);
	}
	
	@ResponseBody
	@RequestMapping("/super/system/board/modify.do")
	@Transactional(rollbackFor=Exception.class)
	public Map modify(@RequestParam Map<String, Object> jsonObject, HttpServletRequest request) throws Exception{
		Map params = (JSONObject) JSONValue.parse((String)jsonObject.get("jData"));	//JSON으로 보내준 데이터를 사용
		return service.modify(params);
	}
	
	@ResponseBody
	@RequestMapping("/super/system/board/delete.do")
	@Transactional(rollbackFor=Exception.class)
	public Map delete(@RequestParam Map<String, String> params, HttpServletRequest request) throws Exception{
		return service.delete(params);
	}
	
	@ResponseBody
	@RequestMapping("/super/system/board/info.do")
	@Transactional(rollbackFor=Exception.class)
	public Map info(@RequestParam Map<String, String> params, HttpServletRequest request) throws Exception{
		return service.info(params);
	}
	
	@ResponseBody
	@RequestMapping("/super/system/board/customColumnList.do")
	public List<Map> customColumnList(@RequestParam Map<String, String> params, HttpServletRequest request) throws Exception{
		return service.customColumnList();
	}

	@ResponseBody
	@RequestMapping("/super/system/board/element_list.do")
	public List<Map> customElementList(@RequestParam Map<String, String> params, HttpServletRequest request) throws Exception{
		return service.customElementList(params);
	}
	
	@ResponseBody
	@RequestMapping("/super/system/board/type_list.do")
	public List<Map> typeList() throws Exception{
		return service.typeList();
	}
	
	@ResponseBody
	@RequestMapping("/super/system/board/type_insert.do")
	@Transactional(rollbackFor=Exception.class)
	public Map typeInsert(@RequestParam Map<String, Object> jsonObject, HttpServletRequest request) throws Exception{
		Map params = (JSONObject) JSONValue.parse((String)jsonObject.get("jData"));	//JSON으로 보내준 데이터를 사용
		return service.typeInsert(params);
	}
	
	@ResponseBody
	@RequestMapping("/super/system/board/type_modify.do")
	@Transactional(rollbackFor=Exception.class)
	public Map typeModify(@RequestParam Map<String, String> jsonObject, HttpServletRequest request) throws Exception{
		Map params = (JSONObject) JSONValue.parse((String)jsonObject.get("jData"));	//JSON으로 보내준 데이터를 사용
		return service.typeModify(params);
	}
	
	@ResponseBody
	@RequestMapping("/super/system/board/type_delete.do")
	@Transactional(rollbackFor=Exception.class)
	public Map typeDelete(@RequestParam Map<String, String> jsonObject, HttpServletRequest request) throws Exception{
		Map params = (JSONObject) JSONValue.parse((String)jsonObject.get("jData"));	//JSON으로 보내준 데이터를 사용
		return service.typeDelete(params);
	}
	
}
