package com.mc.web.programs.front.{{SUB_NAME_LOWER}};

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

/**
 *
 * @Description : {{TITLE}} 프로그램 컨트롤러
 * @ClassName   : com.mc.web.programs.{{SUB_NAME_LOWER}}.{{SUB_NAME_CAMEL}}Controller.java
 * @Modification Information
 *
 * @author {{USER_NAME}}
 * @since 2018. 3. 29.
 * @version 1.0 *  
 * Copyright (C)  All right reserved.
 */
@Controller
public class {{SUB_NAME_CAMEL}}Controller {
	
	@Autowired
	private {{SUB_NAME_CAMEL}}Service service;
	
	@RequestMapping(value="{{URL}}")
	public String {{LAST_PATH}}(HttpServletRequest request, @RequestParam Map<String, String> params) throws Exception{
		return service.{{LAST_PATH}}(params);
	}
}
