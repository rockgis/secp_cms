package com.mc.web.programs.back.permit;

import java.util.List;
import java.util.Map;

import com.mc.web.MCMap;

public interface PermitService{

	public Map list(Map params) throws Exception;
	public List menu_list(Map params) throws Exception;
	
	public Map view(Map params) throws Exception;

	public Map write(Map params) throws Exception;

	public Map modify(Map params) throws Exception;

	public Map del(Map params) throws Exception;
}
