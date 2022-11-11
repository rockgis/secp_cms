package com.mc.web.login;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

@Controller
public class McUserLoginController {
	
	@Autowired
	private McUserLoginService service;
 
	@RequestMapping("/login/loginSuccess.do")
	public String loginSuccess(@RequestParam Map<String, String> params, HttpServletRequest request, HttpServletResponse response) throws Exception{
		return service.loginSuccess(params);
	}
	
	@RequestMapping("/login/logout.do")
	public String logout(@RequestParam Map<String, String> params, HttpServletRequest request, HttpServletResponse response) throws Exception{
		return service.logout(params, response);
	}
	
	@RequestMapping("/login/login_fail.do")
	public String login_fail(@RequestParam Map<String, String> params) throws Exception{
		return service.login_fail(params);
	}
	
	@ResponseBody
	@RequestMapping(value="/login/check_id.do", method=RequestMethod.POST)
	public Map check_id(@RequestParam Map<String, String> params) throws Exception{
		return service.check_id(params);
	}
	
	@RequestMapping("/login/login_duplicate.do")
	public String login_duplicate(@RequestParam Map<String, String> params) throws Exception{
		return service.login_duplicate(params);
	}

}
