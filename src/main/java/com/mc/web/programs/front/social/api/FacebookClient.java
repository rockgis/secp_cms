package com.mc.web.programs.front.social.api;

import java.net.URLEncoder;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.mc.web.MCMap;
import com.mc.web.programs.back.sns_account.SnsAccountDAO;

import net.sf.json.JSONObject;

@Controller
@RequestMapping("/facebook.do")
public class FacebookClient extends SocialAuthHttp{
	protected final Logger logger = Logger.getLogger( this.getClass() );
	
	@Autowired
	private SnsAccountDAO dao;
	
	@RequestMapping(params="!mode")
	public String facebook(HttpServletRequest request, HttpSession session) throws Exception {
		MCMap keyset = dao.view();
		
		String home_url = request.getScheme() + "://"
			    +  request.getServerName()
			    +  ((request.getServerPort()==80 || request.getScheme()=="https")?"":":"+request.getServerPort());
		String callback = URLEncoder.encode(home_url+"/facebook.do?mode=callback", "UTF-8");
		String scope = "public_profile,publish_actions";
		String url = "https://www.facebook.com/dialog/oauth?client_id="+keyset.getStrNull("face_appid")+"&redirect_uri="+callback+"&scope="+scope;
		return "redirect:" + url;
		
	}

	@RequestMapping(params="mode=logout")
	public String logout(HttpServletRequest request, HttpSession session) throws Exception {
		session.removeAttribute("facebook");
		request.setAttribute("redirect", "reloadclose");
		return "message";
	}

	@RequestMapping(params="mode=callback")
	public String callBackUrl(HttpServletRequest request, HttpServletResponse response, HttpSession session, @RequestParam Map<String, String> params) throws Exception {
		MCMap keyset = dao.view();
		
		String home_url = request.getScheme() + "://"
			    +  request.getServerName()
			    +  ((request.getServerPort()==80 || request.getScheme()=="https")?"":":"+request.getServerPort());
		String callback = URLEncoder.encode(home_url+"/facebook.do?mode=callback", "UTF-8");
    	String accessTokenUrl = "https://graph.facebook.com/v2.5/oauth/access_token?client_id="+keyset.getStrNull("face_appid")+"&client_secret="+keyset.getStrNull("face_app_secret")+"&redirect_uri="+callback+"&code="+params.get("code");
    	JSONObject accessToken = JSONObject.fromObject(getHttpGet(accessTokenUrl));
    	
		JSONObject jsonObject = JSONObject.fromObject(getHttpGet("https://graph.facebook.com/v2.5/me/?fields=picture,name&access_token="+accessToken.getString("access_token")));    

    	session.setAttribute("facebookAccessToken", accessToken.getString("access_token"));//엑세스토큰 저장
    	request.setAttribute("script", "window.opener.updateAccount();");
        request.setAttribute("redirect", "close");
        session.setAttribute("facebook", jsonObject);
    	
    	MCMap m = new MCMap();
    	m.put("main_sns_account", "face");
    	m.put("user_id", jsonObject.getString("id"));
    	m.put("name", jsonObject.getString("name"));
    	m.put("profile_img", jsonObject.getJSONObject("picture").getJSONObject("data").getString("url"));
    	session.setAttribute("social_session", m);
		return "message";
		
	}
	
	public String postLink(String accessToken, Map map) throws Exception {
//		Credential credential = new Credential(BearerToken.authorizationHeaderAccessMethod()).setAccessToken(accessToken);
		Map param = new HashMap();
		param.put("access_token", accessToken);
		param.put("message", map.get("session_member_nm")+"의 댓글");
		param.put("description", map.get("conts"));
		param.put("picture", "https://www.snyouth.or.kr/images/main/header/seongnam_logo.gif");
		param.put("link", map.get("url"));
		String rst = getHttpPost("https://graph.facebook.com/v2.5/me/feed", param);
		return "ok";
	}

	//스케쥴러에서 호출
	public void accessTokenExchange() throws Exception {
		MCMap keyset = dao.view();
		String rst = getHttpGet("https://graph.facebook.com/v2.5/oauth/access_token?grant_type=fb_exchange_token&client_id="+keyset.getStrNull("face_appid")+"&client_secret="+keyset.getStrNull("face_app_secret")+"&fb_exchange_token="+keyset.getStrNull("face_access_token"));
		JSONObject jsonObject = JSONObject.fromObject(rst);
		Map p = new HashMap();
		p.put("face_access_token", jsonObject.getString("access_token"));
		dao.face_access_token_exchange(p);
		logger.info("페이스북 토큰갱신 : " + rst);
	}
	
	
	public String formatDate(String created_at){
		String dateString;
		try {
			Date date = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ssZ", Locale.ENGLISH).parse(created_at);
			dateString = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.KOREA).format(date);
		} catch (ParseException e) {
			dateString = created_at;
			e.printStackTrace();
		}
		return dateString;
	}
}
