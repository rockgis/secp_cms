package com.mc.web.programs.back.site.js_css;

import java.util.Map;

public interface JsCssService{
	
	public Map js_css_main(Map params) throws Exception;
	public Map js_css_list(Map params) throws Exception;
	public Map js_css_get_item(Map params) throws Exception;
	public Map js_css_write(Map params) throws Exception;
}
