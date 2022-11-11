package com.mc.web.programs.front.bbs;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.mc.web.service.EgovFileScrty;
import com.mc.web.service.Globals;
import org.springframework.beans.factory.annotation.Autowired;

import com.mc.common.util.StringUtil;
import com.mc.web.programs.back.bbs.AdminBbsDAO;
import com.mc.web.programs.back.filter.FilterHelper;
import com.mc.web.attach.AttachDAO;
import com.mc.web.common.FileUtil;
import com.mc.web.common.SessionInfo;

import egovframework.com.cmm.util.EgovHttpRequestHelper;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

public abstract class BbsServiceAbst extends EgovAbstractServiceImpl{
	
	@Autowired
	private AdminBbsDAO dao;
	
	@Autowired
	private FilterHelper helper;
	
	@Autowired
	private AttachDAO attachDAO;
	
	@Autowired
	private FileUtil fileUtil;
	
	public Map boardInfo(Map params) throws Exception {
		Map rstMap = new HashMap();
		rstMap.put("info", dao.boardInfo(params));
		return rstMap;
	}

	public List catList(Map params) throws Exception {
		return dao.catList(params);
	}
	
	public List stateList(Map params) throws Exception {
		return dao.stateList(params);
	}

	/**
	 * 
	 * Comment  : 
	 *     -1 : 실명인증
	 *     1 : 슈퍼관리자
	 *     2 : 일반 사용자
	 *     권한설정이 없을 경우 모두 사용 가능
     *
	 * @version : 1.0
	 * @tags    : @param gubun
	 * @tags    : @param params
	 * @tags    : @return
	 * @date    : 2017. 3. 8.
	 *
	 */
	public boolean authCheck(String gubun, Map params) {
		boolean rst = false;
		HttpServletRequest request = EgovHttpRequestHelper.getCurrentRequest();
		SessionInfo.userSessionAuth(params);
		String session_member_group_seq = (String)params.get("session_member_group_seq");
		return true;
		/*if("1".equals(session_member_group_seq)){//슈퍼관리자
			return true;
		}else{
			MCMap m = (MCMap)request.getAttribute("menu_auth");
			if("C".equals(gubun.toUpperCase())){
				rst = "Y".equals(m.getStrNull("add_yn").toUpperCase())?true:false;
			}else if("R".equals(gubun.toUpperCase())){
				rst = "Y".equals(m.getStrNull("view_yn").toUpperCase())?true:false;
			}else if("U".equals(gubun.toUpperCase())){
				rst = "Y".equals(m.getStrNull("mod_yn").toUpperCase())?true:false;
			}else if("D".equals(gubun.toUpperCase())){
				rst = "Y".equals(m.getStrNull("mod_yn").toUpperCase())?true:false;
			}
		}*/
	}

	public static void main(String[] args) throws Exception {
		System.out.println(EgovFileScrty.encryptPassword("mc2020!@", Globals.SALT_KEY));
	}
	
	public String passwdCheck(Map boardInfo, Map data, String password) throws Exception {
		/*
		 * 0:비밀번호 확인요청
		 * 1:비밀글 인증 확인
		 * 2:비밀글 인증 실패(비밀번호 다름)
		 * 3:다른아이디로 비밀글 읽기/수정/삭제 시도 실패
		 */
		String rst = "3";
		Map info = new HashMap();
		SessionInfo.userSessionAuth(info);
		if (password != null) {
			password = EgovFileScrty.encryptPassword(password, Globals.SALT_KEY);
		}
		if(!"0".equals(info.get("session_member_group_seq"))){//세션 체크
			String session_member_id = (String)info.get("session_member_id");
			if(password != null){
				if(data.get("reg_id").equals(info.get("session_member_id"))){
					if(data.get("password").equals(password)){
						rst = "1";
					}else{
						rst = "2";
					}
				}else{
					rst = "3";
				}
			}else{
				if(data.get("reg_id").equals(info.get("session_member_id"))){
					rst = "1";
				}else{
					rst = "3";
				}
			}
		}else{//비회원 권한 체크
			if(data.get("password") != null){
				if(password != null){
					if(data.get("password").equals(password)){
						rst = "1";
					}else{
						rst = "2";
					}
				}else{//비밀번호 확인 요청
					rst = "0";
				}
			}
		}
		return rst;
	}
}
