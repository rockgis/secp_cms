package com.mc.web.programs.back.{{SUB_NAME_LOWER}};

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 *
 * @Description : {{TITLE}} 프로그램 컨트롤러
 * @ClassName   : com.mc.web.programs.back.{{SUB_NAME_LOWER}}.Admin{{SUB_NAME_CAMEL}}Controller.java
 * @Modification Information
 *
 * @author {{USER_NAME}}
 * @since 2018. 3. 29.
 * @version 1.0 *  
 * Copyright (C)  All right reserved.
 */
@Controller
public class Admin{{SUB_NAME_CAMEL}}Controller {
	
	@Autowired
	private Admin{{SUB_NAME_CAMEL}}Service service;
	
	@ResponseBody
	@RequestMapping(value="/super{{MIDDEL_URL_PATH}}/test.do")
	public Map test(@RequestParam Map<String, String> params) throws Exception{
		return service.test(params);
	}
}