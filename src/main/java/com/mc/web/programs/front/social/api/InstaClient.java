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
@RequestMapping("/insta.do")
public class InstaClient extends SocialAuthHttp{
	
	@Autowired
	private SnsAccountDAO dao;
	
	private String redirect_url;
	
	@RequestMapping(params="!mode")
	public String naver(HttpServletRequest request, HttpSession session) throws Exception {
		MCMap keyset = dao.view();
		String home_url = request.getScheme() + "://"
			    +  request.getServerName()
			    +  ((request.getServerPort()==80 || request.getScheme()=="https")?"":":"+request.getServerPort());
		String callback = URLEncoder.encode(home_url+"/insta.do?mode=callback", "UTF-8");
		redirect_url = home_url+"/insta.do?mode=callback";
		String url = "https://www.instagram.com/oauth/authorize?client_id="+keyset.getStrNull("insta_client_id")+"&redirect_uri="+callback+"&response_type=code&scope=basic";
		return "redirect:" + url;
	}
	
	@RequestMapping(params="mode=callback")
	public String callBackUrl(HttpServletRequest request, HttpServletResponse response, HttpSession session, @RequestParam Map<String, String> params) throws Exception {
		MCMap keyset = dao.view();
    	String accessTokenUrl = "https://api.instagram.com/oauth/access_token";
    	Map param = new HashMap(); 
    	param.put("code", params.get("code"));
    	param.put("client_id", keyset.getStrNull("insta_client_id"));
    	param.put("client_secret", keyset.getStrNull("insta_client_secret"));
    	param.put("grant_type", "authorization_code");
    	param.put("redirect_uri", redirect_url);
    	String jsonStr = getHttpPost(accessTokenUrl, param);
    	JSONObject jsonObject = JSONObject.fromObject(jsonStr);
    	session.setAttribute("instaAccessToken", jsonObject.getString("access_token"));//엑세스토큰 저장
		
    	request.setAttribute("script", "window.opener.updateAccount();");
    	session.setAttribute("insta", jsonObject.get("result"));
    	
    	MCMap m = new MCMap();
    	m.put("main_sns_account", "insta");
    	m.put("user_id", jsonObject.getJSONObject("user").getString("id"));
    	m.put("name", jsonObject.getJSONObject("user").getString("username"));
    	m.put("profile_img", jsonObject.getJSONObject("user").getString("profile_picture"));
    	session.setAttribute("social_session", m);
        request.setAttribute("redirect", "close");
		return "message";
	}

	@RequestMapping(params="mode=logout")
	public String logout(HttpServletRequest request, HttpSession session) throws Exception {
		session.removeAttribute("insta");
		request.setAttribute("redirect", "reloadclose");
		return "message";
	}

	public String generateState() {
		SecureRandom random = new SecureRandom();
		return new BigInteger(130, random).toString(32);
	}

}
