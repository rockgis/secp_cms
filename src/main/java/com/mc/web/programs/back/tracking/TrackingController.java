package com.mc.web.programs.back.tracking;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class TrackingController {
	
	@Autowired
	private TrackingService service;

	@ResponseBody
	@RequestMapping("/super/tracking.do")
	@Transactional(rollbackFor = { Exception.class })
	public String insert(@RequestParam Map params){
		return service.insert(params);
	}
	
	@ResponseBody
	@RequestMapping("/super/system/tracking/list.do")
	public Map list(@RequestParam Map params){
		return service.list(params);
	}
	
	@ResponseBody
	@RequestMapping("/super/system/tracking/viewLog.do")
	public Map viewLog(@RequestParam Map params){
		return service.viewLog(params);
	}
	
	@ResponseBody
	@RequestMapping("/super/system/tracking/viewAuth.do")
	public Map viewAuth(@RequestParam Map params){
		return service.viewAuth(params);
	}
}
