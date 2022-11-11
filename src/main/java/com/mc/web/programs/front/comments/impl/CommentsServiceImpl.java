package com.mc.web.programs.front.comments.impl;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mc.common.util.StringUtil;
import com.mc.web.MCMap;
import com.mc.web.common.SessionInfo;
import com.mc.web.programs.front.comments.CommentsDAO;
import com.mc.web.programs.front.comments.CommentsService;
import com.mc.web.programs.front.social.api.FacebookClient;
import com.mc.web.programs.front.social.api.KakaoClient;

import egovframework.com.cmm.util.EgovHttpRequestHelper;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import net.sf.json.JSONObject;
import twitter4j.Twitter;
import twitter4j.TwitterException;

/**
 * 
 * @Description : 
 * @ClassName   : com.mc.web.comments.impl.CommentsServiceImpl.java
 * @author 이창기
 * @since 2015. 10. 12.
 * @version 1.0 *
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일        수정자       수정내용
 *  -------       --------    ---------------------------
 * </pre>
 */
@Service("CommentsService")
public class CommentsServiceImpl extends EgovAbstractServiceImpl implements CommentsService{
	
	@Autowired
	private CommentsDAO dao;
	
	@Autowired
	private FacebookClient facebookClient;
	
	@Autowired
	private KakaoClient kakaoClient;

	public String sns_box(Map params) throws Exception {
		HttpServletRequest request = EgovHttpRequestHelper.getCurrentRequest();
		request.setAttribute("sns_account", dao.sns_account());
		return "comments/sns_box";
	}
	
	public String list(Map params) throws Exception {
		HttpServletRequest request = EgovHttpRequestHelper.getCurrentRequest();
		request.setAttribute("list", dao.list(params));
		request.setAttribute("pagination", dao.pagination(params));
		return "comments/list";
	}
	
	public Map comment_reg(Map params) throws Exception {
		SessionInfo.userSessionAuth(params);
		Map rstMap = new HashMap();
		HttpSession session = EgovHttpRequestHelper.getCurrentSession();
		HttpServletRequest request = EgovHttpRequestHelper.getCurrentRequest();
		MCMap member = (MCMap) session.getAttribute("member");
		MCMap social_session = (MCMap) session.getAttribute("social_session");
		if(member == null && social_session==null){
			rstMap.put("msg", "로그인을 해주시기 바랍니다.");
			rstMap.put("rst", "-1");
		}else{
			if(StringUtil.isEmptyByParam(params, "conts")){
				rstMap.put("msg", "내용을 입력해 주시기 바랍니다.");
				rstMap.put("rst", "-1");
				return rstMap;
			}
			
			Twitter twitter = (Twitter) session.getAttribute("twitter");
			JSONObject facebook = (JSONObject) session.getAttribute("facebook");
			JSONObject naver = (JSONObject) session.getAttribute("naver");
			JSONObject kakao = (JSONObject) session.getAttribute("kakao");
			if(social_session!=null && StringUtil.inArray(new String[]{"twt", "face", "nav", "kao", "google", "insta"}, social_session.getStrNull("main_sns_account"))){
				params.put("session_member_id", social_session.getStrNull("user_id"));
				params.put("session_member_nm", social_session.getStrNull("name"));
				params.put("profile_img", social_session.getStrNull("profile_img"));
				params.put("main_account", social_session.getStrNull("main_sns_account"));
			}
			rstMap.put("rst", dao.write(params));
			
			if(twitter != null && "Y".equals(params.get("twt_yn"))){
				String twit = params.get("conts") == null ? "" : (String)params.get("conts");// 트윗할 내용
//				
				try {
					if (!twit.equals("")) {
						String url = (String)params.get("url");
						twit = twit.length() > 140-url.length()-1 ? twit.substring(0, 140-url.length()-1) : twit;
						twit+=":"+url;
						twitter.updateStatus(twit);// 전송 끝!
						params.put("twt_yn", "Y");
					}
				} catch (TwitterException e) {
					params.put("twt_yn", "N");
				}
			}
			
			if(facebook != null && "Y".equals(params.get("face_yn"))){
				String msg = params.get("conts") == null ? "" : (String)params.get("conts");// 트윗할 내용
				if (!msg.equals("")) {
					String facebookAccessToken = (String) session.getAttribute("facebookAccessToken");
					facebookClient.postLink(facebookAccessToken, params);
					params.put("face_yn", "Y");
				}
			}
			
			if(kakao != null && "Y".equals(params.get("kao_yn"))){
				String msg = params.get("conts") == null ? "" : (String)params.get("conts");// 트윗할 내용
				if (!msg.equals("")) {
					JSONObject kakaoAccessToken = (JSONObject) session.getAttribute("kakaoAccessToken");
					kakaoClient.postLink(kakaoAccessToken, params);
					params.put("kao_yn", "Y");
				}
			}
			
			if("Y".equals(params.get("twt_yn")) || "Y".equals(params.get("face_yn")) || "Y".equals(params.get("kao_yn"))){
				dao.sns_update(params);
			}
			
		}
		
		return rstMap;
	}
	
