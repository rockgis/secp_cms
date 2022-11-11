package com.mc.web.programs.back.sns_account;

import java.util.Map;

import com.mc.web.MCMap;

public interface SnsAccountService{
	public MCMap view() throws Exception;
	public Map modify(Map params) throws Exception;
}
