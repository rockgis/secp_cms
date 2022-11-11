package com.mc.web.programs.front.poll.impl;

import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mc.web.common.MCDoubleSubmitHelper;
import com.mc.web.common.SessionInfo;
import com.mc.web.programs.front.poll.UserPollDAO;
import com.mc.web.programs.front.poll.UserPollService;

import egovframework.com.cmm.util.EgovHttpRequestHelper;

@Service("UserPollService")
public class UserPollServiceImpl implements UserPollService {
	
	@Autowired
	private UserPollDAO dao;
	
	public String list(Map<String, String> params) throws Exception {
		HttpServletRequest request = EgovHttpRequestHelper.getCurrentRequest();
		Map rstMap = new HashMap();
		if(("").equals(params.get("cpage"))) params.put("cpage", "1");
		if(("").equals(params.get("rows"))) params.put("rows", "10");
		List<Map> list = dao.getList(params);
		for(Map m : list){
			m.put("cud", authCheck(m,"cud_group_seq"));
		}
		rstMap.put("list", list);
		rstMap.put("pagination", dao.getPageInfo(params));
		request.setAttribute("data", rstMap);
		request.setAttribute("params", params);
		return "poll/list";
	}
	
	public String joinForm(Map<String, String> params) throws Exception {
		HttpServletRequest request = EgovHttpRequestHelper.getCurrentRequest();
		String queryString = "poll_seq="+request.getParameter("poll_seq")+"&cpage="+request.getParameter("cpage")+"&rows="+request.getParameter("rows")+"&condition="+request.getParameter("condition")+"&keyword="+request.getParameter("keyword");
		Map rstMap = new HashMap();
		Map view = (Map)dao.article(params);
		if(view != null){
			if("1".equals(view.get("stat_num"))){
				if(authCheck(view,"cud_group_seq")){
					boolean joinCheck = joinAuthCheck(view,"form","");
					if(joinCheck){
						List<Map> question = (List<Map>)dao.questionList(params);
						List<Map> question_list = new ArrayList<Map>();
						List<List<Map>> answer_list = new ArrayList<List<Map>>();
						for(int i=0; i < question.size(); i++){//설문 생성
							Map m = (Map)question.get(i);
							if("-1".equals(String.valueOf(m.get("seq"))) && "N".equals(String.valueOf(m.get("del_yn")))){
								question_list.add(m);
							}
						}
						for(int i=0; i < question_list.size(); i++){//항목 생성
							Map m = (Map)question_list.get(i);
							List<Map> answers = new ArrayList<Map>();
							for(int x=0; x < question.size(); x++){
								Map sub_m = (Map)question.get(x);
								Map ans = new HashMap();
								if(!"-1".equals(String.valueOf(sub_m.get("seq"))) && "N".equals(String.valueOf(sub_m.get("del_yn"))) && (String.valueOf(m.get("question_seq"))).equals(String.valueOf(sub_m.get("seq")))){
									ans.put("answer", sub_m.get("question"));
									ans.put("answer_seq", sub_m.get("question_seq"));
									ans.put("question_seq", sub_m.get("seq"));
									ans.put("sub_type", m.get("question_type"));
									ans.put("null_chk", sub_m.get("null_chk"));
									ans.put("jump_chk", sub_m.get("jump_chk"));
									answers.add(ans);
								}
							}
							answer_list.add(answers);
						}
						params.put("code_group_seq","1");
						request.setAttribute("tellist", dao.selectList("Code.codeList", params));
						params.put("code_group_seq","2");
						request.setAttribute("celllist", dao.selectList("Code.codeList", params));
						params.put("code_group_seq","3");
						request.setAttribute("emaillist", dao.selectList("Code.codeList", params));
						request.setAttribute("view", view);					
						request.setAttribute("question", question_list);
						request.setAttribute("answers", answer_list);
						request.setAttribute("params", params);
						return "poll/join";
					}else{//설문에 이미 참여한 경우 결과 페이지로
						if(view.containsKey("cnt")){
							request.setAttribute("message", "이미 설문조사에 참여하셨습니다.");
						}else{
							request.setAttribute("message", "설문조사 대상이 아닙니다.");
						}
						//request.setAttribute("redirect","result.do?"+queryString);
						return "message";
					}
				}else{
					request.setAttribute("message", "설문조사 대상이 아닙니다.");
					//request.setAttribute("redirect","result.do?"+queryString);
					return "message";
				}
			}else if("0".equals(view.get("stat_num"))){
				request.setAttribute("message", "설문조사 기간이 아닙니다.");
				return "message";
			}else{//설문이 끝난 경우 결과 페이지로
				request.setAttribute("redirect","result.do?"+queryString);
				return "message";
			}
		}else{
			request.setAttribute("message", "잘못된 접근 권한입니다.");
	    	return "message";
		}
	}
	
