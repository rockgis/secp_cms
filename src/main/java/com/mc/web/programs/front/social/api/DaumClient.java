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
@RequestMapping("/daum.do")
public class DaumClient extends SocialAuthHttp{
	
	@Autowired
	private SnsAccountDAO dao;
	
	@RequestMapping(params="!mode")
	public String naver(HttpServletRequest request, HttpSession session) throws Exception {
		MCMap keyset = dao.view();
		String home_url = request.getScheme() + "://"
			    +  request.getServerName()
			    +  ((request.getServerPort()==80 || request.getScheme()=="https")?"":":"+request.getServerPort());
		String callback = URLEncoder.encode(home_url+"/daum.do?mode=callback", "UTF-8");

		// 상태 토큰으로 사용할 랜덤 문자열 생성
		String state = generateState();
		// 세션 또는 별도의 저장 공간에 상태 토큰을 저장
		session.setAttribute("state", state);
		String url = "https://apis.daum.net/oauth2/authorize?client_id="+keyset.getStrNull("daum_client_id")+"&response_type=code&redirect_uri="+callback+"&state="+state;
		return "redirect:" + url;
	}
	
	@RequestMapping(params="mode=callback")
	public String callBackUrl(HttpServletRequest request, HttpServletResponse response, HttpSession session, @RequestParam Map<String, String> params) throws Exception {
		MCMap keyset = dao.view();
		String state = (String) session.getAttribute("state");
        if(state.equals(params.get("state"))){
        	String accessTokenUrl = "https://apis.daum.net/oauth2/token";
        	Map param = new HashMap(); 
        	param.put("client_id", keyset.getStrNull("daum_client_id"));
        	param.put("client_secret", keyset.getStrNull("daum_client_secret"));
        	param.put("grant_type", "authorization_code");
        	param.put("code", params.get("code"));
        	String jsonStr = getHttpPost(accessTokenUrl, param);
        	JSONObject accessToken = JSONObject.fromObject(jsonStr);
        	
    		JSONObject jsonObject = JSONObject.fromObject(getHttpGet("https://apis.daum.net/user/v1/show.json?access_token="+accessToken.get("access_token")));    
    		
        	request.setAttribute("script", "window.opener.updateAccount();");
        	session.setAttribute("daum", jsonObject.get("result"));
        	
        	MCMap m = new MCMap();
        	m.put("main_sns_account", "daum");
        	m.put("user_id", jsonObject.getJSONObject("result").getString("id"));
        	m.put("name", jsonObject.getJSONObject("result").getString("nickname"));
        	m.put("profile_img", jsonObject.getJSONObject("result").getString("imagePath"));
        	session.setAttribute("social_session", m);
        	
        }else{
        	request.setAttribute("message", "인증오류");
        }
        request.setAttribute("redirect", "close");
		return "message";
	}

	@RequestMapping(params="mode=logout")
	public String logout(HttpServletRequest request, HttpSession session) throws Exception {
		session.removeAttribute("daum");
		request.setAttribute("redirect", "reloadclose");
		return "message";
	}

	public String generateState() {
		SecureRandom random = new SecureRandom();
		return new BigInteger(130, random).toString(32);
	}

}
