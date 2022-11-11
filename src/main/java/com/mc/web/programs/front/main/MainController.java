package com.mc.web.programs.front.main;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;


@Controller
public class MainController {
	Logger log = Logger.getLogger(this.getClass());
	
	@Autowired
	private MainService service;
	
	@RequestMapping(value="/web/index.do", method=RequestMethod.GET)	
	public String index(ModelMap model, HttpServletRequest request, HttpSession session, @RequestParam Map<String, String> params) throws Exception {
		return service.indexData();
	}
	
	@RequestMapping(value="/web2/index.do", method=RequestMethod.GET)	
	public String index2(ModelMap model, HttpServletRequest request, HttpSession session, @RequestParam Map<String, String> params) throws Exception {
		return service.indexData2();
	}
	
	/*@RequestMapping(value="/main.do", method=RequestMethod.GET)	
	public String main(ModelMap model, HttpServletRequest request, HttpSession session, @RequestParam Map<String, String> params) throws Exception {
		return service.main();
	}
	
	@RequestMapping(value="/main_board.do", method=RequestMethod.GET)	
	public String main_board(ModelMap model, HttpServletRequest request, HttpSession session, @RequestParam Map<String, String> params) throws Exception {
		return service.main_board(params);
	}*/
	
	//메인화면 롤링 - 필독공지사항 표시
	@ResponseBody
	@RequestMapping(value="/web/boardRlist.do", method=RequestMethod.GET)
	public Map boardRlist(@RequestParam Map<String, String> params, HttpServletRequest request) throws Exception{
		return service.boardRlist(params);
	}
}
