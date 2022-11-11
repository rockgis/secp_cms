package com.mc.web.programs.back.bbs;

import java.util.Map;

public interface AdminBbsService{

	public Map list(Map params) throws Exception;
	public Map write(Map params) throws Exception;
	public Map modify(Map params) throws Exception;
	public Map view(Map params) throws Exception;
}
