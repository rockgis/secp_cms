package com.mc.web.programs.back.email;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.json.simple.JSONValue;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

/**
 * 
 * @Description : 
 * @ClassName   : com.mc.web.programs.back.email.ReportPgAdminController.java
 * @author 이창기
 * @since 2016. 12. 7.
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
public class EmailAdminController {
	
	@Autowired
	private EmailAdminService service;
	
	@ResponseBody
	@RequestMapping("/super/system/email/list.do")
	public Map list(@RequestParam Map<String, String> params) throws Exception{
		return service.list(params);
	}
	
	@ResponseBody
	@RequestMapping("/super/system/email/user_list.do")
	public Map user_list(@RequestParam Map<String, Object> params) throws Exception{
		return service.user_list(params);
	}
	
	@ResponseBody
	@RequestMapping(value="/super/system/email/write.do", method=RequestMethod.POST)
	@Transactional(rollbackFor = { Exception.class })
	public Map write(HttpServletRequest request, HttpSession session,  @RequestParam Map<String, String> params) throws Exception{
		return service.write(params);
	}
	
	@ResponseBody
	@RequestMapping("/super/system/email/view.do")
	public Map view(HttpServletRequest request, HttpSession session,  @RequestParam Map<String, String> params) throws Exception{
		return service.view(params);
	}
	
	@ResponseBody
	@RequestMapping(value="/super/system/email/modify.do", method=RequestMethod.POST)
	@Transactional(rollbackFor = { Exception.class })
	public Map modify(HttpServletRequest request, HttpSession session,  @RequestParam Map<String, String> params) throws Exception{
		return service.modify(params);
	}
	
	@ResponseBody
	@RequestMapping(value="/super/system/email/del.do", method=RequestMethod.POST)
	@Transactional(rollbackFor = { Exception.class })
	public Map del(HttpServletRequest request, HttpSession session,  @RequestParam Map<String, String> params) throws Exception{
		return service.del(params);
	}
	
	@ResponseBody
	@RequestMapping("/super/system/email/target_list.do")
	public Map target_list(@RequestParam Map<String, String> params) throws Exception{
		return service.target_list(params);
	}
	
	@ResponseBody
	@RequestMapping(value="/super/system/email/target_write.do", method=RequestMethod.POST)
	@Transactional(rollbackFor = { Exception.class })
	public Map target_write(HttpServletRequest request, HttpSession session,  @RequestParam Map<String, Object> jsonObject) throws Exception{
		Map params = (JSONObject) JSONValue.parse((String)jsonObject.get("jData"));	//JSON으로 보내준 데이터를 사용
		return service.target_write(params);
	}
	
	@ResponseBody
	@RequestMapping("/super/system/email/target_view.do")
	public Map target_view(HttpServletRequest request, HttpSession session,  @RequestParam Map<String, String> params) throws Exception{
		return service.target_view(params);
	}
	
	@ResponseBody
	@RequestMapping(value="/super/system/email/target_modify.do", method=RequestMethod.POST)
	@Transactional(rollbackFor = { Exception.class })
	public Map target_modify(HttpServletRequest request, HttpSession session,  @RequestParam Map<String, Object> jsonObject) throws Exception{
		Map params = (JSONObject) JSONValue.parse((String)jsonObject.get("jData"));	//JSON으로 보내준 데이터를 사용
		return service.target_modify(params);
	}
	
	@ResponseBody
	@RequestMapping(value="/super/system/email/target_del.do", method=RequestMethod.POST)
	@Transactional(rollbackFor = { Exception.class })
	public Map target_del(HttpServletRequest request, HttpSession session,  @RequestParam Map<String, String> params) throws Exception{
		return service.target_del(params);
	}
	
	@ResponseBody
	@RequestMapping("/super/system/email/queue_list.do")
	public Map queue_list(@RequestParam Map<String, String> params) throws Exception{
		return service.queue_list(params);
	}
	
	@ResponseBody
	@RequestMapping("/super/system/email/queue_update.do")
	@Transactional(rollbackFor = { Exception.class })
	public Map queue_update(@RequestParam Map<String, String> params) throws Exception{
		return service.queue_update(params);
	}
	
	@ResponseBody
	@RequestMapping("/super/system/email/form_list.do")
	public Map form_list(@RequestParam Map<String, String> params) throws Exception{
		return service.form_list(params);
	}
	
	@ResponseBody
	@RequestMapping(value="/super/system/email/form_write.do", method=RequestMethod.POST)
	@Transactional(rollbackFor = { Exception.class })
	public Map form_write(HttpServletRequest request, HttpSession session,  @RequestParam Map<String, String> params) throws Exception{
		return service.form_write(params);
	}
	
	@ResponseBody
	@RequestMapping("/super/system/email/form_view.do")
	public Map form_view(HttpServletRequest request, HttpSession session,  @RequestParam Map<String, String> params) throws Exception{
		return service.form_view(params);
	}
	
	@ResponseBody
	@RequestMapping(value="/super/system/email/form_modify.do", method=RequestMethod.POST)
	@Transactional(rollbackFor = { Exception.class })
	public Map form_modify(HttpServletRequest request, HttpSession session,  @RequestParam Map<String, String> params) throws Exception{
		return service.form_modify(params);
	}
	
	@ResponseBody
	@RequestMapping(value="/super/system/email/form_del.do", method=RequestMethod.POST)
	@Transactional(rollbackFor = { Exception.class })
	public Map form_del(HttpServletRequest request, HttpSession session,  @RequestParam Map<String, String> params) throws Exception{
		return service.form_del(params);
	}
	
	@ResponseBody
	@RequestMapping("/super/system/email/smtp_list.do")
	public Map smtp_list(@RequestParam Map<String, String> params) throws Exception{
		return service.smtp_list(params);
	}
	
	@ResponseBody
	@RequestMapping(value="/super/system/email/smtp_write.do", method=RequestMethod.POST)
	@Transactional(rollbackFor = { Exception.class })
	public Map smtp_write(HttpServletRequest request, HttpSession session,  @RequestParam Map<String, String> params) throws Exception{
		return service.smtp_write(params);
	}
	
	@ResponseBody
	@RequestMapping("/super/system/email/smtp_view.do")
	public Map smtp_view(HttpServletRequest request, HttpSession session,  @RequestParam Map<String, String> params) throws Exception{
		return service.smtp_view(params);
	}
	
	@ResponseBody
	@RequestMapping(value="/super/system/email/smtp_modify.do", method=RequestMethod.POST)
	@Transactional(rollbackFor = { Exception.class })
	public Map smtp_modify(HttpServletRequest request, HttpSession session,  @RequestParam Map<String, String> params) throws Exception{
		return service.smtp_modify(params);
	}
	
	@ResponseBody
	@RequestMapping(value="/super/system/email/smtp_del.do", method=RequestMethod.POST)
	@Transactional(rollbackFor = { Exception.class })
	public Map smtp_del(HttpServletRequest request, HttpSession session,  @RequestParam Map<String, String> params) throws Exception{
		return service.smtp_del(params);
	}
	
	@ResponseBody
	@RequestMapping("/super/system/email/targetExcelUpload.do")
	@Transactional(rollbackFor = { Exception.class })
	public Map targetExcelUpload(HttpServletRequest request, HttpSession session, @RequestParam Map<String, String> params, @RequestParam(value = "excelfile") MultipartFile excelfile) throws Exception{
		return service.targetExcelUpload(params, excelfile);
	}
	
	@ResponseBody
	@RequestMapping(value="/super/system/email/send_mail.do", method=RequestMethod.POST)
//	@Transactional(rollbackFor = { Exception.class })
	public Map send_mail(HttpServletRequest request, HttpSession session,  @RequestParam Map<String, String> params) throws Exception{
		return service.send_mail(params);
	}
	
	@ResponseBody
	@RequestMapping("/super/system/email/smtp_test.do")
	@Transactional(rollbackFor = { Exception.class })
	public Map smtp_test(HttpServletRequest request, HttpSession session,  @RequestParam Map<String, String> params) throws Exception{
		return service.smtp_test(params);
	}

	@ResponseBody
	@RequestMapping("/email/receive.do")
	public String receive(@RequestParam Map<String, String> params) throws Exception{
		return service.receive(params);
	}
	
}
