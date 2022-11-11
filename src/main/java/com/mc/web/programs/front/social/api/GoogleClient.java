package com.mc.web.programs.front.social.api;

import java.math.BigInteger;
import java.net.URLEncoder;
import java.security.SecureRandom;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.mc.web.MCMap;
import com.mc.web.programs.back.sns_account.SnsAccountDAO;

import net.sf.json.JSONObject;  

@Controller
@RequestMapping("/google.do")
public class GoogleClient extends SocialAuthHttp{
	
	@Autowired
	private SnsAccountDAO dao;
	
	private String redirect_url;
	
	@RequestMapping(params="!mode")
	public String naver(HttpServletRequest request, HttpSession session) throws Exception {
		MCMap keyset = dao.view();
		String home_url = request.getScheme() + "://"
			    +  request.getServerName()
			    +  ((request.getServerPort()==80 || request.getScheme()=="https")?"":":"+request.getServerPort());
		String callback = URLEncoder.encode(home_url+"/google.do?mode=callback", "UTF-8");
		redirect_url = home_url+"/google.do?mode=callback";
		String url = "https://accounts.google.com/o/oauth2/v2/auth?client_id="+keyset.getStrNull("google_client_id")+"&response_type=code&redirect_uri="+callback+"&scope=https://www.googleapis.com/auth/userinfo.profile&access_type=offline";
		return "redirect:" + url;
	}
	
	@RequestMapping(params="mode=callback")
	public String callBackUrl(HttpServletRequest request, HttpServletResponse response, HttpSession session, @RequestParam Map<String, String> params) throws Exception {
		MCMap keyset = dao.view();
    	String accessTokenUrl = "https://accounts.google.com/o/oauth2/token";
    	Map param = new HashMap(); 
    	param.put("code", params.get("code"));
    	param.put("client_id", keyset.getStrNull("google_client_id"));
    	param.put("client_secret", keyset.getStrNull("google_client_secret"));
    	param.put("grant_type", "authorization_code");
    	param.put("redirect_uri", redirect_url);
    	String jsonStr = getHttpPost(accessTokenUrl, param);
    	JSONObject accessToken = JSONObject.fromObject(jsonStr);
    	
		JSONObject jsonObject = JSONObject.fromObject(getHttpGet("https://www.googleapis.com/oauth2/v3/userinfo?access_token="+accessToken.get("access_token")));    
		
    	request.setAttribute("script", "window.opener.updateAccount();");
    	session.setAttribute("google", jsonObject.get("result"));
    	
    	MCMap m = new MCMap();
    	m.put("main_sns_account", "google");
    	m.put("user_id", jsonObject.getString("sub"));
    	m.put("name", jsonObject.getString("name"));
    	m.put("profile_img", jsonObject.getString("picture"));
    	session.setAttribute("social_session", m);
        request.setAttribute("redirect", "close");
		return "message";
	}

	@RequestMapping(params="mode=logout")
	public String logout(HttpServletRequest request, HttpSession session) throws Exception {
		session.removeAttribute("google");
		request.setAttribute("redirect", "reloadclose");
		return "message";
	}

	public String generateState() {
		SecureRandom random = new SecureRandom();
		return new BigInteger(130, random).toString(32);
	}

}
