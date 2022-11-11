package com.mc.web.programs.front.member.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mc.common.util.StringUtil;
import com.mc.web.JsonDAO;
import com.mc.web.MCMap;
import com.mc.web.common.MCDoubleSubmitHelper;
import com.mc.web.common.SessionInfo;
import com.mc.web.login.McUserLoginDAO;
import com.mc.web.programs.back.member.UserDAO;
import com.mc.web.programs.back.site.basic_setting.SiteBasicDAO;
import com.mc.web.programs.front.member.UserJoinDAO;
import com.mc.web.programs.front.member.UserJoinService;
import com.mc.web.service.EgovFileScrty;
import com.mc.web.service.Globals;

import egovframework.com.cmm.util.EgovHttpRequestHelper;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service("UserJoinService")
public class UserJoinServiceImpl extends EgovAbstractServiceImpl implements UserJoinService {
	
	@Autowired
	private UserJoinDAO dao;
	
	@Autowired
	private JsonDAO jsonDao;
	
	@Autowired
	private McUserLoginDAO loginDAO;
	
	@Autowired
	private UserDAO userDAO;
	
	@Autowired
	private SiteBasicDAO basicDAO;

	public String join_step2(Map params) throws Exception {
		HttpServletRequest request = EgovHttpRequestHelper.getCurrentRequest();
		request.setAttribute("basic_view", basicDAO.basic_view("1"));
		return "member/join_step2";
	}
	
	public String join(Map params) throws Exception {
		/* 기존 회원가입 코드
		HttpServletRequest request = EgovHttpRequestHelper.getCurrentRequest();
		HttpSession session = EgovHttpRequestHelper.getCurrentSession();
		MCMap member = (MCMap) session.getAttribute("member");
		if(member != null){
			request.setAttribute("message", "이미 로그인 되어있습니다.");
			return "message";
		}
		
		params.put("code_group_seq", "1");
		request.setAttribute("tel1", jsonDao.getList("Code.codeList", params));
		params.put("code_group_seq", "2");
		request.setAttribute("cell1", jsonDao.getList("Code.codeList", params));
		params.put("code_group_seq", "3");
		request.setAttribute("email2", jsonDao.getList("Code.codeList", params));
		return "member/join";
		*/
		return "programs/member/join";
	}
	
	public String joinProc(Map<String, String> params) throws Exception {
		HttpServletRequest request = EgovHttpRequestHelper.getCurrentRequest();
		if (MCDoubleSubmitHelper.checkAndSaveToken(params)) {//글 이중 등록 방지  
			
			if(!StringUtil.isEmpty((String)params.get("tel1")) && !StringUtil.isEmpty((String)params.get("tel2")) && !StringUtil.isEmpty((String)params.get("tel3"))){
				params.put("tel", params.get("tel1")+"-"+params.get("tel2")+"-"+params.get("tel3"));
			}
			if(!StringUtil.isEmpty((String)params.get("cell1")) && !StringUtil.isEmpty((String)params.get("cell2")) && !StringUtil.isEmpty((String)params.get("cell3"))){
				params.put("cell", params.get("cell1")+"-"+params.get("cell2")+"-"+params.get("cell3"));
			}
			if(!StringUtil.isEmpty((String)params.get("email1")) && !StringUtil.isEmpty((String)params.get("email2"))){
				params.put("email", params.get("email1")+"@"+params.get("email2"));
			}
			
			String url = request.getHeader("referer");
		    String[] site = url.split("/");
			request.setAttribute("site", site[3]);
			
			params.put("group_seq", "1");
			params.put("member_pw", EgovFileScrty.encryptPassword(params.get("member_pw"), Globals.SALT_KEY));
			dao.joinProc(params);
			return "member/join_success";
	    }else{
	    	request.setAttribute("message", "만료된 페이지입니다.");
			return "message";
	    }
	}
	
	public String modifyStep1(Map params) throws Exception {
		HttpServletRequest request = EgovHttpRequestHelper.getCurrentRequest();
		return "member/modify_step1";
	}
	
	public String modifyForm(Map params) throws Exception {
		HttpServletRequest request = EgovHttpRequestHelper.getCurrentRequest();
		HttpSession session = EgovHttpRequestHelper.getCurrentSession();
		MCMap member = (MCMap) session.getAttribute("member");
		if(member != null){
			params.put("member_id", member.getStrNull("member_id"));
			params.put("member_pw", EgovFileScrty.encryptPassword((String)params.get("member_pw"), Globals.SALT_KEY));
		}else{
			request.setAttribute("message", "로그인이 필요한 메뉴입니다.");
			request.setAttribute("redirect", "/lay1/program/S1T2C4/member/login.do");
			return "message";
		}
		
		MCMap view = dao.view(params);
		if(view == null) {
			request.setAttribute("message", "패스워드를 확인하여 주시기 바랍니다.");
			return "message";
		}
		
		request.setAttribute("view", view);
		
		params.put("code_group_seq", "1");
		request.setAttribute("tel1", jsonDao.getList("Code.codeList", params));
		params.put("code_group_seq", "2");
		request.setAttribute("cell1", jsonDao.getList("Code.codeList", params));
		params.put("code_group_seq", "3");
		request.setAttribute("email2", jsonDao.getList("Code.codeList", params));
		return "member/modify";
	}
	
