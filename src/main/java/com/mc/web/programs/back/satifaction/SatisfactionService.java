package com.mc.web.programs.back.satifaction;

import java.io.IOException;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import jxl.write.WriteException;

public interface SatisfactionService{
	public Map estimate(Map params) throws Exception;
	public Map list(Map params) throws Exception;
	public Map etclist(Map params) throws Exception;
	public Map result(Map params) throws Exception;
	public void excel(Map<String, String> params, HttpServletResponse response) throws IOException, Exception;
	public void detail_execeldown(Map<String, String> params, HttpServletResponse response) throws IOException, Exception;
}
