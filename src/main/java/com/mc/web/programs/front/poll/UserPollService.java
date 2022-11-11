package com.mc.web.programs.front.poll;

import java.util.Map;

public interface UserPollService {

	public String list(Map<String, String> params) throws Exception;
	
	public String joinForm(Map<String, String> params) throws Exception;
	
	public String join(Map<String, String> params) throws Exception;

	public String result(Map<String, String> params) throws Exception;
	
}
