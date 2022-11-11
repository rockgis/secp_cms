package com.mc.web.programs.back.code;

import java.util.Map;

public interface CodeService {
	public Map list(Map params) throws Exception;
	
	public Map group_write(Map params) throws Exception;
	
	public Map group_modify(Map params) throws Exception;
	
	public Map code_write(Map params) throws Exception;
	
	public Map code_modify(Map params) throws Exception;

	public Map updateCodeOrderSeq(Map params) throws Exception;
	
	public Map group_del(Map params) throws Exception;
	
	public Map code_del(Map params) throws Exception;
}