package com.mc.web.programs.back.bbs;

import java.util.List;
import java.util.Map;

import com.mc.web.programs.back.bbs.AdminBbsService;

public interface AdminBbsMainService{

	public Map boardInfo(Map params) throws Exception;
	public List catList(Map params) throws Exception;
	public Map delete(Map params) throws Exception;
	public Map articleMove(Map params) throws Exception;
	public Map articleCopy(Map params) throws Exception;
	public Map articleDelete(Map params) throws Exception;
	public Map articleRestore(Map params) throws Exception;
}
