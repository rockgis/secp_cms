package com.mc.web.login.impl;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.session.SessionRegistry;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;

import com.mc.common.util.DateUtil;
import com.mc.common.util.RequestSnack;
import com.mc.common.util.StringUtil;
import com.mc.web.MCMap;
import com.mc.web.programs.back.site.basic_setting.SiteBasicDAO;
import com.mc.web.login.McUserLoginDAO;
import com.mc.web.login.McUserLoginService;
import com.mc.web.login.session.SessionInformationSupport;
import com.mc.web.service.EgovFileScrty;
import com.mc.web.service.Globals;

import egovframework.com.cmm.util.EgovHttpRequestHelper;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

public class McUserLoginServiceImpl extends EgovAbstractServiceImpl implements McUserLoginService{
	Logger logger = Logger.getLogger(this.getClass());
	 
	@Autowired
	private McUserLoginDAO dao;
	
	@Autowired
	private SiteBasicDAO basicDAO;

	@Autowired
	private SessionRegistry sessionRegistry;

	public String loginSuccess(Map<String, String> params) throws Exception {
		HttpServletRequest request = EgovHttpRequestHelper.getCurrentRequest();
		String url = request.getHeader("referer");
	    String[] site = url.split("/");
	    String returnUrl = "/";
	    if(site[3] != null) {
	    	if(site[3].equals("super")) {
	    		returnUrl = "/super/homepage/index.do";
	    	} else {
	    		returnUrl = "/"+site[3]+"/index.do";
	    	}
	    }
	    if(!StringUtil.isEmptyByParam(params, "redirectUrl")){
			return "redirect:"+params.get("redirectUrl");
	    }else{
			return "redirect:"+returnUrl;
	    }
	}
	
	public Map login(Map<String, String> params) throws Exception {
		params.put("member_pw", EgovFileScrty.encryptPassword(params.get("member_pw"), Globals.SALT_KEY));
		Map member = dao.getMemberByIdPw(params);
		return member;
	}

	@Override
	public String logout(Map params, HttpServletResponse response) throws Exception {
		HttpServletRequest request = EgovHttpRequestHelper.getCurrentRequest();
		HttpSession session = EgovHttpRequestHelper.getCurrentSession();
		 
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
	    if (auth != null){    
	        new SecurityContextLogoutHandler().logout(request, response, auth);
	        sessionRegistry.removeSessionInformation(session.getId());
	    }
	    
	    String url = request.getHeader("referer");
	    String[] site = url.split("/");
	    String returnUrl = "/";
	    if(site.length > 0) {
	    	returnUrl = "/"+site[3]+"/index.do";
	    }
	    
	    if(!StringUtil.isEmptyByParam(params, "redirectUrl")){
			return "redirect:"+params.get("redirectUrl");
	    }else{
			return "redirect:"+returnUrl;
	    }
	}

	@Override
	public String login_fail(Map<String, String> params) {
		return "/super/login/login_fail";
	}

	@Override
	public String login_duplicate(Map<String, String> params) {
		return "/super/login/login_duplicate";
	}
	
	@Override
	public Map check_id(Map<String, String> params) throws Exception {
		HttpServletRequest request = EgovHttpRequestHelper.getCurrentRequest();
		HttpSession session = EgovHttpRequestHelper.getCurrentSession();
		Map map = new HashMap();
		String member_pw = EgovFileScrty.encryptPassword(params.get("member_pw"), Globals.SALT_KEY);
		MCMap member = dao.getMemberById(params);
		if(member == null){//????????? ??????
			map.put("rst", "UX");
	        return map;
		}else if(member.getStrNullVal("member_pw", "").equals(member_pw)){//???????????? ??????
		    if ("Y".equals(member.get("block_yn"))) { // ????????? ?????? ?????? ???????????? ??????
		        map.put("rst", "B");
		        return map;
		    } 
		    if ("Y".equals(member.get("made_yn"))) { // ???????????? ??????????????? ????????? ??????
		        map.put("rst", "M");
		        return map;
		    } 
		    
		    /*
		     * 2021?????? ?????? ?????? ??? ???????????? ????????? ????????? ?????? ??????    
		     */
		    MCMap memberGroup = dao.getMemberByGroup(member);
			if(memberGroup.getStrNullVal("del_yn", "").equals("Y")) {
		        map.put("rst", "D");
		        return map;
			}else if(memberGroup.getStrNullVal("use_yn", "").equals("N")){
		        map.put("rst", "G");
		        return map;
			}
		    
			MCMap basicMap = basicDAO.basic_view("1");
			if(basicMap!=null){
				if("Y".equals(basicMap.getStrNull("pw_change_yn"))){//???????????? ?????? ???????????? ??????
					if(!"".equals(member.getStrNullVal("last_pw_dt", ""))){
						int last_pw_dt = Integer.parseInt(member.getDateFormat("last_pw_dt", "yyyy-MM-dd", "yyyyMMdd"));//????????? ???????????? ?????????
						int pw_change_cycle = Integer.parseInt(DateUtil.getCurrentDateBDay(basicMap.getIntNullVal("pw_change_cycle", 90)));//???????????? ?????????????????? ??? ??????
						
						if(!"done".equals(RequestSnack.getCookie(request, "advise_pw_later_"+params.get("member_id"))) && (last_pw_dt <= pw_change_cycle)){
							//???????????? ?????? ????????? ??????
					        map.put("rst", "P");
					        return map;
						}
					}
				}

				if(!"pass".equals((String)session.getAttribute("dormancy")) && "Y".equals(basicMap.getStrNull("dormancy_yn"))){//?????? ???????????? ???????????? ??????
					if ("Y".equals(member.get("dormancy_yn"))) { // ?????????????????????
				        map.put("rst", "J");
				        return map;
				    } 
				}
			}
				
	        SessionInformationSupport sessionInformationSupport = new SessionInformationSupport(sessionRegistry);
	        if(sessionInformationSupport.userExists(params.get("member_id"), "user")){//?????? ???????????? ???????????? ?????????.
	            map.put("rst", "Y");
	        }else{
	            map.put("rst", "N");
	        }
		}else{//???????????? ??????
		    dao.loginFailCntIncrease(params);
			map.put("fail_cnt", params.get("fail_cnt"));
			map.put("rst", "X");
		}
		return map;
	}
	
}