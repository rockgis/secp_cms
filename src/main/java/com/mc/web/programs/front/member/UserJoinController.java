package com.mc.web.programs.front.member;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * 
 * @Description : 회원가입 
 * @ClassName   : com.mc.web.member.UserJoinController.java
 * @author 이창기
 * @since 2015. 6. 11.
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
public class UserJoinController {
	
	@Autowired
	private UserJoinService service;
	
	@RequestMapping("/member/join_step2.do")	
	public String join_step2(HttpServletRequest request, @RequestParam Map<String, String> params) throws Exception {
		return service.join_step2(params);
	}
	
	@RequestMapping("/member/join.do")	
	public String join(HttpServletRequest request, @RequestParam Map<String, String> params) throws Exception {
		return service.join(params);
	}

	@RequestMapping(value="/member/joinProc.do", method=RequestMethod.POST)
	public String joinProc(@RequestParam Map<String, String> params) throws Exception{
		return service.joinProc(params);
	}
	
	@RequestMapping(value="/member/modify.do", method=RequestMethod.GET)	
	public String modifyStep1(HttpServletRequest request, @RequestParam Map<String, String> params) throws Exception {
		return service.modifyStep1(params);
	}

	@RequestMapping(value="/member/modify.do", method=RequestMethod.POST)	
	public String modifyForm(HttpServletRequest request, @RequestParam Map<String, String> params) throws Exception {
		return service.modifyForm(params);
	}
	
	@RequestMapping("/member/modifyProc.do")	
	public String modifyProc(HttpServletRequest request, @RequestParam Map<String, String> params) throws Exception {
		return service.modifyProc(params);
	}
	
	@ResponseBody
	@RequestMapping("/member/modify_pw.do")	
	@Transactional(rollbackFor = { Exception.class })
	public Map modify_pw(HttpServletRequest request, @RequestParam Map<String, String> params) throws Exception {
		return service.modify_pw(params);
	}
	
	@ResponseBody
	@RequestMapping("/member/id_check.do")
	public Map id_check(HttpServletRequest request, HttpSession session,  @RequestParam Map<String, String> params) throws Exception{
		return service.id_check(params);
	}
	
	@ResponseBody
	@RequestMapping("/member/niceDIChk.do")	
	public Map niceDIChk(HttpServletRequest request, @RequestParam Map<String, String> params) throws Exception {
		return service.niceDIChk(params);
	}

	@ResponseBody
	@RequestMapping("/member/getDiMember.do")	
	public Map getDiMember(HttpServletRequest request, @RequestParam Map<String, String> params) throws Exception {
		return service.getDiMember(params);
	}
	
	@RequestMapping("/member/change_pw.do")	
	@Transactional(rollbackFor = { Exception.class })
	public String change_pw(HttpServletRequest request, @RequestParam Map<String, String> params) throws Exception {
		return service.change_pw(params);
	}

	@RequestMapping(value="/member/leave.do", method=RequestMethod.GET)
	public String leavePage(HttpServletRequest request, @RequestParam Map<String, String> params) throws Exception {
		return service.leavePage(params);
	}
	
	@RequestMapping(value="/member/leave.do", method=RequestMethod.POST)
	public String leaveProc(HttpServletRequest request, @RequestParam Map<String, String> params) throws Exception {
		return service.leaveProc(params);
	}
	
	@RequestMapping("/member/id_search.do")
	public String id_search(HttpServletRequest request, @RequestParam Map<String, String> params) throws Exception {
		return service.id_search(params);
	}
	
	@RequestMapping(value="/member/id_find.do", method=RequestMethod.POST)
	public String id_find(HttpServletRequest request, @RequestParam Map<String, String> params) throws Exception {
		return service.id_find(params);
	}
	
	@RequestMapping("/member/pw_search.do")
	public String pw_search(HttpServletRequest request, @RequestParam Map<String, String> params) throws Exception {
		return service.pw_search(params);
	}

	@RequestMapping(value="/member/pw_find.do", method=RequestMethod.POST)
	public String pw_find(HttpServletRequest request, @RequestParam Map<String, String> params) throws Exception {
		return service.pw_find(params);
	}
	
	@RequestMapping(value="/member/login.do", method=RequestMethod.GET)
	public String login(HttpServletRequest request, @RequestParam Map<String, String> params) throws Exception {
		return service.login(params);
	}
	
	/**
	 * 로그인
	 * @param session
	 * @param request
	 * @param params
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/member/user-login.do", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> userLogin(HttpSession session, HttpServletRequest request, @RequestParam Map<String, Object> params) throws Exception {
		//TODO: 임시 로그인
		Map<String, Object> map = new HashMap<String, Object>();
		
		String loginId = params.get("loginId") == null ? "" : params.get("loginId").toString();
		String pwd = params.get("pwd") == null ? "" : params.get("pwd").toString();
		if ("jaehoh".equals(loginId) && "1234qwer".equals(pwd)) {
			session.setAttribute("name", "황재호");
			session.setAttribute("id", "jaehoh");
			session.setAttribute("email", "jaehoh@mslk.co.kr");
			map.put("result", true);
		} else {
			map.put("result", false);
		}
		
		return map;
	}
	
	/**
	 * 로그아웃
	 * @param session
	 * @param request
	 * @param params
	 * @throws Exception
	 */
	@RequestMapping(value="/member/user-logout.do", method=RequestMethod.POST)
	@ResponseBody
	public void userLogout(HttpSession session, HttpServletRequest request, @RequestParam Map<String, Object> params) throws Exception {
		session.removeAttribute("id");
		session.removeAttribute("name");
		session.removeAttribute("email");
	}
	
	/**
	 * kcp 본인인증 실패 URL
	 * @param session
	 * @param request
	 * @param params
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/member/kcp-fail.do", method=RequestMethod.GET)
	public String kcpFail(HttpSession session, HttpServletRequest request, @RequestParam Map<String, Object> params) throws Exception {
		return "programs/member/kcpAuthFail";
	}
	
	/**
	 * kcp 본인인증 성공 URL
	 * @param session
	 * @param request
	 * @param params
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/member/kcp-success.do", method=RequestMethod.GET)
	public String kcpSuccess(HttpSession session, HttpServletRequest request, @RequestParam Map<String, Object> params) throws Exception {
		return "programs/member/kcpAuthSuccess";
	}
}
