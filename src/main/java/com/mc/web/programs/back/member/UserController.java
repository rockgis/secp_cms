package com.mc.web.programs.back.member;

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

/**
 * 
 * @Description : 관리자 회원관리
 * @ClassName   : com.mc.web.programs.back.member.UserController.java
 * @author 이창기
 * @since 2015. 6. 02.
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
public class UserController {
	
	@Autowired
	private UserService service;
	
	@ResponseBody
	@RequestMapping("/super/member_user/id_check.do")
	public Map id_check(HttpServletRequest request, HttpSession session,  @RequestParam Map<String, String> params) throws Exception{
		return service.id_check(params);
	}

	@ResponseBody
	@RequestMapping("/super/member_user/list.do")
	public Map index(@RequestParam Map<String, String> params, HttpServletRequest request, HttpSession session) throws Exception{
		return service.list(params);
	}

	@ResponseBody
	@RequestMapping("/super/member_user/view.do")
	public Map view(@RequestParam Map<String, String> params, HttpServletRequest request, HttpSession session) throws Exception{
		return service.view(params);
	}
	
	@ResponseBody
	@RequestMapping("/super/member_user/write.do")
	@Transactional(rollbackFor = { Exception.class })
	public Map write(HttpServletRequest request, HttpSession session,  @RequestParam Map<String, String> params) throws Exception{
		return service.write(params);
	}
	
	@ResponseBody
	@RequestMapping("/super/member_user/modify.do")
	@Transactional(rollbackFor = { Exception.class })
	public Map modify(HttpServletRequest request, HttpSession session,  @RequestParam Map<String, String> params) throws Exception{
		return service.modify(params);
	}
	
	@ResponseBody
	@RequestMapping("/super/member_user/init_pw.do")
	@Transactional(rollbackFor = { Exception.class })
	public Map init_pw(HttpServletRequest request, HttpSession session,  @RequestParam Map<String, String> params) throws Exception{
		return service.init_pw(params);
	}
	
	@ResponseBody
	@RequestMapping("/super/member_user/pw_check.do")
	@Transactional(rollbackFor = { Exception.class })
	public Map pw_check(HttpServletRequest request, HttpSession session,  @RequestParam Map<String, String> params) throws Exception{
		return service.pw_check(params);
	}
	
	@ResponseBody
	@RequestMapping("/super/member_user/modify_pw.do")
	@Transactional(rollbackFor = { Exception.class })
	public Map modify_pw(HttpServletRequest request, HttpSession session,  @RequestParam Map<String, String> params) throws Exception{
		return service.modify_pw(params);
	}
	
	@ResponseBody
	@RequestMapping(value="/super/member_user/del.do", method=RequestMethod.POST)
	@Transactional(rollbackFor = { Exception.class })
	public Map del(HttpServletRequest request, HttpSession session,  @RequestParam Map<String, String> params) throws Exception{
		return service.del(params);
	}
	
	@ResponseBody
	@RequestMapping(value="/super/member_user/leave.do", method=RequestMethod.POST)
	@Transactional(rollbackFor = { Exception.class })
	public Map leave(HttpServletRequest request, HttpSession session,  @RequestParam Map<String, String> params) throws Exception{
		return service.leave(params);
	}
	
	@ResponseBody
	@RequestMapping("/super/member_user/updateGroup.do")
	@Transactional(rollbackFor = { Exception.class })
	public Map updateGroup(@RequestParam Map<String, Object> jsonObject, HttpServletRequest request, HttpSession session) throws Exception{
		Map params = (JSONObject) JSONValue.parse((String)jsonObject.get("jData"));	//JSON으로 보내준 데이터를 사용
		return service.updateGroup(params);
	}
	
	@ResponseBody
	@RequestMapping("/super/member_user/updateOrder.do")
	@Transactional(rollbackFor = { Exception.class })
	public Map updateOrder(@RequestParam Map<String, Object> jsonObject, HttpServletRequest request, HttpSession session) throws Exception{
		Map params = (JSONObject) JSONValue.parse((String)jsonObject.get("jData"));	//JSON으로 보내준 데이터를 사용
		return service.updateOrder(params);
	}
	
	/**
	 * 계정 잠금해제
	 * @param memberId
	 * @throws Exception
	 */
	@RequestMapping("/super/member_user/memberBlockInit.do")
	@ResponseBody
	public void memberBlockInit (@RequestParam(value = "member_id") String memberId) throws Exception {
	    service.memberBlockInit(memberId);
	}
	
	/**
	 * 계정 활성화
	 * @param memberId
	 * @throws Exception
	 */
	@RequestMapping("/super/member_user/memberWakeup.do")
	@ResponseBody
	public void memberWakeup (@RequestParam(value = "member_id") String memberId) throws Exception {
		service.memberWakeup(memberId);
	}
	
	@ResponseBody
	@RequestMapping("/super/member_user/memberHistory.do")
	public Map memberHistory(@RequestParam Map<String, String> params, HttpServletRequest request, HttpSession session) throws Exception{
		return service.memberHistory(params);
	}
	
}
