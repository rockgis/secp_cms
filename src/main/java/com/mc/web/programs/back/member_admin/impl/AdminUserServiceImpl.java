package com.mc.web.programs.back.member_admin.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mc.common.util.DateUtil;
import com.mc.common.util.StringUtil;
import com.mc.web.JsonDAO;
import com.mc.web.MCMap;
import com.mc.web.programs.back.homepage.HomepageDAO;
import com.mc.web.programs.back.member_admin.AdminUserDAO;
import com.mc.web.programs.back.member_admin.AdminUserService;
import com.mc.web.programs.back.permit.PermitDAO;
import com.mc.web.programs.back.permit.PermitHelper;
import com.mc.web.programs.back.site.basic_setting.SiteBasicDAO;
import com.mc.web.common.SessionInfo;
import com.mc.web.login.McAdminLoginDAO;
import com.mc.web.service.EgovFileScrty;
import com.mc.web.service.Globals;

import egovframework.com.cmm.util.EgovHttpRequestHelper;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service("AdminUserService")
public class AdminUserServiceImpl extends EgovAbstractServiceImpl implements AdminUserService{
	
	@Autowired
	private AdminUserDAO dao;
	
	@Autowired
	private HomepageDAO homepageDAO;
	
	@Autowired
	private PermitHelper helper;

	@Autowired
	private McAdminLoginDAO loginDAO;
	
	@Autowired
	private PermitDAO permitDAO;
	
	@Autowired
	private JsonDAO jsonDao;
	
	@Autowired
	private SiteBasicDAO basicDAO;
	
	public Map list(Map params) throws Exception {
		Map rstMap = new HashMap();
		rstMap.put("list", dao.list(params));
		rstMap.put("pagination", dao.pagination(params));
		return rstMap;
	}
	
	public Map view(Map params) throws Exception {
		Map rstMap = new HashMap();
		rstMap.put("view", dao.view(params));
		rstMap.put("staff_list", homepageDAO.menu_staff_list(params));
		rstMap.put("permission_list", homepageDAO.menu_permission_list(params));
		return rstMap;
	}
	
	public Map write(Map params) throws Exception {
		SessionInfo.sessionAuth(params);
		memberInfo(params);
		Map rstMap = new HashMap();
		params.put("member_pw", EgovFileScrty.encryptPassword((String)params.get("member_pw"), Globals.SALT_KEY));
		dao.write(params);
		
		List list = (List) params.get("staff_list");
		if(list != null){
			for (int i = 0; i < list.size(); i++) {
				Map m = (Map) list.get(i);
				m.put("order_seq", i+1);
				m.put("group_seq", params.get("group_seq"));
				m.put("member_nm", params.get("member_nm"));
				m.put("session_member_id", params.get("session_member_id"));
				m.put("session_member_nm", params.get("session_member_nm"));
				m.put("ip", EgovHttpRequestHelper.getRequestIp());
				homepageDAO.insertStaff(m);
			}
		}
		rstMap.put("rst", 1);
		return rstMap;
	}

