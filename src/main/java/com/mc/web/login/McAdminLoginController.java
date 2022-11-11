package com.mc.web.login;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class McAdminLoginController {
	
	@Autowired
	private McAdminLoginService service;
 
	@RequestMapping("/super/login/logout.do")
	public String logout(@RequestParam Map<String, String> params, HttpServletRequest request, HttpServletResponse response) throws Exception{
		return service.logout(params, response);
	}
	
	@RequestMapping("/super/login/login_fail.do")
	public String login_fail(@RequestParam Map<String, String> params) throws Exception{
		return service.login_fail(params);
	}
	
	@ResponseBody
	@RequestMapping(value="/super/login/check_id.do", method=RequestMethod.POST)
	public Map check_id(@RequestParam Map<String, String> params) throws Exception{
		return service.check_id(params);
	}
	
	@RequestMapping("/super/login/login_duplicate.do")
	public String login_duplicate(@RequestParam Map<String, String> params) throws Exception{
		return service.login_duplicate(params);
	}
	
	@ResponseBody
	@RequestMapping("/super/current_user/list.do")
	public Map login_userlist(@RequestParam Map<String, String> params) throws Exception{
		return service.login_userlist(params);
	}
	
	@ResponseBody
	@RequestMapping("/super/login/force_logout.do")
	public Map force_logout(@RequestParam Map<String, String> params) throws Exception{
		return service.force_logout(params);
	}
	
	@ResponseBody
	@RequestMapping(value="/super/login/session_keep.do", method=RequestMethod.POST)
	public Map session_keep(@RequestParam Map<String, String> params) throws Exception{
		return service.session_keep(params);
	}

}
