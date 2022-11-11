package com.mc.web.programs.back.userreport;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mc.web.programs.back.satifaction.SatisfactionService;

@Controller
public class UserreportController {
	
	@Autowired
	private UserreportService service;
	
	@ResponseBody
	@RequestMapping(value="/userreport/userReport.do", method=RequestMethod.POST)
	public Map userReport(@RequestParam Map<String, String> params, HttpServletRequest request, HttpSession session) throws Exception{
		return service.userReport(params);
	}
}
