package com.mc.web.programs.back.member_admin;

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
public class AdminUserController {
	
	@Autowired
	private AdminUserService service;
	
	@ResponseBody
	@RequestMapping("/super/member/id_check.do")
	public Map id_check(HttpServletRequest request, HttpSession session, @RequestParam Map<String, String> params) throws Exception{
		return service.id_check(params);
	}

	@ResponseBody
	@RequestMapping("/super/member/list.do")
	public Map index(@RequestParam Map<String, String> params, HttpServletRequest request, HttpSession session) throws Exception{
		return service.list(params);
	}

	@ResponseBody
	@RequestMapping("/super/member/view.do")
	public Map view(@RequestParam Map<String, String> params, HttpServletRequest request, HttpSession session) throws Exception{
		return service.view(params);
	}
	
	@ResponseBody
	@RequestMapping("/super/member/write.do")
	@Transactional(rollbackFor = { Exception.class })
	public Map write(HttpServletRequest request, HttpSession session, @RequestParam Map<String, Object> jsonObject) throws Exception{
		Map params = (JSONObject) JSONValue.parse((String)jsonObject.get("jData"));	//JSON으로 보내준 데이터를 사용
		return service.write(params);
	}
	
	@ResponseBody
	@RequestMapping("/super/member/modify.do")
	@Transactional(rollbackFor = { Exception.class })
	public Map modify(HttpServletRequest request, HttpSession session, @RequestParam Map<String, Object> jsonObject) throws Exception{
		Map params = (JSONObject) JSONValue.parse((String)jsonObject.get("jData"));	//JSON으로 보내준 데이터를 사용
		return service.modify(params);
	}
	
	@ResponseBody
	@RequestMapping("/super/member/init_pw.do")
	@Transactional(rollbackFor = { Exception.class })
	public Map init_pw(HttpServletRequest request, HttpSession session, @RequestParam Map<String, String> params) throws Exception{
		return service.init_pw(params);
	}
	
	@ResponseBody
	@RequestMapping("/super/member/pw_check.do")
	@Transactional(rollbackFor = { Exception.class })
	public Map pw_check(HttpServletRequest request, HttpSession session, @RequestParam Map<String, String> params) throws Exception{
		return service.pw_check(params);
	}
	
	@ResponseBody
	@RequestMapping("/super/member/modify_pw.do")
	@Transactional(rollbackFor = { Exception.class })
	public Map modify_pw(HttpServletRequest request, HttpSession session, @RequestParam Map<String, String> params) throws Exception{
		return service.modify_pw(params);
	}
	
	@ResponseBody
	@RequestMapping("/super/member/del.do")
	@Transactional(rollbackFor = { Exception.class })
	public Map del(HttpServletRequest request, HttpSession session, @RequestParam Map<String, String> params) throws Exception{
		return service.del(params);
	}
	
	@ResponseBody
	@RequestMapping("/super/member/updateGroup.do")
	@Transactional(rollbackFor = { Exception.class })
	public Map updateGroup(@RequestParam Map<String, Object> jsonObject, HttpServletRequest request, HttpSession session) throws Exception{
		Map params = (JSONObject) JSONValue.parse((String)jsonObject.get("jData"));	//JSON으로 보내준 데이터를 사용
		return service.updateGroup(params);
	}
	
	@ResponseBody
	@RequestMapping("/super/member/updateOrder.do")
	@Transactional(rollbackFor = { Exception.class })
	public Map updateOrder(@RequestParam Map<String, Object> jsonObject, HttpServletRequest request, HttpSession session) throws Exception{
		Map params = (JSONObject) JSONValue.parse((String)jsonObject.get("jData"));	//JSON으로 보내준 데이터를 사용
		return service.updateOrder(params);
	}
	
	@ResponseBody
	@RequestMapping("/super/member/site_list.do")
	public Map site_list(@RequestParam Map<String, String> params, HttpServletRequest request, HttpSession session) throws Exception{
		return service.site_list(params);
	}
	
