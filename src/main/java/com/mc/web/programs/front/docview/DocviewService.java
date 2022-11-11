package com.mc.web.programs.front.docview;

import java.io.IOException;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.apache.poi.openxml4j.exceptions.InvalidFormatException;


public interface DocviewService{

	public String preview(Map<String, String> params) throws IOException, InvalidFormatException;

	public void page(HttpServletResponse response, Map<String, String> params) throws IOException, InvalidFormatException;

}