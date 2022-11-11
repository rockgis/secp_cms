package com.mc.web.programs.back.popupzone;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

public interface PopupzoneService{

	public Map list(Map params) throws Exception;
	public Map view(Map params) throws Exception;
	public Map write(HttpServletRequest request, Map params) throws Exception;
	public Map modify(HttpServletRequest request, Map params) throws Exception;
	public Map del(Map params) throws Exception;
	public Map sort(Map params);
}