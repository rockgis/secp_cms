package com.mc.web.programs.back.reserve;

import java.util.Map;

public interface ReserveService{
	
	public Map list(Map params) throws Exception;

	public Map del(Map params) throws Exception;
	
	public Map write_reserve(Map params) throws Exception;

	public Map modify_reserve(Map params) throws Exception;
	
	public Map write_bbs_reserve(Map params) throws Exception;

}
