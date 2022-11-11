package com.mc.web.programs.front.social.api;

import java.math.BigInteger;
import java.net.URLEncoder;
import java.security.SecureRandom;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONValue;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.google.api.client.auth.oauth2.BearerToken;
import com.google.api.client.auth.oauth2.Credential;
import com.mc.web.MCMap;
import com.mc.web.programs.back.sns_account.SnsAccountDAO;

import net.sf.json.JSONObject;
import net.sf.json.xml.XMLSerializer;  

@Controller
@RequestMapping("/naver.do")
public class NaverClient extends SocialAuthHttp{
	
	@Autowired
	private SnsAccountDAO dao;
	
	@RequestMapping(params="!mode")
	public String naver(HttpServletRequest request, HttpSession session) throws Exception {
		MCMap keyset = dao.view();
		String home_url = request.getScheme() + "://"
			    +  request.getServerName()
			    +  ((request.getServerPort()==80 || request.getScheme()=="https")?"":":"+request.getServerPort());
		String callback = URLEncoder.encode(home_url+"/naver.do?mode=callback", "UTF-8");

		// 상태 토큰으로 사용할 랜덤 문자열 생성
		String state = generateState();
		// 세션 또는 별도의 저장 공간에 상태 토큰을 저장
		session.setAttribute("state", state);
		String url = "https://nid.naver.com/oauth2.0/authorize?client_id="+keyset.getStrNull("nav_client_id")+"&response_type=code&redirect_uri="+callback+"&state="+state;
		return "redirect:" + url;
	}
	
	@RequestMapping(params="mode=callback")
	public String callBackUrl(HttpServletRequest request, HttpServletResponse response, HttpSession session, @RequestParam Map<String, String> params) throws Exception {
		MCMap keyset = dao.view();
		String state = (String) session.getAttribute("state");
        if(state.equals(params.get("state"))){
        	String accessTokenUrl = "https://nid.naver.com/oauth2.0/token?client_id="+keyset.getStrNull("nav_client_id")+"&client_secret="+keyset.getStrNull("nav_client_secret")+"&grant_type=authorization_code&state="+state+"&code="+params.get("code");
        	String jsonStr = getHttpGet(accessTokenUrl);
        	JSONObject accessToken = JSONObject.fromObject(jsonStr);
        	
        	Credential credential = new Credential(BearerToken.authorizationHeaderAccessMethod()).setAccessToken((String) accessToken.get("access_token"));
    		String strJson = getHttpGet("https://openapi.naver.com/v1/nid/me", credential);
    		JSONObject jsonObject = JSONObject.fromObject(strJson);
    		
            request.setAttribute("redirect", "close");
        	request.setAttribute("script", "window.opener.updateAccount();");
        	session.setAttribute("naver", jsonObject.get("response"));
        	
        	MCMap m = new MCMap();
        	m.put("main_sns_account", "nav");
        	m.put("user_id", jsonObject.getJSONObject("response").getString("id"));
        	m.put("name", jsonObject.getJSONObject("response").getString("nickname"));
        	m.put("profile_img", jsonObject.getJSONObject("response").getString("profile_image"));
        	session.setAttribute("social_session", m);
        	
        }else{
        	request.setAttribute("message", "인증오류");
        }
        request.setAttribute("redirect", "close");
		return "message";
	}

	@RequestMapping(params="mode=logout")
	public String logout(HttpServletRequest request, HttpSession session) throws Exception {
		session.removeAttribute("naver");
		request.setAttribute("redirect", "reloadclose");
		return "message";
	}

	public String generateState() {
		SecureRandom random = new SecureRandom();
		return new BigInteger(130, random).toString(32);
	}

}
