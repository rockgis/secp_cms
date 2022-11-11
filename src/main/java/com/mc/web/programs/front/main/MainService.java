package com.mc.web.programs.front.main;

import java.util.Map;

public interface MainService{

	public String indexData() throws Exception;
	public String indexData2() throws Exception;
	public String main() throws Exception;
	public String main_board(Map params) throws Exception;
	
	public Map boardRlist(Map params) throws Exception;
}