package com.mc.web.programs.front.social.api;

import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.google.api.client.auth.oauth2.BearerToken;
import com.google.api.client.auth.oauth2.Credential;
import com.mc.web.MCMap;
import com.mc.web.programs.back.sns_account.SnsAccountDAO;

import net.sf.json.JSONObject;  

@Controller
@RequestMapping("/kakao.do")
public class KakaoClient extends SocialAuthHttp{
	
	@Autowired
	private SnsAccountDAO dao;
	
	@RequestMapping(params="!mode")
	public String naver(HttpServletRequest request, HttpSession session) throws Exception {
		MCMap keyset = dao.view();
		String home_url = request.getScheme() + "://"
			    +  request.getServerName()
				+  ((request.getServerPort()==80 || request.getScheme()=="https")?"":":"+request.getServerPort());
		String callback = URLEncoder.encode(home_url+"/kakao.do?mode=callback", "UTF-8");
		String url = "https://kauth.kakao.com/oauth/authorize?grant_type=authorization_code&client_id="+keyset.getStrNull("kao_client_id")+"&redirect_uri="+callback+"&response_type=code";
		return "redirect:" + url;
	}
	
	@RequestMapping(params="mode=callback")
	public String callBackUrl(HttpServletRequest request, HttpServletResponse response, HttpSession session, @RequestParam Map<String, String> params) throws Exception {
		MCMap keyset = dao.view();
		String accessTokenUrl = "https://kauth.kakao.com/oauth/token?grant_type=authorization_code&client_id="+keyset.getStrNull("kao_client_id")+"&code="+params.get("code");
    	String jsonStr = getHttpGet(accessTokenUrl);
    	JSONObject accessToken = JSONObject.fromObject(jsonStr);
    	session.setAttribute("kakaoAccessToken", accessToken);//엑세스토큰 저장
    	
    	Credential credential = new Credential(BearerToken.authorizationHeaderAccessMethod()).setAccessToken((String) accessToken.get("access_token"));

    	JSONObject jsonObject = JSONObject.fromObject(getHttpGet("https://kapi.kakao.com/v1/user/me", credential));
    	jsonObject.getJSONObject("properties").put("userid", jsonObject.getString("id"));
    	if(JSONObject.fromObject(getHttpGet("https://kapi.kakao.com/v1/api/story/isstoryuser", credential)).getBoolean("isStoryUser")){//카카오스토리 사용자
    		JSONObject storyJson = JSONObject.fromObject(getHttpGet("https://kapi.kakao.com/v1/api/story/profile", credential));
    		jsonObject.getJSONObject("properties").put("sns_link", storyJson.get("permalink"));
    	}
    	
        request.setAttribute("redirect", "close");
    	request.setAttribute("script", "window.opener.updateAccount();");
        session.setAttribute("kakao", jsonObject.getJSONObject("properties"));
    	
    	MCMap m = new MCMap();
    	m.put("main_sns_account", "kao");
    	m.put("user_id", jsonObject.getString("id"));
    	m.put("name", jsonObject.getJSONObject("properties").getString("nickname"));
    	m.put("profile_img", jsonObject.getJSONObject("properties").getString("thumbnail_image"));
    	session.setAttribute("social_session", m);
		return "message";
	}

	@RequestMapping(params="mode=logout")
	public String logout(HttpServletRequest request, HttpSession session) throws Exception {
		session.removeAttribute("kakao");
		request.setAttribute("redirect", "reloadclose");
		return "message";
	}
	
	public String postLink(JSONObject accessToken, Map map) throws Exception {
		Credential credential = new Credential(BearerToken.authorizationHeaderAccessMethod()).setAccessToken((String) accessToken.get("access_token"));
		
		JSONObject jsonObject = JSONObject.fromObject(getHttpGet("https://kapi.kakao.com/v1/api/story/linkinfo?url="+map.get("url"), credential));
		Map link_info = new HashMap();
		link_info.put("link_info", jsonObject);
		link_info.put("content", map.get("conts"));
		getHttpPost("https://kapi.kakao.com/v1/api/story/post/link", credential, link_info);
		return "ok";
	}

}
