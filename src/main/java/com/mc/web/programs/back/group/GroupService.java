package com.mc.web.programs.back.group;

import java.util.List;
import java.util.Map;

public interface GroupService{
	
	public List list(Map params) throws Exception;
	
	public Map view(Map params) throws Exception;
	
	public Map write(Map params) throws Exception;
	
	public Map modify(Map params) throws Exception;
	
	public Map del(Map params) throws Exception;
	
	public List staffList(Map params) throws Exception;
	
	public Map updateGroupStaff(Map params) throws Exception;
}