	public synchronized String join(Map<String, String> params) throws Exception {//insertSEQ의 중복 방지를 위한 synchronized 설정
		HttpServletRequest request = EgovHttpRequestHelper.getCurrentRequest();
		String queryString = "poll_seq="+request.getParameter("poll_seq")+"&cpage="+request.getParameter("cpage")+"&rows="+request.getParameter("rows")+"&condition="+request.getParameter("condition")+"&keyword="+request.getParameter("keyword");
		String path = request.getAttribute("javax.servlet.forward.servlet_path").toString();
		path = path.replace("delete.do", "list.do");
		Map view = (Map)dao.article(params);		
		if (MCDoubleSubmitHelper.checkAndSaveToken(params)) {//이중 등록 방지
			if("1".equals(view.get("stat_num"))){
				if(authCheck(view,"cud_group_seq")){
					boolean joinCheck = joinAuthCheck(view,"join",String.valueOf(params.get("reg_tel1")+"-"+params.get("reg_tel2")+"-"+params.get("reg_tel3")));
					if(joinCheck){
						Map insertSEQ = dao.insertSEQ(params);
						List<Map> joinCheckList = dao.joinCheckList(params);
						boolean typeD = true;
						for(int i=0;i < joinCheckList.size(); i++){
							Map m = joinCheckList.get(i);
							Map insert = new HashMap();
							insert.put("poll_seq", params.get("poll_seq"));
							insert.put("reg_seq", insertSEQ.get("reg_seq"));
							insert.put("question_seq", m.get("question_seq"));
							insert.put("answer", "checked");
							if("Y".equals(view.get("lot_yn"))){
								if("0".equals(view.get("session_member_group_seq"))){
									insert.put("session_member_nm", params.get("reg_nm"));
								}else{
									insert.put("session_member_nm", view.get("session_member_nm"));
								}
								insert.put("session_member_id", view.get("session_member_id"));
								insert.put("reg_tel", params.get("reg_tel1")+"-"+params.get("reg_tel2")+"-"+params.get("reg_tel3"));
								insert.put("reg_email", params.get("reg_email") + "@" + params.get("reg_email2"));
							}else{
								if("0".equals(view.get("session_member_group_seq"))){
									insert.put("session_member_nm", "비회원");
								}else{
									insert.put("session_member_nm", view.get("session_member_nm"));
								}
								insert.put("session_member_id", view.get("session_member_id"));
								insert.put("reg_tel", "--");
								insert.put("reg_email", "");
							}
							if("A".equals(m.get("question_type"))){//단일항목
								if(params.get(String.valueOf(m.get("question_seq"))) != null){//이전 단계에서 DISABLE이 있는지 확인
									insert.put("answer_seq", params.get(String.valueOf(m.get("question_seq"))));
									dao.insertResult(insert);
								}
							}else if("B".equals(m.get("question_type"))){//중복항목
								String[] answer_list = request.getParameterValues(String.valueOf(m.get("question_seq")));
								if(answer_list != null){
									for(String str : answer_list){
										insert.put("answer_seq", str);
										dao.insertResult(insert);
									}
								}
							}else if("C".equals(m.get("question_type"))){//주관식
								if(params.get(String.valueOf(m.get("question_seq"))) != null){//이전 단계에서 DISABLE이 있는지 확인
									insert.put("answer_seq", "0");
									insert.put("answer", params.get(String.valueOf(m.get("question_seq"))));
									dao.insertResult(insert);
								}
							}else if("D".equals(m.get("question_type"))){
								if(params.get(String.valueOf(m.get("question_seq"))) != null){//이전 단계에서 DISABLE이 있는지 확인
									insert.put("answer_seq", params.get(String.valueOf(m.get("question_seq"))));
									Map jumpCheck = dao.jumpTypeCheck(insert);
									if("Y".equals(jumpCheck.get("jump_chk"))){//다음 문항이 DISABLE인지 확인
										typeD = false;
									}
									dao.insertResult(insert);
								}
							}else if("E".equals(m.get("question_type"))){
								if(params.get(String.valueOf(m.get("question_seq"))) != null){//이전 단계에서 DISABLE이 있는지 확인
									insert.put("answer_seq", params.get(String.valueOf(m.get("question_seq"))));
									Map jumpCheck = dao.jumpTypeCheck(insert);
									if("Y".equals(jumpCheck.get("jump_chk"))){//선택한 답변에 TEXTAREA가 있는지 확인
										insert.put("answer", params.get(String.valueOf(m.get("question_seq"))+"_t_"+String.valueOf(params.get(String.valueOf(m.get("question_seq"))))));
									}
									dao.insertResult(insert);
								}
							}							
						}
						request.setAttribute("message", "정상적으로 등록되었습니다.");
						//request.setAttribute("redirect","result.do?"+queryString);
						request.setAttribute("redirect",path);
						return "message";
					}else{
						request.setAttribute("message", "이미 참여하신 설문조사입니다.");
						request.setAttribute("redirect",path);
						//request.setAttribute("redirect","result.do?"+queryString);
						return "message";
					}
				}else{
					request.setAttribute("message", "잘못된 접근 권한입니다.");
			    	return "message";
				}
			}else if("0".equals(view.get("stat_num"))){
				request.setAttribute("message", "설문조사 기간이 아닙니다.");
				return "message";
			}else{//설문이 끝난 경우 결과 페이지로
				request.setAttribute("redirect","result.do"+queryString);
				return "message";
			}
		}else{
			request.setAttribute("message", "이중 등록은 하실수 없습니다.");
	    	request.setAttribute("redirect",path);
	    	return "message";
		}
		
	}

