package com.mc.web.programs.front.docview;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

/**
 * 
 * @Description : 
 * @ClassName   : com.mc.web.docview.DocviewController.java
 * @author 이창기
 * @since 2015. 8. 7.
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
public class DocviewController {
	
	@Autowired
	private DocviewService service;

	@RequestMapping("/docview/preview.do")
	public String preview(HttpServletRequest request, HttpSession session, @RequestParam Map<String, String> params) throws Exception{
		return service.preview(params);
	}
	
	@RequestMapping("/docview/page.do")
	public void page(HttpServletResponse response, HttpSession session, @RequestParam Map<String, String> params) throws Exception{
		service.page(response, params);
	}
	
}
