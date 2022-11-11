package com.mc.web.programs.back.satifaction;

import java.io.OutputStream;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import jxl.CellView;
import jxl.Workbook;
import jxl.format.Alignment;
import jxl.format.Border;
import jxl.format.BorderLineStyle;
import jxl.format.Colour;
import jxl.format.VerticalAlignment;
import jxl.write.Label;
import jxl.write.WritableCellFormat;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mc.common.util.StringUtil;
import com.mc.web.MCMap;

/**
 * 
 * @Description : 만족도 조사
 * @ClassName   : com.mc.web.programs.back.satifaction.SatifactionController.java
 * @author 이창기
 * @since 2015. 6. 24.
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
public class SatisfactionController {
	
	@Autowired
	private SatisfactionService service;

	@ResponseBody
	@RequestMapping(value="/satifaction/estimate.do", method=RequestMethod.POST)
	public Map estimate(@RequestParam Map<String, String> params, HttpServletRequest request, HttpSession session) throws Exception{
		return service.estimate(params);
	}
	
	@ResponseBody
	@RequestMapping("/super/satisfaction/list.do")
	@Transactional(rollbackFor = { Exception.class })
	public Map list(HttpServletRequest request, HttpSession session,  @RequestParam Map<String, String> params) throws Exception{
		return service.list(params);
	}
	
	@ResponseBody
	@RequestMapping("/super/satisfaction/etclist.do")
	public Map etclist(HttpServletRequest request, HttpSession session,  @RequestParam Map<String, String> params) throws Exception{
		return service.etclist(params);
	}
	
	@ResponseBody
	@RequestMapping("/super/satisfaction/result.do")
	public Map result(HttpServletRequest request, HttpSession session,  @RequestParam Map<String, String> params) throws Exception{
		return service.result(params);
	}
	
	@RequestMapping("/super/satisfaction/execeldown.do")
	public void excel(HttpServletRequest request, HttpSession session,  @RequestParam Map<String, String> params, HttpServletResponse response) throws Exception{
		service.excel(params, response);
	}
	
	@RequestMapping("/super/satisfaction/detail_execeldown.do")
	public void detail_execeldown(HttpServletRequest request, HttpSession session,  @RequestParam Map<String, String> params, HttpServletResponse response) throws Exception{
		service.detail_execeldown(params, response);
	}
	
}