	public String result(Map<String, String> params) throws Exception {
		HttpServletRequest request = EgovHttpRequestHelper.getCurrentRequest();
		Map view = (Map)dao.article(params);
		/*if(authCheck(view,"cud_group_seq")){*/
			if(!"0".equals(view.get("stat_num"))){
				List<Map> answers = dao.resultAnswerList(params);
				List<Map> question_list = dao.resultQuestionList(params);
				List<List<Map>> answer_list = new ArrayList<List<Map>>();
				DecimalFormat format = new DecimalFormat(".#");
				for(int i=0; i < question_list.size(); i++){//항목 생성
					Map m = (Map)question_list.get(i);
					String total = "0";
					if(m.get("total") != null){
						total = String.valueOf(m.get("total"));
					}
					int totalcnt = Integer.parseInt(total);
					List<Map> answer = new ArrayList<Map>();
					for(int x=0; x < answers.size(); x++){
						Map sub_m = (Map)answers.get(x);
						if((m.get("question_seq")).equals(sub_m.get("question_seq"))){
							String strCnt = "0";
							if(sub_m.get("cnt") != null){
								strCnt = String.valueOf(sub_m.get("cnt"));
							}
							int cnt = Integer.parseInt(strCnt);
							if(totalcnt != 0){
								double per = (((double)cnt / totalcnt) * 100.0);
								if(per == 0.0){
									sub_m.put("percent","0");
								}else{
									sub_m.put("percent",format.format(per));
								}
							}else{
								sub_m.put("percent","0");
							}
							answer.add(sub_m);
						}
					}
					answer_list.add(answer);
				}
				request.setAttribute("view", view);					
				request.setAttribute("question", question_list);
				request.setAttribute("answers", answer_list);
				request.setAttribute("params", params);
				return "poll/result";
			}else{
				request.setAttribute("message", "설문조사 기간이 아닙니다.");
				return "message";
			}
		/*}else{
			request.setAttribute("message", "권한이 없습니다.");
			return "message";
		}*/
	}
	
	
	
