package com.mc.web.programs.front.preview.impl;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;

import com.mc.web.programs.front.preview.PreviewService;

import egovframework.com.cmm.util.EgovHttpRequestHelper;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service("PreviewService")
public class PreviewServiceImpl extends EgovAbstractServiceImpl implements PreviewService{

	public String preview(Map<String, String> params) {
		HttpServletRequest request = EgovHttpRequestHelper.getCurrentRequest();
		request.setAttribute("params", params);
		return "layout/lay"+params.get("layout")+"_preview";
	}
}