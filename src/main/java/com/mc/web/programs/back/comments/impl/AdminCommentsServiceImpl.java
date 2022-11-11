package com.mc.web.programs.back.comments.impl;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mc.common.util.StringUtil;
import com.mc.web.MCMap;
import com.mc.web.common.SessionInfo;
import com.mc.web.programs.back.comments.AdminCommentsService;
import com.mc.web.programs.front.comments.CommentsDAO;

import egovframework.com.cmm.util.EgovHttpRequestHelper;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

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
@Service("AdminCommentsService")
public class AdminCommentsServiceImpl extends EgovAbstractServiceImpl implements AdminCommentsService{
	
	@Autowired
	private CommentsDAO dao;
	
	public Map list(Map params) throws Exception {
		Map rstMap = new HashMap();
		rstMap.put("list", dao.list(params));
		rstMap.put("pagination", dao.pagination(params));
		return rstMap;
	}
	
	public Map comment_reg(Map params) throws Exception {
		SessionInfo.sessionAuth(params);
		Map rstMap = new HashMap();
		HttpSession session = EgovHttpRequestHelper.getCurrentSession();
		HttpServletRequest request = EgovHttpRequestHelper.getCurrentRequest();
		MCMap member = (MCMap) session.getAttribute("cms_member");
		if(member == null && StringUtil.isEmptyByParam(params, "main_account")){
			rstMap.put("msg", "로그인을 해주시기 바랍니다.");
			rstMap.put("rst", "-1");
		}else{
			rstMap.put("rst", dao.write(params));
		}
		
		return rstMap;
	}
	
	public Map re_comment_reg(Map params) throws Exception {
		SessionInfo.sessionAuth(params);
		Map rstMap = new HashMap();
		HttpSession session = EgovHttpRequestHelper.getCurrentSession();
		HttpServletRequest request = EgovHttpRequestHelper.getCurrentRequest();
		MCMap member = (MCMap) session.getAttribute("cms_member");
		if(member == null && StringUtil.isEmptyByParam(params, "main_account")){
			rstMap.put("msg", "로그인을 해주시기 바랍니다.");
			rstMap.put("rst", "-1");
		}else{
			rstMap.put("rst", dao.write(params));
		}		
		return rstMap;
	}

	public Map del(Map params) throws Exception {
		SessionInfo.sessionAuth(params);
		Map rstMap = new HashMap();
		rstMap.put("rst", dao.del(params));
		return rstMap;
	}
	
}