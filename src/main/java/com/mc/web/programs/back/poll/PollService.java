package com.mc.web.programs.back.poll;

import java.util.Map;

import javax.servlet.http.HttpServletResponse;

public interface PollService {
	
	public Map list(Map<String, String> params) throws Exception;

	public Map write(Map<String, Object> params) throws Exception;

	public Map view(Map<String, String> params) throws Exception;

	public Map modify(Map<String, Object> params) throws Exception;

	public Map resultInit(Map<String, String> params) throws Exception;

	public Map result(Map<String, String> params) throws Exception;

	public Map resultDetail(Map<String, String> params) throws Exception;

	public void resultExcel(Map<String, String> params, HttpServletResponse response) throws Exception;
	
	public Map delete(Map params) throws Exception;

}