	public String modifyProc(Map<String, String> params) throws Exception {
		HttpServletRequest request = EgovHttpRequestHelper.getCurrentRequest();
		if (MCDoubleSubmitHelper.checkAndSaveToken(params)) {//글 이중 등록 방지  
			SessionInfo.userSessionAuth(params);			
			if(!StringUtil.isEmpty((String)params.get("tel1")) && !StringUtil.isEmpty((String)params.get("tel2")) && !StringUtil.isEmpty((String)params.get("tel3"))){
				params.put("tel", params.get("tel1")+"-"+params.get("tel2")+"-"+params.get("tel3"));
			}
			if(!StringUtil.isEmpty((String)params.get("cell1")) && !StringUtil.isEmpty((String)params.get("cell2")) && !StringUtil.isEmpty((String)params.get("cell3"))){
				params.put("cell", params.get("cell1")+"-"+params.get("cell2")+"-"+params.get("cell3"));
			}
			if(!StringUtil.isEmpty((String)params.get("email1")) && !StringUtil.isEmpty((String)params.get("email2"))){
				params.put("email", params.get("email1")+"@"+params.get("email2"));
			}

			//비밀번호 입력시에만 적용
			if("".equals(params.get("member_pw")) == false) {
				params.put("member_pw", EgovFileScrty.encryptPassword(params.get("member_pw"), Globals.SALT_KEY));
			}
			
			dao.modifyProc(params);
	    	request.setAttribute("message", "정상 처리되었습니다.");
	    	
	    	String url = request.getHeader("referer");
		    String[] site = url.split("/");
		    String returnUrl = "/";
		    if(site.length > 0) {
		    	returnUrl = "/"+site[3]+"/index.do";
		    }
			request.setAttribute("redirect", returnUrl);
	    	
			return "message";
		}else{
			request.setAttribute("message", "만료된 페이지입니다.");
			return "message";
		}
	}
	
	public String change_pw(Map<String, String> params) throws Exception {
		HttpServletRequest request = EgovHttpRequestHelper.getCurrentRequest();
		if (MCDoubleSubmitHelper.checkAndSaveToken(params)) {//글 이중 등록 방지  
			params.put("member_pw", EgovFileScrty.encryptPassword(params.get("member_pw"), Globals.SALT_KEY));
			params.put("session_member_id", params.get("member_id"));
			params.put("session_member_nm", params.get("member_nm"));
			int i = userDAO.init_pw(params);
			if(i>0){
				request.setAttribute("message", "비밀번호가 변경되었습니다.\\n다시 로그인해주세요.");
				request.setAttribute("redirect", "/");
			}else{
				request.setAttribute("message", "실패하였습니다.");
			}
		}else{
			request.setAttribute("message", "만료된 페이지입니다.");
		}
		return "message";
	}
	
	public Map modify_pw(Map<String, String> params) throws Exception {
		Map rst = new HashMap();
		Map p = new HashMap();
		p.put("member_id", params.get("member_id"));
		p.put("member_pw", EgovFileScrty.encryptPassword(params.get("current_pw"), Globals.SALT_KEY));
		MCMap member = loginDAO.getMemberByIdPw(p);
		if(StringUtil.isEmptyByParam(params, "member_pw")){
			rst.put("rst", "X");
			rst.put("msg", "새로운비밀번호를 입력하여 주시기 바랍니다.");
		}else if(member==null){
			rst.put("rst", "X");
			rst.put("msg", "기존 비밀번호를 확인하여 주시기 바랍니다.");
		}else{
			params.put("session_member_id", member.getStr("session_member_id"));
			params.put("session_member_nm", member.getStr("session_member_nm"));
			params.put("member_pw", EgovFileScrty.encryptPassword(params.get("member_pw"), Globals.SALT_KEY));
			int i = userDAO.init_pw(params);
			if(i>0){
				rst.put("rst", "Y");
			}else{
				rst.put("rst", "X");
				rst.put("msg", "관리자에게 문의하여 주시기 바랍니다.");
			}
		}
		return rst;
	}
	
	public Map id_check(Map<String, String> params) throws Exception {
		Map rst = new HashMap();
		int cnt = userDAO.getMemberIdCnt(params).getIntNullVal("cnt", 1);
		String retrnVal = "";
		if( cnt  > 0 ) {//중복
			retrnVal = "Y";
		} else {
			retrnVal =  "N";
		}
		rst.put("rst", retrnVal);
		return rst;
	}
	
