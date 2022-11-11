package com.mc.web.programs.front.bbs;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

/**
 * 
 * @Description : 
 * @ClassName   : com.mc.web.bbs.BbsService.java
 * @Modification Information
 *
 * @author 이창기
 * @since 2017. 3. 10.
 * @version 1.0 *  
 * Copyright (C)  All right reserved.
 */
public interface BbsService{

	public Map boardInfo(Map params) throws Exception;
	public boolean authCheck(String gubun, Map params);
	public String list(Map params) throws Exception;
	public String insertForm(Map params) throws Exception;
	public String insert(Map params, List<MultipartFile> attachList) throws Exception;
	public String view(Map params) throws Exception;
	public String modifyForm(Map params) throws Exception;
	public String modify(Map params, List<MultipartFile> attachList, List<String> delAttachList) throws Exception;
	public String delete(Map params) throws Exception;
}
