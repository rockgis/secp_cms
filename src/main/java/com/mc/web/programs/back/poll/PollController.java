package com.mc.web.programs.back.poll;

import java.io.OutputStream;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.json.simple.JSONValue;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mc.common.util.StringUtil;
import com.mc.web.MCMap;

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

@Controller
public class PollController {

	@Autowired
	private PollService service;
	
	@Autowired
	private PollDAO dao;
	
	@ResponseBody
	@RequestMapping("/super/homepage/poll/list.do")
	public Map list(@RequestParam Map<String, String> params) throws Exception {
		return service.list(params);
	}
	
	@ResponseBody
	@RequestMapping("/super/homepage/poll/write.do")
	public Map write(@RequestParam Map<String, Object> jsonObject) throws Exception {
		Map params = (JSONObject) JSONValue.parse((String)jsonObject.get("jData"));	//JSON으로 보내준 데이터를 사용
		return service.write(params);
	}
	
	@ResponseBody
	@RequestMapping("/super/homepage/poll/view.do")
	public Map view(@RequestParam Map<String, String> params) throws Exception {
		return service.view(params);
	}
	
	@ResponseBody
	@RequestMapping("/super/homepage/poll/modify.do")
	public Map modify(@RequestParam Map<String, Object> jsonObject) throws Exception {
		Map params = (JSONObject) JSONValue.parse((String)jsonObject.get("jData"));	//JSON으로 보내준 데이터를 사용
		return service.modify(params);
	}
	
	@ResponseBody
	@RequestMapping("/super/homepage/poll/resultInit.do")
	public Map resultInit(@RequestParam Map<String, String> params) throws Exception {
		return service.resultInit(params);
	}
	
	@ResponseBody
	@RequestMapping("/super/homepage/poll/result.do")
	public Map result(@RequestParam Map<String, String> params) throws Exception {
		return service.result(params);
	}
	
	@ResponseBody
	@RequestMapping("/super/homepage/poll/result_detail.do")
	public Map resultDetail(@RequestParam Map<String, String> params) throws Exception {
		return service.resultDetail(params);
	}
	
	@ResponseBody
	@Transactional(rollbackFor = { Exception.class })
	@RequestMapping("/super/homepage/poll/delete.do")
	public Map delete(HttpServletRequest request, @RequestParam Map<String, Object> params) throws Exception{
		return service.delete(params);
	}
	
	
	@RequestMapping("/super/homepage/poll/result_excel.do")
	public void resultExcel(HttpServletRequest request, HttpSession session,  @RequestParam Map<String, String> params, HttpServletResponse response) throws Exception{
		service.resultExcel(params,response);
	}
}