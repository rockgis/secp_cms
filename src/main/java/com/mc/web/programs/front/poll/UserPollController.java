package com.mc.web.programs.front.poll;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class UserPollController {
	
	@Autowired
	private UserPollService service;
	
	@RequestMapping("/poll/list.do")
	public String list(HttpServletRequest request, @RequestParam Map<String, String> params) throws Exception{
		return service.list(params);
	}
	
	@RequestMapping("/poll/joinForm.do")
	public String joinForm(HttpServletRequest request, @RequestParam Map<String, String> params) throws Exception{
		return service.joinForm(params);
	}
	
	@RequestMapping(value="/poll/join.do", method=RequestMethod.POST)
	public String join(HttpServletRequest request, @RequestParam Map<String, String> params) throws Exception{
		return service.join(params);
	}
	
	@RequestMapping("/poll/result.do")
	public String result(HttpServletRequest request, @RequestParam Map<String, String> params) throws Exception{
		return service.result(params);
	}
}
