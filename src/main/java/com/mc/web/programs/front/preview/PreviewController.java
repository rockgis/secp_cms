package com.mc.web.programs.front.preview;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

/**
 *
 * @Description : 관리자 컨텐츠 미리보기
 * @ClassName   : com.mc.web.preview.PreviewController.java
 * @author 오승택
 * @since 2015. 7. 2.
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
public class PreviewController {
	
	@Autowired
	private PreviewService service;

	@RequestMapping("/popup/preview.do")
	public String preview(HttpServletRequest request, HttpSession session, @RequestParam Map<String, String> params) throws Exception{
		return service.preview(params);
	}
	
}
