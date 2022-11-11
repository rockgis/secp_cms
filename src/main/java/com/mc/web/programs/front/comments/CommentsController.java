package com.mc.web.programs.front.comments;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
/**
 * 
 * @Description : 
 * @ClassName   : com.mc.web.comments.CommentsController.java
 * @author 이창기
 * @since 2015. 10. 12.
 * @version 1.0 *
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일        수정자       수정내용
 *  -------       --------    ---------------------------
 * </pre>
 */
@Controller
public class CommentsController {
	
	Logger log = Logger.getLogger(this.getClass());
	
	@Autowired
	private CommentsService service;
	
	@RequestMapping("/comments/sns_box.do")
	public String sns_box(HttpServletRequest request, HttpSession session, @RequestParam Map<String, String> params) throws Exception{
		return service.sns_box(params);
	}
	
	@RequestMapping("/comment_list.do")
	public String comment_list(HttpServletRequest request, HttpSession session, @RequestParam Map<String, String> params) throws Exception{
		return service.list(params);
	}
	
	@ResponseBody
	@RequestMapping("/comment_reg.do")
	public Map comment_reg(@RequestParam Map<String, String> params) throws Exception {
		return service.comment_reg(params);
	}
	
	@ResponseBody
	@RequestMapping("/re_comment_reg.do")
	public Map re_comment_reg(@RequestParam Map<String, String> params) throws Exception {
		return service.re_comment_reg(params);
	}
	
	@ResponseBody
	@RequestMapping("/comment_mod.do")
	public Map comment_mod(@RequestParam Map<String, String> params) throws Exception {
		return service.comment_mod(params);
	}
	
	@ResponseBody
	@RequestMapping("/comment_del.do")
	public Map comment_del(@RequestParam Map<String, String> params) throws Exception {
		return service.del(params);
	}
}
