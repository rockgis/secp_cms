package com.mc.web.programs.back.tracking;

import java.util.Map;

public interface TrackingService {

	public String insert(Map params);
	public Map list(Map params);
	public Map viewLog(Map params);
	public Map viewAuth(Map params);
	
}