	@ResponseBody
	@RequestMapping("/super/member/permission_list.do")
	public Map permission_list(@RequestParam Map<String, String> params, HttpServletRequest request, HttpSession session) throws Exception{
		return service.permission_list(params);
	}
	
	@ResponseBody
	@RequestMapping("/super/member/updatePermission.do")
	@Transactional(rollbackFor = { Exception.class })
	public Map updatePermission(@RequestParam Map<String, Object> jsonObject, HttpServletRequest request, HttpSession session) throws Exception{
		Map params = (JSONObject) JSONValue.parse((String)jsonObject.get("jData"));	//JSON으로 보내준 데이터를 사용
		return service.updatePermission(params);
	}
	
	@ResponseBody
	@RequestMapping("/super/member/staff.do")
	public Map staff(@RequestParam Map<String, String> params, HttpServletRequest request, HttpSession session) throws Exception{
		return service.staff(params);
	}
	
	@ResponseBody
	@RequestMapping("/super/member/staff_list.do")
	public Map staff_list(@RequestParam Map<String, String> params, HttpServletRequest request, HttpSession session) throws Exception{
		return service.staff_list(params);
	}
	
	@ResponseBody
	@RequestMapping("/super/member/updateStaff.do")
	@Transactional(rollbackFor = { Exception.class })
	public Map updateStaff(@RequestParam Map<String, Object> jsonObject, HttpServletRequest request, HttpSession session) throws Exception{
		Map params = (JSONObject) JSONValue.parse((String)jsonObject.get("jData"));	//JSON으로 보내준 데이터를 사용
		return service.updateStaff(params);
	}
	
	@ResponseBody
	@RequestMapping("/super/member/memberPermitList.do")
	public Map memberPermitList(@RequestParam Map<String, String> params, HttpServletRequest request, HttpSession session) throws Exception{
		return service.memberPermitList(params);
	}
	
	@ResponseBody
	@RequestMapping("/super/member/updateMemberPermission.do")
	@Transactional(rollbackFor = { Exception.class })
	public Map updateMemberPermission(@RequestParam Map<String, Object> jsonObject, HttpServletRequest request, HttpSession session) throws Exception{
		Map params = (JSONObject) JSONValue.parse((String)jsonObject.get("jData"));	//JSON으로 보내준 데이터를 사용
		return service.updateMemberPermission(params);
	}
	
	@ResponseBody
	@RequestMapping("/super/member/memberHistory.do")
	public Map memberHistory(@RequestParam Map<String, String> params, HttpServletRequest request, HttpSession session) throws Exception{
		return service.memberHistory(params);
	}
	
	/**
	 * 계정 잠금해제
	 * @param memberId
	 * @throws Exception
	 */
	@RequestMapping("/super/member/memberBlockInit.do")
	@ResponseBody
	public Map memberBlockInit (@RequestParam(value = "member_id") String memberId) throws Exception {
		return service.memberBlockInit(memberId);
	}
	
	/**
	 * 계정 활성화
	 * @param memberId
	 * @throws Exception
	 */
	@RequestMapping("/super/member/memberWakeup.do")
	@ResponseBody
	public Map memberWakeup (@RequestParam(value = "member_id") String memberId) throws Exception {
		return service.memberWakeup(memberId);
	}
	
	@ResponseBody
	@RequestMapping("/member/modify_pw_adm.do")	
	@Transactional(rollbackFor = { Exception.class })
	public Map modify_pw_adm(HttpServletRequest request, @RequestParam Map<String, String> params) throws Exception {
		return service.modify_pw_adm(params);
	}
	
	@RequestMapping("/member/dormancy_adm.do")	
	public String dormancy_adm(HttpServletRequest request, @RequestParam Map<String, String> params) throws Exception {
		return service.dormancy_adm(params);
	}
	
	@ResponseBody
	@RequestMapping(value="/member/dormancy_adm_init.do", method=RequestMethod.POST)
	@Transactional(rollbackFor = { Exception.class })
	public Map dormancy_adm_init(HttpServletRequest request, @RequestParam Map<String, String> params) throws Exception {
		return service.dormancy_adm_init(params);
	}
	
}
