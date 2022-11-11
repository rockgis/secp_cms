package com.mc.web.programs.front.sitemap;

import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class SiteMapController {
	
	Logger log = Logger.getLogger(this.getClass());
	
	@Autowired
	private SiteMapService service;

	@RequestMapping("/sitemap/intro.do")
	public String sitemap(@RequestParam Map<String, String> params) throws Exception {
		return service.sitemap(params);
	}
}
