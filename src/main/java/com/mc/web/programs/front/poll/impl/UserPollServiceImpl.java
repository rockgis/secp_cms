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
						for(int i=0; i < question.size(); i++){//?????? ??????
							Map m = (Map)question.get(i);
							if("-1".equals(String.valueOf(m.get("seq"))) && "N".equals(String.valueOf(m.get("del_yn")))){
								question_list.add(m);
							}
						}
						for(int i=0; i < question_list.size(); i++){//?????? ??????
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
					}else{//????????? ?????? ????????? ?????? ?????? ????????????
						if(view.containsKey("cnt")){
							request.setAttribute("message", "?????? ??????????????? ?????????????????????.");
						}else{
							request.setAttribute("message", "???????????? ????????? ????????????.");
						}
						//request.setAttribute("redirect","result.do?"+queryString);
						return "message";
					}
				}else{
					request.setAttribute("message", "???????????? ????????? ????????????.");
					//request.setAttribute("redirect","result.do?"+queryString);
					return "message";
				}
			}else if("0".equals(view.get("stat_num"))){
				request.setAttribute("message", "???????????? ????????? ????????????.");
				return "message";
			}else{//????????? ?????? ?????? ?????? ????????????
				request.setAttribute("redirect","result.do?"+queryString);
				return "message";
			}
		}else{
			request.setAttribute("message", "????????? ?????? ???????????????.");
	    	return "message";
		}
	}
	
	public synchronized String join(Map<String, String> params) throws Exception {//insertSEQ??? ?????? ????????? ?????? synchronized ??????
		HttpServletRequest request = EgovHttpRequestHelper.getCurrentRequest();
		String queryString = "poll_seq="+request.getParameter("poll_seq")+"&cpage="+request.getParameter("cpage")+"&rows="+request.getParameter("rows")+"&condition="+request.getParameter("condition")+"&keyword="+request.getParameter("keyword");
		String path = request.getAttribute("javax.servlet.forward.servlet_path").toString();
		path = path.replace("delete.do", "list.do");
		Map view = (Map)dao.article(params);		
		if (MCDoubleSubmitHelper.checkAndSaveToken(params)) {//?????? ?????? ??????
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
									insert.put("session_member_nm", "?????????");
								}else{
									insert.put("session_member_nm", view.get("session_member_nm"));
								}
								insert.put("session_member_id", view.get("session_member_id"));
								insert.put("reg_tel", "--");
								insert.put("reg_email", "");
							}
							if("A".equals(m.get("question_type"))){//????????????
								if(params.get(String.valueOf(m.get("question_seq"))) != null){//?????? ???????????? DISABLE??? ????????? ??????
									insert.put("answer_seq", params.get(String.valueOf(m.get("question_seq"))));
									dao.insertResult(insert);
								}
							}else if("B".equals(m.get("question_type"))){//????????????
								String[] answer_list = request.getParameterValues(String.valueOf(m.get("question_seq")));
								if(answer_list != null){
									for(String str : answer_list){
										insert.put("answer_seq", str);
										dao.insertResult(insert);
									}
								}
							}else if("C".equals(m.get("question_type"))){//?????????
								if(params.get(String.valueOf(m.get("question_seq"))) != null){//?????? ???????????? DISABLE??? ????????? ??????
									insert.put("answer_seq", "0");
									insert.put("answer", params.get(String.valueOf(m.get("question_seq"))));
									dao.insertResult(insert);
								}
							}else if("D".equals(m.get("question_type"))){
								if(params.get(String.valueOf(m.get("question_seq"))) != null){//?????? ???????????? DISABLE??? ????????? ??????
									insert.put("answer_seq", params.get(String.valueOf(m.get("question_seq"))));
									Map jumpCheck = dao.jumpTypeCheck(insert);
									if("Y".equals(jumpCheck.get("jump_chk"))){//?????? ????????? DISABLE?????? ??????
										typeD = false;
									}
									dao.insertResult(insert);
								}
							}else if("E".equals(m.get("question_type"))){
								if(params.get(String.valueOf(m.get("question_seq"))) != null){//?????? ???????????? DISABLE??? ????????? ??????
									insert.put("answer_seq", params.get(String.valueOf(m.get("question_seq"))));
									Map jumpCheck = dao.jumpTypeCheck(insert);
									if("Y".equals(jumpCheck.get("jump_chk"))){//????????? ????????? TEXTAREA??? ????????? ??????
										insert.put("answer", params.get(String.valueOf(m.get("question_seq"))+"_t_"+String.valueOf(params.get(String.valueOf(m.get("question_seq"))))));
									}
									dao.insertResult(insert);
								}
							}							
						}
						request.setAttribute("message", "??????????????? ?????????????????????.");
						//request.setAttribute("redirect","result.do?"+queryString);
						request.setAttribute("redirect",path);
						return "message";
					}else{
						request.setAttribute("message", "?????? ???????????? ?????????????????????.");
						request.setAttribute("redirect",path);
						//request.setAttribute("redirect","result.do?"+queryString);
						return "message";
					}
				}else{
					request.setAttribute("message", "????????? ?????? ???????????????.");
			    	return "message";
				}
			}else if("0".equals(view.get("stat_num"))){
				request.setAttribute("message", "???????????? ????????? ????????????.");
				return "message";
			}else{//????????? ?????? ?????? ?????? ????????????
				request.setAttribute("redirect","result.do"+queryString);
				return "message";
			}
		}else{
			request.setAttribute("message", "?????? ????????? ????????? ????????????.");
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
				for(int i=0; i < question_list.size(); i++){//?????? ??????
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
				request.setAttribute("message", "???????????? ????????? ????????????.");
				return "message";
			}
		/*}else{
			request.setAttribute("message", "????????? ????????????.");
			return "message";
		}*/
	}
	
	
	
	public boolean authCheck(Map params,String getName) {
		/*
		 * -1 : ????????????
		 * 0 : ?????????
		 * 1 : ???????????????
		 * 2 : ?????? ?????????
		 * ??????????????? ?????? ?????? ?????? ?????? ??????
		 * 
		 */
		boolean rst = false;
		Map authMap = new HashMap();
		Map authInfoMap = new HashMap();
		SessionInfo.userSessionAuth(params);
		String session_member_group_seq = String.valueOf(params.get("session_member_group_seq"));
		if(params.get(getName) != null){
			if(session_member_group_seq != null){
				if(!"1".equals(session_member_group_seq)){//??????????????? ?????? ??????
					String getGroupNames = String.valueOf(params.get(getName));
					if(!"".equals(getGroupNames) && getGroupNames != null){//????????? ????????? ?????? ?????? ??????
						String[] getGroupName = getGroupNames.split(",");
						for(int i=0; i < getGroupName.length; i++){
							String[] getGroup = getGroupName[i].split(":");
							authMap.clear();
							List authList = null;
							if(!"-1".equals(getGroup[0]) && !"0".equals(getGroup[0])){
								authMap.put("group_seq", getGroup[0]);
								authList = dao.userAuthCheck(authMap);
							}
							if(authList != null){//?????? ????????? ?????? ??????
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
		if("1".equals(session_member_group_seq)){//??????????????? ?????? ??????
			rst = true;
		}
		return rst;
	}
	
	private boolean joinAuthCheck(Map params, String type, String tel){
		if("N".equals(params.get("dup_yn"))){
			return true;
		}
		boolean pass = true; //?????? ????????????
		if(pass){
			return pass;
		}else{
			boolean result = false;
			Map m = new HashMap();
			Map check = null;
			if("0".equals(params.get("session_member_group_seq"))){//???????????? ??????
				if("form".equals(type)){
					result = true;
				}else{
					if("Y".equals(params.get("lot_yn"))){//??????????????? ??????????????? ?????? ??????
						m.put("poll_seq", params.get("poll_seq"));
						m.put("reg_tel", tel);
						check = dao.joinCheck(m);
						if("0".equals(String.valueOf(check.get("cnt")))){
							result = true;
						}else{
							params.put("cnt", "1");
						}
					}else{//??????????????? ?????? ?????? ?????? ???????????? ?????? ????????????
						result = true;
					}
				}			
			}else{//???????????? ?????? ??????
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