	public Map niceDIChk(Map<String, String> params) throws Exception {
		Map rst = new HashMap();
		int cnt = dao.niceDIChk(params);
		String retrnVal = "";
		if( cnt  > 0 ) {//중복
			retrnVal = "Y";
		} else {
			retrnVal =  "N";
		}
		rst.put("rst", retrnVal);
		return rst;
	}
	
	public Map getDiMember(Map params) throws Exception {
		Map rst = new HashMap();
		MCMap map = dao.getDiMember(params);
		if(map!=null){
			rst.put("rst", "Y");
			rst.put("info", map);
		}else{
			rst.put("rst", "N");
		}
		return rst;
	}

	@Override
	public String leavePage(Map<String, String> params) throws Exception {
		return "/member/leave";
	}

	@Override
	public String leaveProc(Map<String, String> params) throws Exception {
		HttpServletRequest request = EgovHttpRequestHelper.getCurrentRequest();
		HttpSession session = EgovHttpRequestHelper.getCurrentSession();
		MCMap smember = (MCMap) session.getAttribute("member");
		if(smember == null){
			request.setAttribute("message", "잘못된 접근입니다.");
			return "message";
		}else{
			params.put("member_id", smember.getStrNull("member_id"));
			params.put("member_pw", EgovFileScrty.encryptPassword(params.get("current_pw"), Globals.SALT_KEY));
			Map member = loginDAO.getMemberByIdPw(params);
			if(member!=null){
				params.put("session_member_id", smember.getStr("member_id"));
				params.put("session_member_nm", smember.getStr("member_nm"));
				userDAO.leave(params);
				request.setAttribute("message", "그동안 이용해주셔서 감사합니다.");
				request.setAttribute("redirect", "/");
				session.invalidate();
				return "message";
			}else{
				request.setAttribute("message", "비밀번호를 다시 확인하여주시기 바랍니다.");
				return "message";
			}
		}
	}
	
	@Override
	public String id_search(Map params) throws Exception {
		HttpServletRequest request = EgovHttpRequestHelper.getCurrentRequest();
		HttpSession session = EgovHttpRequestHelper.getCurrentSession();

		MCMap member = (MCMap) session.getAttribute("member");
		if(member != null){
			request.setAttribute("message", "이미 로그인 되어있습니다.");
			request.setAttribute("redirect", "/");
			return "message";
		} else {
			params.put("code_group_seq", "2");
			request.setAttribute("cell1", jsonDao.getList("Code.codeList", params));
			params.put("code_group_seq", "3");
			request.setAttribute("email2", jsonDao.getList("Code.codeList", params));
		}
		
		return "member/id_search";
	}
	
	@Override
	public String id_find(Map params) throws Exception {
		HttpServletRequest request = EgovHttpRequestHelper.getCurrentRequest();
		Map member = dao.getMemberByNameEmail(params);
		if(member != null) {
			params.put("result", "1");
			request.setAttribute("member_id", member.get("member_id").toString().replaceAll(".{3}$", "***"));
			return "/member/id_search_ok";
		} else {
			params.put("result", "0"); // 휴대전화 번호가 일치하지 않습니다.
			return "/member/id_search_fail";
		}
	}
	
	@Override
	public String pw_search(Map params) throws Exception {
		HttpServletRequest request = EgovHttpRequestHelper.getCurrentRequest();
		HttpSession session = EgovHttpRequestHelper.getCurrentSession();

		MCMap member = (MCMap) session.getAttribute("member");
		if(member != null){
			request.setAttribute("message", "이미 로그인 되어있습니다.");
			request.setAttribute("redirect", "/");
			return "message";
		} else {
			params.put("code_group_seq", "3");
			request.setAttribute("email2", jsonDao.getList("Code.codeList", params));
			return "/member/pw_search";
		}
	}
	
	@Override
	public String pw_find(Map params) throws Exception {
		HttpServletRequest request = EgovHttpRequestHelper.getCurrentRequest();
		Map member = dao.getMemberByIdEmail(params);
		if(member != null) { // 아이디 존재x
			return "member/pw_search_ok";
		} else if(member == null) { // 아이디 존재x
			request.setAttribute("message", "존재하지 않는 아이디 입니다. 아이디를 확인해주세요.");
			return "/member/pw_search_fail";
		} else if(member.get("del_yn").equals("Y")) { //삭제여부
			request.setAttribute("message", "탈퇴한 아이디입니다.");
			return "/member/pw_search_fail";
		} else {
			request.setAttribute("message", "관리자에게 문의하세요.");
			return "/member/pw_search_fail";
		}
	}

	@Override
	public String login(Map params) throws Exception {
		return "/programs/member/login";
	}

}