	public Map modify(Map params) throws Exception {
		Map rstMap = new HashMap();
		rstMap.put("rst", "N");
		
		if(params.get("super_pw") != null && !params.get("super_pw").equals(""))
		{
			Map superMap = new HashMap();
			SessionInfo.sessionAuth(superMap);
			superMap.put("member_id", superMap.get("session_member_id"));
			
			Map superMember = dao.getMemberById(superMap);
			if(superMember == null) return rstMap;
			String scan_pw = EgovFileScrty.encryptPassword((String)params.get("super_pw"), Globals.SALT_KEY); //입력받은 패스워드
			String member_pw = superMember.get("member_pw").toString(); //DB에 있는 관리자 패스워드
			if(!scan_pw.equals(member_pw)) return rstMap;
		}
		
		memberInfo(params);
		if(!StringUtil.isEmptyByParam(params, "member_pw")){
			params.put("member_pw", EgovFileScrty.encryptPassword((String)params.get("member_pw"), Globals.SALT_KEY));
		}
		dao.modify(params);
		
		/*
		SessionInfo.sessionAuth(params);
		memberInfo(params);
		Map rstMap = new HashMap();
		if(!StringUtil.isEmptyByParam(params, "member_pw")){
			params.put("member_pw", EgovFileScrty.encryptPassword((String)params.get("member_pw"), Globals.SALT_KEY));
		}
		dao.modify(params);
		*/
		
		homepageDAO.staff_del_user(params);
		List staff_list = (List) params.get("staff_list");
		if(staff_list != null){
			for (int i = 0; i < staff_list.size(); i++) {
				Map m = (Map) staff_list.get(i);
				m.put("order_seq", i+1);
				m.put("group_seq", params.get("group_seq"));
				m.put("member_nm", params.get("member_nm"));
				m.put("session_member_id", params.get("session_member_id"));
				m.put("session_member_nm", params.get("session_member_nm"));
				m.put("ip", EgovHttpRequestHelper.getRequestIp());
				homepageDAO.insertStaff(m);
			}
		}

		homepageDAO.permission_del_user(params);
		List permission_list = (List) params.get("permission_list");
		if(permission_list != null){
			for (int i = 0; i < permission_list.size(); i++) {
				Map m = (Map) permission_list.get(i);
				m.put("order_seq", i+1);
				m.put("group_seq", params.get("group_seq"));
				m.put("member_nm", params.get("member_nm"));
				m.put("session_member_id", params.get("session_member_id"));
				m.put("session_member_nm", params.get("session_member_nm"));
				m.put("ip", EgovHttpRequestHelper.getRequestIp());
				homepageDAO.insertPermission(m);
			}
		}
		
		rstMap.put("rst", "Y");
		return rstMap;
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
	
	public Map modify_pw(Map<String, String> params) throws Exception {
		SessionInfo.sessionAuth(params);
		Map rstMap = new HashMap();
		rstMap.put("rst", "N");
		
		if(params.get("old_member_pw") != null && !params.get("old_member_pw").equals("")) {
			Map member = dao.getMemberById(params);
			if(member == null) return rstMap;
			String scan_pw = EgovFileScrty.encryptPassword(params.get("old_member_pw"), Globals.SALT_KEY); //입력받은 패스워드
			String member_pw = member.get("member_pw").toString(); //DB에 있는 패스워드
			if(!scan_pw.equals(member_pw)) return rstMap;
		} else {
			params.put("made_yn", "Y"); //자신의 계정이 아닌경우
		}
		
		params.put("member_pw", EgovFileScrty.encryptPassword(params.get("member_pw"), Globals.SALT_KEY));
		rstMap.put("rst", dao.init_pw(params));
		rstMap.put("rst", "Y");
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
	
	public Map site_list(Map params) throws Exception {
		Map rstMap = new HashMap();
		rstMap.put("site_list", homepageDAO.site_list());
		return rstMap;
	}
	
	public Map staff(Map params) throws Exception {
		Map rstMap = new HashMap();
		rstMap.put("site_list", homepageDAO.site_list());
		return rstMap;
	}
	
	public Map permission_list(Map params) throws Exception {
		Map rstMap = new HashMap();
		rstMap.put("list", homepageDAO.menu_permission_list(params));
		return rstMap;
	}
	
	public Map updatePermission(Map params) throws Exception {
		SessionInfo.sessionAuth(params);
		Map rstMap = new HashMap();
		List list = (List) params.get("add_list");
		if(list != null){
			for (int i = 0; i < list.size(); i++) {
				Map m = (Map) list.get(i);
				m.put("session_member_id", params.get("session_member_id"));
				m.put("session_member_nm", params.get("session_member_nm"));
				m.put("ip", EgovHttpRequestHelper.getRequestIp());
				homepageDAO.insertPermission(m);
			}
		}
		list = (List) params.get("remove_list");
		if(list != null){
			for (int i = 0; i < list.size(); i++) {
				Map m = (Map) list.get(i);
				homepageDAO.permission_del(m);
			}
		}
		rstMap.put("rst", "1");
		return rstMap;
	}
	
	public Map staff_list(Map params) throws Exception {
		Map rstMap = new HashMap();
		rstMap.put("list", homepageDAO.menu_staff_list(params));
		return rstMap;
	}
	
	public Map updateStaff(Map params) throws Exception {
		SessionInfo.sessionAuth(params);
		Map rstMap = new HashMap();
		List list = (List) params.get("add_list");
		if(list != null){
			for (int i = 0; i < list.size(); i++) {
				Map m = (Map) list.get(i);
				m.put("session_member_id", params.get("session_member_id"));
				m.put("session_member_nm", params.get("session_member_nm"));
				m.put("ip", EgovHttpRequestHelper.getRequestIp());
				homepageDAO.insertStaff(m);
			}
		}
		list = (List) params.get("remove_list");
		if(list != null){
			for (int i = 0; i < list.size(); i++) {
				Map m = (Map) list.get(i);
				homepageDAO.staff_del(m);
			}
		}
		rstMap.put("rst", "1");
		return rstMap;
	}
	
	public Map memberPermitList(Map params) throws Exception {
		Map rstMap = new HashMap();
		if(permitDAO.hasMemberPermit(params)>0){
			rstMap.put("list", helper.makeList(permitDAO.memberPermitList1(params)));
			rstMap.put("md", "1");
		}else{
			rstMap.put("list", helper.makeList(permitDAO.memberPermitList2(params)));
			rstMap.put("md", "2");
		}
		return rstMap;
	}
	
	public Map memberHistory(Map params) throws Exception {
		Map rstMap = new HashMap();
		rstMap.put("list", dao.memberHistoryList(params));
		rstMap.put("pagination", dao.memberHistoryPagination(params));
		return rstMap;
	}
	
	public Map updateMemberPermission(Map params) throws Exception {
		SessionInfo.sessionAuth(params);
		Map rstMap = new HashMap();
		permitDAO.permit_del_member_all(params);
		List list = (List) params.get("list");
		if(list != null){
			for (int i = 0; i < list.size(); i++) {
				Map m = (Map) list.get(i);
				m.put("member_id", params.get("member_id"));
				m.put("site_id", params.get("site_id"));
				permitDAO.insert_permit_member(m);
			}
		}
		rstMap.put("rst", "1");
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
    public Map memberBlockInit(String memberId) throws Exception {
    	Map rstMap = new HashMap();
		rstMap.put("rst", loginDAO.loginFailCntInit(memberId));
		return rstMap;
    }
    public Map memberWakeup(String memberId) throws Exception {
    	Map rstMap = new HashMap();
		rstMap.put("rst", loginDAO.memberWakeup(memberId));
		return rstMap;
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
	
	public Map modify_pw_adm(Map<String, String> params) throws Exception {
		Map rst = new HashMap();
		Map p = new HashMap();
		p.put("member_id", params.get("member_id"));
//		p.put("member_pw", EgovFileScrty.encryptPassword(params.get("current_pw"), Globals.SALT_KEY));
		MCMap member = dao.getMemberById(p);
		if(StringUtil.isEmptyByParam(params, "member_pw")){
			rst.put("rst", "X");
			rst.put("msg", "새로운비밀번호를 입력하여 주시기 바랍니다.");
		}/*else if(member==null){
			rst.put("rst", "X");
			rst.put("msg", "기존 비밀번호를 확인하여 주시기 바랍니다.");
		}*/else{
			params.put("session_member_id", member.getStr("session_member_id"));
			params.put("session_member_nm", member.getStr("session_member_nm"));
			params.put("member_pw", EgovFileScrty.encryptPassword(params.get("member_pw"), Globals.SALT_KEY));
			params.put("made_yn", "N");
			int i = dao.init_pw(params);
			if(i>0){
				rst.put("rst", "Y");
			}else{
				rst.put("rst", "X");
				rst.put("msg", "관리자에게 문의하여 주시기 바랍니다.");
			}
		}
		return rst;
	}
	
	public String dormancy_adm(Map params) throws Exception {
		HttpServletRequest request = EgovHttpRequestHelper.getCurrentRequest();
		params.put("code_group_seq", "3");
		request.setAttribute("email2", jsonDao.getList("Code.codeList", params));
		return "/member/dormancy_adm";
	}
	
	public Map dormancy_adm_init(Map<String, String> params) throws Exception {
		Map rst = new HashMap();
		if(!StringUtil.isEmpty((String)params.get("email1")) && !StringUtil.isEmpty((String)params.get("email2"))){
			params.put("email", params.get("email1")+"@"+params.get("email2"));
		}
		int i = dao.dormancy_adm_init(params);
		if(i>0){
			rst.put("rst", "Y");
		}else{
			rst.put("rst", "X");
			rst.put("msg", "계정정보가 일치하지 않습니다.\n관리자에게 문의하시기 바랍니다.");
		}
		return rst;
	}
	
	public void dormancy_update() {
		MCMap basicMap = basicDAO.basic_view("1");
		if("Y".equals(basicMap.getStrNull("adm_dormancy_yn"))){
			String dt = DateUtil.simpleDateFormat(DateUtil.getCurrentDateBDay(basicMap.getIntNullVal("adm_dormancy_day", 1)), "yyyyMMdd", "yyyy-MM-dd");
			dao.dormancy_update(dt);
		}
	}

}