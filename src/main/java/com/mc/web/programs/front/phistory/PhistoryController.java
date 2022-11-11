package com.mc.web.programs.front.phistory;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

/**
 *
 * @Description : 페이지이력 프로그램 컨트롤러
 * @ClassName   : com.mc.web.programs.phistory.PhistoryController.java
 * @Modification Information
 *
 * @author sdlck
 * @since 2018. 3. 29.
 * @version 1.0 *  
 * Copyright (C)  All right reserved.
 */
@Controller
public class PhistoryController {
	
	@Autowired
	private PhistoryService service; 
	
	@RequestMapping(value="/phistory/intro.do")
	public String intro(HttpServletRequest request, @RequestParam Map<String, String> params) throws Exception{
		return service.intro(params);
	}
}
