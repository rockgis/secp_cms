package com.mc.web.programs.back.member.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mc.common.util.DateUtil;
import com.mc.common.util.StringUtil;
import com.mc.web.MCMap;
import com.mc.web.programs.back.member.UserDAO;
import com.mc.web.programs.back.member.UserService;
import com.mc.web.programs.back.site.basic_setting.SiteBasicDAO;
import com.mc.web.common.SessionInfo;
import com.mc.web.login.McAdminLoginDAO;
import com.mc.web.login.McUserLoginDAO;
import com.mc.web.service.EgovFileScrty;
import com.mc.web.service.Globals;

import egovframework.com.cmm.util.EgovHttpRequestHelper;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service("UserService")
public class UserServiceImpl extends EgovAbstractServiceImpl implements UserService{
	
	@Autowired
	private UserDAO dao;

	@Autowired
	private McUserLoginDAO loginDAO;
	
	@Autowired
	private McAdminLoginDAO superLoginDAO;
	
	@Autowired
	private SiteBasicDAO basicDAO;
	
	public Map list(Map params) throws Exception {
		Map rstMap = new HashMap();
		rstMap.put("list", dao.list(params));
		rstMap.put("pagination", dao.pagination(params));
		return rstMap;
	}
	
	public MCMap view(Map params) throws Exception {
		return dao.view(params);
	}
	
	public Map write(Map<String, String> params) throws Exception {
		SessionInfo.sessionAuth(params);
		memberInfo(params);
		Map rstMap = new HashMap();
		params.put("member_pw", EgovFileScrty.encryptPassword(params.get("member_pw"), Globals.SALT_KEY));
		rstMap.put("rst", dao.write(params));
		return rstMap;
	}

	public Map modify(Map<String, String> params) throws Exception {
		Map rstMap = new HashMap();
		rstMap.put("rst", "N");
		
		Map superMap = new HashMap();
		SessionInfo.sessionAuth(superMap);
		superMap.put("member_id", superMap.get("session_member_id"));
		
		Map superMember = superLoginDAO.getMemberById(superMap);
		if(superMember == null) return rstMap;
		String scan_pw = EgovFileScrty.encryptPassword(params.get("super_pw"), Globals.SALT_KEY); //입력받은 패스워드
		String member_pw = superMember.get("member_pw").toString(); //DB에 있는 관리자 패스워드
		if(scan_pw.equals(member_pw)){
			memberInfo(params);
			if(!StringUtil.isEmptyByParam(params, "member_pw")){
				params.put("member_pw", EgovFileScrty.encryptPassword(params.get("member_pw"), Globals.SALT_KEY));
				params.put("made_yn", "Y");
			}
			dao.modify(params);
			rstMap.put("rst", "Y");
		}
		
		return rstMap;
		/*
		SessionInfo.sessionAuth(params);
		memberInfo(params);
		Map rstMap = new HashMap();
		if(!StringUtil.isEmptyByParam(params, "member_pw")){
			params.put("member_pw", EgovFileScrty.encryptPassword(params.get("member_pw"), Globals.SALT_KEY));
		}
		rstMap.put("rst", dao.modify(params));
		return rstMap;
		*/
	}
	
	public Map pw_check(Map<String, String> params) throws Exception {
		SessionInfo.sessionAuth(params);
		Map rstMap = new HashMap();
		params.put("member_pw", EgovFileScrty.encryptPassword(params.get("member_pw"), Globals.SALT_KEY));
		Map member = loginDAO.getMemberByIdPw(params);
		if(member==null){
			rstMap.put("rst", "N");
		}else{
			rstMap.put("rst", "Y");
		}
		return rstMap;
	}
	
	public Map init_pw(Map<String, String> params) throws Exception {
		SessionInfo.sessionAuth(params);
		Map rstMap = new HashMap();
		params.put("member_pw", EgovFileScrty.encryptPassword("mc2020!@", Globals.SALT_KEY));
		params.put("made_yn", "Y");
		rstMap.put("rst", dao.init_pw(params));
		return rstMap;
	}
	
	public Map del(Map params) throws Exception {
		SessionInfo.sessionAuth(params);
		Map rstMap = new HashMap();
		List<String> deleteList = StringUtil.strToList((String)params.get("member_list"), ",");
		params.put("seq_list", deleteList);
		rstMap.put("rst", dao.del(params));
		return rstMap;
	}
	
	public Map leave(Map params) throws Exception {
		SessionInfo.sessionAuth(params);
		Map rstMap = new HashMap();
		params.put("super", "Y");
		List<String> deleteList = StringUtil.strToList((String)params.get("member_list"), ",");
		params.put("seq_list", deleteList);
		rstMap.put("rst", dao.leave(params));
		return rstMap;
	}

