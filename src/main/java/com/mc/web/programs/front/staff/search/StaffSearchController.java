package com.mc.web.programs.front.staff.search;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class StaffSearchController {
	@Autowired
	private StaffSearchService service;
	
	@RequestMapping("/staff/search/list.do")
	public String list(HttpServletRequest request, @RequestParam Map<String, String> params) throws Exception{
		return service.list(params);
	}
}
