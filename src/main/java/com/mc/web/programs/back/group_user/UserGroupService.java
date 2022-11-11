package com.mc.web.programs.back.group_user;

import java.util.List;
import java.util.Map;

public interface UserGroupService{
	
	public List list(Map params) throws Exception;
	
	public Map view(Map params) throws Exception;
	
	public Map write(Map params) throws Exception;
	
	public Map modify(Map params) throws Exception;
	
	public Map del(Map params) throws Exception;
	
	public Map updateMenuGrant(Map params) throws Exception;
	
	public List menuGrantList(Map params) throws Exception;
}