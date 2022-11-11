package com.mc.web.programs.back.ipcheck;

import java.util.List;
import java.util.Map;

import com.mc.web.MCMap;

public interface IpCheckService{

	public Map list(Map params) throws Exception;
	
	public MCMap view(Map params) throws Exception;

	public Map write(Map params) throws Exception;

	public Map modify(Map params) throws Exception;

	public Map del(Map params) throws Exception;
	
	public List<String> ipcheck() throws Exception;

}