	public Map re_comment_reg(Map params) throws Exception {
		SessionInfo.userSessionAuth(params);
		Map rstMap = new HashMap();
		HttpSession session = EgovHttpRequestHelper.getCurrentSession();
		HttpServletRequest request = EgovHttpRequestHelper.getCurrentRequest();
		MCMap member = (MCMap) session.getAttribute("member");
		MCMap social_session = (MCMap) session.getAttribute("social_session");
		if(member == null && social_session==null){
			rstMap.put("msg", "로그인을 해주시기 바랍니다.");
			rstMap.put("rst", "-1");
		}else{
			if(StringUtil.isEmptyByParam(params, "conts")){
				rstMap.put("msg", "내용을 입력해 주시기 바랍니다.");
				rstMap.put("rst", "-1");
				return rstMap;
			}
			if(social_session!=null && StringUtil.inArray(new String[]{"twt", "face", "nav", "kao", "google", "insta"}, social_session.getStrNull("main_sns_account"))){
				params.put("session_member_id", social_session.getStrNull("user_id"));
				params.put("session_member_nm", social_session.getStrNull("name"));
				params.put("profile_img", social_session.getStrNull("profile_img"));
				params.put("main_account", social_session.getStrNull("main_sns_account"));
			}
			rstMap.put("rst", dao.write(params));
		}		
		return rstMap;
	}

	public Map comment_mod(Map params) throws Exception {
		SessionInfo.userSessionAuth(params);
		Map rstMap = new HashMap();
		HttpSession session = EgovHttpRequestHelper.getCurrentSession();
		HttpServletRequest request = EgovHttpRequestHelper.getCurrentRequest();
		MCMap member = (MCMap) session.getAttribute("member");
		MCMap social_session = (MCMap) session.getAttribute("social_session");
		if(social_session!=null && StringUtil.inArray(new String[]{"twt", "face", "nav", "kao", "google", "insta"}, social_session.getStrNull("main_sns_account"))){
			params.put("session_member_id", social_session.getStrNull("user_id"));
			params.put("session_member_nm", social_session.getStrNull("name"));
			params.put("profile_img", social_session.getStrNull("profile_img"));
			params.put("main_account", social_session.getStrNull("main_sns_account"));
		}
		if(member == null && social_session==null){
			rstMap.put("msg", "로그인을 해주시기 바랍니다.");
			rstMap.put("rst", "-1");
		}else{
			rstMap.put("rst", dao.modify(params));
		}
		return rstMap;		
	}

	public Map del(Map params) throws Exception {
		SessionInfo.userSessionAuth(params);
		Map rstMap = new HashMap();
		rstMap.put("rst", dao.del(params));
		return rstMap;
	}
	
}