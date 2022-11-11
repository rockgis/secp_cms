package com.mc.web.programs.front.search;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class SearchController {
	Logger log = Logger.getLogger(this.getClass());
	
	@Autowired
	private SearchService service;
	
	@RequestMapping(value="/search.do", method=RequestMethod.GET)	
	public String searchPage(@RequestParam Map<String, Object> params) throws Exception {
		return service.search(params);
	}
	
	@RequestMapping(value="/search.do", method=RequestMethod.POST)
	@Transactional(rollbackFor = { Exception.class })
	@ResponseBody
	public Map search(@RequestParam Map<String, Object> params) throws Exception {
		return service.searchKeyword(params);
	}

	@ResponseBody
	@RequestMapping("/total/rank.do")
	public Map rank(ModelMap model, HttpServletRequest request, @RequestParam Map<String, String> params) throws Exception {
		return service.rank(params);
	}

	@ResponseBody
	@RequestMapping("/total/autocomplete.do")
	public List autocomplete(ModelMap model, HttpServletRequest request, @RequestParam Map<String, String> params, @RequestParam(value = "prefix", required = false, defaultValue = "") String prefix) throws Exception {
		return service.autocomplete(prefix);
	}
	
	@ResponseBody
	@RequestMapping("/admin/gathring/crawling.do")
	public Map crawling(ModelMap model, HttpServletRequest request, @RequestParam Map<String, String> params) throws Exception {
		return service.crawling(params);
	}
}