	public boolean authCheck(Map params,String getName) {
		/*
		 * -1 : 실명인증
		 * 0 : 비회원
		 * 1 : 슈퍼관리자
		 * 2 : 일반 사용자
		 * 권한설정이 없을 경우 모두 사용 가능
		 * 
		 */
		boolean rst = false;
		Map authMap = new HashMap();
		Map authInfoMap = new HashMap();
		SessionInfo.userSessionAuth(params);
		String session_member_group_seq = String.valueOf(params.get("session_member_group_seq"));
		if(params.get(getName) != null){
			if(session_member_group_seq != null){
				if(!"1".equals(session_member_group_seq)){//슈퍼관리자 인증 무시
					String getGroupNames = String.valueOf(params.get(getName));
					if(!"".equals(getGroupNames) && getGroupNames != null){//권한이 생성이 되어 있을 경우
						String[] getGroupName = getGroupNames.split(",");
						for(int i=0; i < getGroupName.length; i++){
							String[] getGroup = getGroupName[i].split(":");
							authMap.clear();
							List authList = null;
							if(!"-1".equals(getGroup[0]) && !"0".equals(getGroup[0])){
								authMap.put("group_seq", getGroup[0]);
								authList = dao.userAuthCheck(authMap);
							}
							if(authList != null){//하위 권한이 있을 경우
								for(int x=0; x < authList.size(); x++){
									authInfoMap = (Map)authList.get(x);
									if(session_member_group_seq.equals(String.valueOf(authInfoMap.get("group_seq")))){
										rst = true;
									}
								}
							}else{
								if(session_member_group_seq.equals(getGroup[0])){
									rst = true;
								}
							}
						}
					}else{
						rst = true;
					}
				}
			}
		}else{
			rst = true;
		}
		if("1".equals(session_member_group_seq)){//슈퍼관리자 인증 무시
			rst = true;
		}
		return rst;
	}
	
	private boolean joinAuthCheck(Map params, String type, String tel){
		if("N".equals(params.get("dup_yn"))){
			return true;
		}
		boolean pass = true; //계속 참여여부
		if(pass){
			return pass;
		}else{
			boolean result = false;
			Map m = new HashMap();
			Map check = null;
			if("0".equals(params.get("session_member_group_seq"))){//비회원일 경우
				if("form".equals(type)){
					result = true;
				}else{
					if("Y".equals(params.get("lot_yn"))){//설문조사시 회원정보를 받을 경우
						m.put("poll_seq", params.get("poll_seq"));
						m.put("reg_tel", tel);
						check = dao.joinCheck(m);
						if("0".equals(String.valueOf(check.get("cnt")))){
							result = true;
						}else{
							params.put("cnt", "1");
						}
					}else{//회원정보를 받지 않을 경우 비회원은 계속 참여가능
						result = true;
					}
				}			
			}else{//비회원이 아닐 경우
				m.put("poll_seq", params.get("poll_seq"));
				m.put("reg_id", params.get("session_member_id"));
				check = dao.joinCheck(m);
				if("0".equals(String.valueOf(check.get("cnt")))){
					result = true;
				}else{
					params.put("cnt", "1");
				}
			}
			return result;
		}
	}
}
