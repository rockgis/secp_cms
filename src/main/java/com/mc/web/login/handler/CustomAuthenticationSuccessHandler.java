package com.mc.web.login.handler;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.DefaultRedirectStrategy;
import org.springframework.security.web.RedirectStrategy;
import org.springframework.security.web.WebAttributes;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.savedrequest.HttpSessionRequestCache;
import org.springframework.security.web.savedrequest.RequestCache;
import org.springframework.security.web.savedrequest.SavedRequest;
import org.springframework.util.StringUtils;

import com.mc.web.MCMap;
import com.mc.web.programs.back.site.basic_setting.SiteBasicDAO;
import com.mc.web.common.CookieBox;

import egovframework.com.cmm.util.EgovHttpRequestHelper;
 
public class CustomAuthenticationSuccessHandler implements AuthenticationSuccessHandler {
	@Autowired
	private SiteBasicDAO basicDAO;
     
    private RequestCache requestCache = new HttpSessionRequestCache();
     
    private String targetUrlParameter;
     
    private String defaultUrl;
     
    private boolean useReferer;
     
    private RedirectStrategy redirectStrategy = new DefaultRedirectStrategy();
     
    public CustomAuthenticationSuccessHandler(){
        targetUrlParameter = "";
        defaultUrl = "/";
        useReferer = false;
    }
     
    public String getTargetUrlParameter() {
        return targetUrlParameter;
    }
 
 
 
    public void setTargetUrlParameter(String targetUrlParameter) {
        this.targetUrlParameter = targetUrlParameter;
    }
 
 
 
    public String getDefaultUrl() {
        return defaultUrl;
    }
 
 
 
    public void setDefaultUrl(String defaultUrl) {
        this.defaultUrl = defaultUrl;
    }
 
 
 
    public boolean isUseReferer() {
        return useReferer;
    }
 
 
 
    public void setUseReferer(boolean useReferer) {
        this.useReferer = useReferer;
    }
 
 
 
    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication) throws IOException, ServletException {
        clearAuthenticationAttributes(request);
        HttpSession session = EgovHttpRequestHelper.getCurrentSession();
        MCMap member = null;
        String admin_yn = (String)request.getAttribute("admin_yn");
        if("Y".equals(admin_yn)){
            member = (MCMap) session.getAttribute("cms_member");
        }else{
            member = (MCMap) session.getAttribute("member");
        }
        
        //DB??? ?????????????????? ??????????????? ?????????
		MCMap basicMap = basicDAO.basic_view("1");
		if(basicMap!=null){
			if("Y".equals(admin_yn)){//?????????
				if(basicMap.getStrNullVal("adm_logout_time_yn", "N").equals("Y")){
					session.setMaxInactiveInterval(60 * basicMap.getIntNullVal("adm_logout_time", 10));
				}
				
				if("2".equals(member.getStrNull("group_seq"))) {	//?????????????????? ??????????????? ????????? ????????????
					Map p = new HashMap();
					p.put("session_group_seq", "2");
					p.put("session_member_id", member.getStr("member_id"));
					List<MCMap> site_list = basicDAO.site_list(p);
					Cookie cookie = null;
					if(site_list != null & site_list.size()>0) {
						cookie = CookieBox.createCookie("adh_menu_current_siteid", site_list.get(0).getStrNullVal("cms_menu_seq", "99999"), request.getServerName(), "/super", 365);
					}else {
						cookie = CookieBox.createCookie("adh_menu_current_siteid", "99999", request.getServerName(), "/super", 365);
					}
					response.addCookie(cookie);
				}
				
			}else{//?????????
				if(basicMap.getStrNullVal("logout_time_yn", "N").equals("Y")){
					session.setMaxInactiveInterval(60 * basicMap.getIntNullVal("logout_time", 10));
				}
			}
		}else{//?????? 10???
			request.getSession().setMaxInactiveInterval(60 * 10);
		}
		
//		request.getSession().setAttribute("login_success", "Y");//???????????? ???????????? ???????????? ????????? ??????
        int intRedirectStrategy = decideRedirectStrategy(request, response);
        switch(intRedirectStrategy){
        case 1:
            useTargetUrl(request, response);
            break;
        case 2:
            useSessionUrl(request, response);
            break;
        case 3:
            useRefererUrl(request, response);
            break;
        default:
            useDefaultUrl(request, response);
        }
    }
     
    private void clearAuthenticationAttributes(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
 
        if (session == null) {
            return;
        }
 
        session.removeAttribute(WebAttributes.AUTHENTICATION_EXCEPTION);
    }
     
    private void useTargetUrl(HttpServletRequest request, HttpServletResponse response) throws IOException{
        SavedRequest savedRequest = requestCache.getRequest(request, response);
        if(savedRequest != null){
            requestCache.removeRequest(request, response);
        }
        String targetUrl = request.getParameter(targetUrlParameter);
        if(targetUrl.indexOf("http")>-1){//???????????? ???????????? ???????????? ??????
        	targetUrl = "/";
        }
        redirectStrategy.sendRedirect(request, response, targetUrl);
    }
     
    private void useSessionUrl(HttpServletRequest request, HttpServletResponse response) throws IOException{
        SavedRequest savedRequest = requestCache.getRequest(request, response);
        String targetUrl = savedRequest.getRedirectUrl();
        redirectStrategy.sendRedirect(request, response, targetUrl);
    }
     
    private void useRefererUrl(HttpServletRequest request, HttpServletResponse response) throws IOException{
        String targetUrl = request.getHeader("REFERER");
        if(targetUrl.indexOf("http")>-1){//???????????? ???????????? ???????????? ??????
        	targetUrl = "/";
        }
        redirectStrategy.sendRedirect(request, response, targetUrl);
    }
     
    private void useDefaultUrl(HttpServletRequest request, HttpServletResponse response) throws IOException{
        redirectStrategy.sendRedirect(request, response, defaultUrl);
    }
     
    /**
     * ?????? ????????? ?????? URL??? redirect ????????? ????????????
     * ?????? ????????? targetUrlParameter ?????? ?????? URL??? ????????? ?????? ????????? 1??????
     * 1?????? URL??? ?????? ?????? Spring Security??? ????????? ????????? URL??? 2??????
     * 2?????? URL??? ?????? ?????? Request??? REFERER??? ???????????? ??? REFERER URL??? ????????? ?????? ??? URL??? 3??????
     * 3?????? URL??? ?????? ?????? Default URL??? 4????????? ??????
     * @param request
     * @param response
     * @return   1 : targetUrlParameter ?????? ?????? URL
     *            2 : Session??? ???????????? ?????? URL
     *            3 : referer ????????? ?????? url
     *            0 : default url
     */
    private int decideRedirectStrategy(HttpServletRequest request, HttpServletResponse response){
        int result = 0;
         
        SavedRequest savedRequest = requestCache.getRequest(request, response);
         
        if(!"".equals(targetUrlParameter)){
            String targetUrl = request.getParameter(targetUrlParameter);
            if(StringUtils.hasText(targetUrl)){
                result = 1;
            }else{
                if(savedRequest != null){
                    result = 2;
                }else{
                    String refererUrl = request.getHeader("REFERER");
                    if(useReferer && StringUtils.hasText(refererUrl)){
                        result = 3;
                    }else{
                        result = 0;
                    }
                }
            }
             
            return result;
        }
         
        if(savedRequest != null){
            result = 2;
            return result;
        }
         
        String refererUrl = request.getHeader("REFERER");
        if(useReferer && StringUtils.hasText(refererUrl)){
            result = 3;
        }else{
            result = 0;
        }
         
        return result;
    }
}