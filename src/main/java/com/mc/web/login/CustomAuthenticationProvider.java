package com.mc.web.login;

import com.mc.web.MCMap;
import com.mc.web.programs.back.site.basic_setting.SiteBasicDAO;
import egovframework.com.cmm.util.EgovHttpRequestHelper;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

 
public class CustomAuthenticationProvider implements AuthenticationProvider { 
	Logger logger = Logger.getLogger(this.getClass());
    
	@Autowired
	private McAdminLoginService mcAdminLoginService;
	
	@Autowired
	private McUserLoginService mcUserLoginService;
	
	@Autowired
	private McAdminLoginDAO mcAdminLoginDAO;
	
	@Autowired
	private McUserLoginDAO mcUserLoginDAO;
	
	@Autowired(required = false)
    private HttpServletRequest request;

	@Autowired
	private SiteBasicDAO basicDAO;
	
    @Override
    public boolean supports(Class<?> authentication) {
        return authentication.equals(UsernamePasswordAuthenticationToken.class);
    }

    @Override
    public Authentication authenticate(Authentication authentication) throws AuthenticationException {
         
        String member_id = request.getParameter("member_id");
        String member_pw = request.getParameter("member_pw");
        
        String targetUrl = request.getHeader("REFERER");
        if(targetUrl.indexOf("/super/")>-1){//관리자 로그인
        	request.setAttribute("admin_yn", "Y");
            return AdminAuthentication(member_id, member_pw);
        }else{//사용자 로그인
        	request.setAttribute("admin_yn", "N");
            return UserAuthentication(member_id, member_pw);
        }
    }

	private Authentication AdminAuthentication(String member_id, String member_pw) {
		Map params = new HashMap();
		params.put("member_id", member_id);
		params.put("member_pw", member_pw);
		Map member = null;
		try {
			member = mcAdminLoginService.login(params);
		} catch (Exception e) {
			e.printStackTrace();
		}

		if(member != null && !"Y".equals(member.get("block_yn"))){
		    logger.info(member_id + "("+member.get("member_nm")+")님이 로그인 하였습니다.");
		    List<GrantedAuthority> roles = new ArrayList<GrantedAuthority>();
		    roles.add(new SimpleGrantedAuthority("ROLE_ADMIN"));
		    
		    Map save_map = new HashMap();
		    save_map.put("member_id", member_id);
		    save_map.put("member_nm", member.get("member_nm"));
		    save_map.put("group_seq", member.get("group_seq"));
			save_map.put("gubun", "admin");
		    UsernamePasswordAuthenticationToken result = new UsernamePasswordAuthenticationToken(save_map, member_pw, roles);
		    result.setDetails(new CustomUserDetails(member_id, member_pw));

		    mcAdminLoginDAO.loginFailCntInit(member_id);
		    mcAdminLoginDAO.updateMemberLastLogin(member);
			HttpSession session = EgovHttpRequestHelper.getCurrentSession();
			session.setAttribute("cms_member", member);
			//DB에 세션타임아웃 설정된경우 사용됨
			MCMap basicMap = basicDAO.basic_view("1");
			if(basicMap!=null) {
				if (basicMap.getStrNullVal("adm_logout_time_yn", "N").equals("Y")) {
					session.setMaxInactiveInterval(60 * basicMap.getIntNullVal("adm_logout_time", 10));
				}
			}
		    return result;         
		}else{
		    logger.info("사용자 크리덴셜 정보가 틀립니다. 에러가 발생합니다.");
		    throw new BadCredentialsException("Bad credentials");
		}
	}
	
	private Authentication UserAuthentication(String member_id, String member_pw) {
		Map params = new HashMap();
		params.put("member_id", member_id);
		params.put("member_pw", member_pw);
		Map member = null;
		try {
			member = mcUserLoginService.login(params);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		if(member != null && !"Y".equals(member.get("block_yn"))){
			logger.info(member_id + "("+member.get("member_nm")+")님이 로그인 하였습니다.");
			List<GrantedAuthority> roles = new ArrayList<GrantedAuthority>();
			roles.add(new SimpleGrantedAuthority("ROLE_USER"));
			
			Map save_map = new HashMap();
			save_map.put("member_id", member_id);
			save_map.put("member_nm", member.get("member_nm"));
			save_map.put("gubun", "user");
			UsernamePasswordAuthenticationToken result = new UsernamePasswordAuthenticationToken(save_map, member_pw, roles);
			result.setDetails(new CustomUserDetails(member_id, member_pw));
			
			mcUserLoginDAO.loginFailCntInit(member_id);
			mcUserLoginDAO.updateMemberLastLogin(member);
			HttpSession session = EgovHttpRequestHelper.getCurrentSession();
			session.setAttribute("member", member);

			//DB에 세션타임아웃 설정된경우 사용됨
			MCMap basicMap = basicDAO.basic_view("1");
			if(basicMap!=null) {
				if (basicMap.getStrNullVal("logout_time_yn", "N").equals("Y")) {
					session.setMaxInactiveInterval(60 * basicMap.getIntNullVal("logout_time", 10));
				}
			}
			return result;         
		}else{
			logger.info("사용자 크리덴셜 정보가 틀립니다. 에러가 발생합니다.");
			throw new BadCredentialsException("Bad credentials");
		}
	}
}