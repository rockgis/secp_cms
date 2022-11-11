package com.mc.web.programs.back.bbs.C;

import java.util.List;
import java.util.Map;

import com.mc.web.programs.back.bbs.AdminBbsService;

public interface AdminBbsCService extends AdminBbsService{

	public List stateList(Map params) throws Exception;
}
