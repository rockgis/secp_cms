package com.mc.web.programs.back.site.js_css;

import java.lang.reflect.Method;
import java.util.HashMap;
import java.util.Map;

import org.springframework.cache.interceptor.KeyGenerator;
import org.springframework.stereotype.Component;

@Component
public class JsCssKeyGenerator implements KeyGenerator{


	public static final int NO_PARAM_KEY = 0;

	public static final int NULL_PARAM_KEY = 53;


	@Override
	public Object generate(Object target, Method method, Object... params) {
		if (params.length == 0) {
			return NO_PARAM_KEY;
		}
		Map p = (HashMap)params[0];
		return p.get("site_id")+"_"+p.get("file_name");
	}
	
}
