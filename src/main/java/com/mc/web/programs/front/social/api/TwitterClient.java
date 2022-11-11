package com.mc.web.programs.front.social.api;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;
import java.util.Map;

import javax.annotation.PostConstruct;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.mc.web.MCMap;
import com.mc.web.programs.back.sns_account.SnsAccountDAO;

import twitter4j.Twitter;
import twitter4j.TwitterException;
import twitter4j.TwitterFactory;
import twitter4j.auth.AccessToken;
import twitter4j.auth.RequestToken;
import twitter4j.conf.ConfigurationBuilder;

@Controller
@RequestMapping("/twitter.do")
public class TwitterClient {
	Logger logger = Logger.getLogger(this.getClass());
	private RequestToken g_reqToken;
	
	@Autowired
	private SnsAccountDAO dao;
	
	@PostConstruct
	public void init() {
		System.setProperty("https.protocols", "SSLv3,TLSv1,TLSv1.1,TLSv1.2");
	}

	@RequestMapping(params="!mode")
	public String twitter(HttpServletRequest request, HttpSession session) throws Exception {
		MCMap keyset = dao.view();
		
		ConfigurationBuilder cb = new ConfigurationBuilder();
		cb.setDebugEnabled(true).setOAuthConsumerKey(keyset.getStrNull("twt_consumer_key")).setOAuthConsumerSecret(keyset.getStrNull("twt_consumer_secret"));
		TwitterFactory tf = new TwitterFactory(cb.build());
		Twitter twitter = tf.getInstance();

		session.setAttribute("twitter", twitter);// 인증받은 twitter 객체를 세션에 담아두고 계속 사용
		g_reqToken = twitter.getOAuthRequestToken();
		String authUrl = g_reqToken.getAuthorizationURL();// 앱 만들때 적은 콜백URL
		session.setAttribute("userToken", g_reqToken.getToken());
		session.setAttribute("userSecretToken", g_reqToken.getTokenSecret());

		return "redirect:" + authUrl;
	}

	@RequestMapping(params="mode=logout")
	public String logout(HttpServletRequest request, HttpSession session) throws Exception {
		session.removeAttribute("twitter");
		request.setAttribute("redirect", "reloadclose");
		return "message";
	}

	@RequestMapping(params="mode=callback")
	public String callBackUrl(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap model, @RequestParam Map params) throws Exception {
		Twitter twitter;
		twitter = (Twitter) session.getAttribute("twitter");// 토큰 받아서 세션에 저장했던 twitter 객체
		try {

			AccessToken accessToken = twitter.getOAuthAccessToken(g_reqToken, (String) request.getParameter("oauth_verifier"));

        	request.setAttribute("script", "window.opener.updateAccount();");
			request.setAttribute("redirect", "close");
			session.setAttribute("twitter", twitter);
			session.setAttribute("twitter_userid", twitter.getScreenName());
        	
        	MCMap m = new MCMap();
        	m.put("main_sns_account", "twt");
        	m.put("user_id", twitter.getId());
        	m.put("name", "@" + twitter.getScreenName());
        	m.put("profile_img", twitter.showUser(twitter.getId()).getProfileImageURLHttps());
        	session.setAttribute("social_session", m);

		} catch (TwitterException e) {
			// TODO: handle exception
		}
		return "message";
	}
	
	public String formatDate(String created_at){
		 //Thu Jun 20 02:09:29 +0000 2013
		String dateString;
		try {
			Date date = new SimpleDateFormat("EEE MMM dd HH:mm:ss Z yyyy", Locale.ENGLISH).parse(created_at);
			dateString = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.KOREA).format(date);
		} catch (ParseException e) {
			dateString = created_at;
			e.printStackTrace();
		}
		return dateString;
	}
}
