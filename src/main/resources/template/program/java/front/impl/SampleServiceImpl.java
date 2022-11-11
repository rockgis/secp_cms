package com.mc.web.programs.front.{{SUB_NAME_LOWER}}.impl;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mc.web.programs.front.{{SUB_NAME_LOWER}}.{{SUB_NAME_CAMEL}}DAO;
import com.mc.web.programs.front.{{SUB_NAME_LOWER}}.{{SUB_NAME_CAMEL}}Service;

/**
 *
 * @Description : {{TITLE}} 프로그램 서비스 구현
 * @ClassName   : com.mc.web.programs.{{SUB_NAME_LOWER}}.impl.{{SUB_NAME_CAMEL}}ServiceImpl.java
 * @Modification Information
 *
 * @author {{USER_NAME}}
 * @since 2018. 3. 29.
 * @version 1.0 *  
 * Copyright (C)  All right reserved.
 */
@Service
public class {{SUB_NAME_CAMEL}}ServiceImpl implements {{SUB_NAME_CAMEL}}Service {
	
	@Autowired
	private {{SUB_NAME_CAMEL}}DAO dao;
	
	public String {{LAST_PATH}}(Map<String, String> params) throws Exception {
		return "programs{{JSP_PATH}}";
	}
	
}