	@Override
	public Map updateOrder(Map params) throws Exception {
		SessionInfo.sessionAuth(params);
		Map rstMap = new HashMap();
		List list = (List) params.get("list");
		if(list != null){
			for (int i = 0; i < list.size(); i++) {
				Map m = (Map) list.get(i);
				m.put("session_member_id", params.get("session_member_id"));
				m.put("session_member_nm", params.get("session_member_nm"));
				m.put("ip", EgovHttpRequestHelper.getRequestIp());
				dao.updateOrder(m);
			}
		}
		
		List group_list = (List) params.get("group_list");
		if(group_list != null){
			for (int i = 0; i < group_list.size(); i++) {
				Map m = (Map) group_list.get(i);
				m.put("session_member_id", params.get("session_member_id"));
				m.put("session_member_nm", params.get("session_member_nm"));
				m.put("ip", EgovHttpRequestHelper.getRequestIp());
				dao.updateGroupOrder(m);
			}
		}
		rstMap.put("rst", "1");
		return rstMap;
	}

	public Map updateGroup(Map params) throws Exception {
		SessionInfo.sessionAuth(params);
		Map rstMap = new HashMap();
		List list = (List) params.get("list");
		if(list != null){
			for (int i = 0; i < list.size(); i++) {
				Map m = (Map) list.get(i);
				m.put("session_member_id", params.get("session_member_id"));
				m.put("session_member_nm", params.get("session_member_nm"));
				m.put("ip", EgovHttpRequestHelper.getRequestIp());
				dao.updateGroup(m);
			}
		}
		rstMap.put("rst", "1");
		return rstMap;
	}
	
	public Map modify_pw(Map<String, String> params) throws Exception {
		Map rstMap = new HashMap();
		rstMap.put("rst", "N");
		
		Map superMap = new HashMap();
		SessionInfo.sessionAuth(superMap);
		superMap.put("member_id", superMap.get("session_member_id"));
		
		Map superMember = superLoginDAO.getMemberById(superMap);
		if(superMember == null) return rstMap;
		String scan_pw = EgovFileScrty.encryptPassword(params.get("super_member_pw"), Globals.SALT_KEY); //입력받은 패스워드
		String member_pw = superMember.get("member_pw").toString(); //DB에 있는 관리자 패스워드
		if(scan_pw.equals(member_pw)){
			params.put("member_pw", EgovFileScrty.encryptPassword(params.get("member_pw"), Globals.SALT_KEY));
			rstMap.put("rst", dao.init_pw(params));
			rstMap.put("rst", "Y");
		}
		
		return rstMap;
	}
	
	private void memberInfo(Map params) {
		if(!StringUtil.isEmpty((String)params.get("tel1")) && !StringUtil.isEmpty((String)params.get("tel2")) && !StringUtil.isEmpty((String)params.get("tel3"))){
			params.put("tel", params.get("tel1")+"-"+params.get("tel2")+"-"+params.get("tel3"));
		}
		if(!StringUtil.isEmpty((String)params.get("cell1")) && !StringUtil.isEmpty((String)params.get("cell2")) && !StringUtil.isEmpty((String)params.get("cell3"))){
			params.put("cell", params.get("cell1")+"-"+params.get("cell2")+"-"+params.get("cell3"));
		}
		if(!StringUtil.isEmpty((String)params.get("email1")) && !StringUtil.isEmpty((String)params.get("email2"))){
			params.put("email", params.get("email1")+"@"+params.get("email2"));
		}
	}

    @Override
    public void memberBlockInit(String memberId) throws Exception {
    	dao.loginFailCntInit(memberId);
    }
    public void memberWakeup(String memberId) throws Exception {
    	dao.memberWakeup(memberId);
    }
	
	public Map id_check(Map<String, String> params) throws Exception {
		Map rst = new HashMap();
		int cnt = dao.getMemberIdCnt(params).getIntNullVal("cnt", 1);
		String retrnVal = "";
		if( cnt  > 0 ) {//중복
			retrnVal = "Y";
		} else {
			retrnVal =  "N";
		}
		rst.put("rst", retrnVal);
		return rst;
	}

	@Override
	public void dormancy_update() {
		MCMap basicMap = basicDAO.basic_view("1");
		if("Y".equals(basicMap.getStrNull("dormancy_yn"))){
			String dt = DateUtil.simpleDateFormat(DateUtil.getCurrentDateBDay(basicMap.getIntNullVal("dormancy_day", 1)), "yyyyMMdd", "yyyy-MM-dd");
			dao.dormancy_update(dt);
		}
	}
	
	public Map memberHistory(Map params) throws Exception {
		Map rstMap = new HashMap();
		rstMap.put("list", dao.memberHistoryList(params));
		rstMap.put("pagination", dao.memberHistoryPagination(params));
		return rstMap;
	}

}