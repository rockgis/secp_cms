package com.mc.web.programs.front.bbs.{{BOARD_TYPE}}.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.mc.common.util.RequestSnack;
import com.mc.common.util.StringUtil;
import com.mc.web.MCMap;
import com.mc.web.programs.back.filter.FilterService;
import com.mc.web.attach.AttachDAO;
import com.mc.web.attach.AttachService;
import com.mc.web.programs.front.bbs.BbsDAO;
import com.mc.web.programs.front.bbs.BbsServiceAbst;
import com.mc.web.programs.front.bbs.{{BOARD_TYPE}}.Bbs{{BOARD_TYPE}}Service;
import com.mc.web.common.FileUtil;
import com.mc.web.common.MCDoubleSubmitHelper;
import com.mc.web.service.Globals;

import egovframework.com.cmm.util.EgovHttpRequestHelper;

@Service("Bbs{{BOARD_TYPE}}Service")
public class Bbs{{BOARD_TYPE}}ServiceImpl extends BbsServiceAbst implements Bbs{{BOARD_TYPE}}Service{
	
	@Autowired
	private BbsDAO dao;

	@Autowired
	private AttachDAO attachDAO;

	@Autowired
	private FileUtil fileUtil;
	
	@Autowired
	private AttachService attachService;
	
	@Autowired
	private FilterService filterService;
	
	public String list(Map params) throws Exception {
		HttpServletRequest request = EgovHttpRequestHelper.getCurrentRequest();
		Map boardInfo = (Map)boardInfo(params).get("info");
		params.put("list_row", boardInfo.get("list_row"));
		RequestSnack.setPageParams(params);
		
		Map pagination = dao.pagination(params);
		if(pagination.get("cat_yn").equals("Y")){
			request.setAttribute("catlist",catList(params));
		}
		request.setAttribute("boardInfo", boardInfo);
		request.setAttribute("notice_list", dao.notice_list(params));
		request.setAttribute("list", dao.list(params));
		request.setAttribute("pagination", pagination);
		request.setAttribute("params", params);
		return "bbs/{{BOARD_TYPE}}/list";
	}
	
	public String insertForm(Map params) throws Exception {
		HttpServletRequest request = EgovHttpRequestHelper.getCurrentRequest();
		Map boardInfo = (Map)boardInfo(params).get("info");
		if(authCheck("C", params)){
			if(boardInfo.get("cat_yn").equals("Y")){
				request.setAttribute("cat",catList(params));
			}
			request.setAttribute("boardInfo", boardInfo);
			return "bbs/{{BOARD_TYPE}}/insertForm";
		}else{
			HttpSession session = EgovHttpRequestHelper.getCurrentSession();
			MCMap member = (MCMap)session.getAttribute("member");
			if(member == null){
				request.setAttribute("message", "????????? ??? ??????????????? ????????????.");
			}else{
				request.setAttribute("message", "????????? ????????????.");
			}
			return "message";
		}
	}

	@Override
	public String insert(Map params, List<MultipartFile> attachList) throws Exception {
		HttpServletRequest request = EgovHttpRequestHelper.getCurrentRequest();
		Map boardInfo = (Map)boardInfo(params).get("info");
			if(authCheck("C", params)){//????????????
				if (MCDoubleSubmitHelper.checkAndSaveToken(params)) {//??? ?????? ?????? ??????  
					dao.write(params);
					if(params.get("file_yn").equals("Y")){
						List list = fileUtil.upload(attachList, Integer.parseInt((String)params.get("limit_file_size")), request.getSession().getServletContext().getRealPath(Globals.FILE_PATH));
						if(list != null){
							for (int i = 0; i < list.size(); i++) {
								Map m = (Map) list.get(i);
								m.put("order_seq", i+1);
								m.put("table_nm", "MC_ARTICLE");
								m.put("table_seq", params.get("article_seq"));
								m.put("session_member_id", params.get("session_member_id"));
								m.put("session_member_nm", params.get("session_member_nm"));
								m.put("ip", params.get("ip"));
								attachDAO.insert(m);
							}
						}
					}
					//??????????????? ??????,????????? ???
					Map p = new HashMap();
					p.put("site_id", request.getAttribute("site_id"));
					p.put("t_menu_seq", request.getAttribute("menu_seq"));
					p.put("sub_seq", params.get("article_seq"));
					p.put("title", params.get("title"));
					filterService.report_update(p);
					return "redirect:list.do";
			    }else{
			    	request.setAttribute("message", "?????? ????????? ????????? ????????????.");
			    	request.setAttribute("redirect", "list.do");
					return "message";
			    }
			}else{
				request.setAttribute("message", "????????? ????????????.");
				return "message";
			}
	}

	public String view(Map params) throws Exception {
		HttpServletRequest request = EgovHttpRequestHelper.getCurrentRequest();
		Map boardInfo = (Map)boardInfo(params).get("info");
		if(authCheck("R",params)){//????????????
			Map rstMap = new HashMap();
			request.setAttribute("boardInfo", boardInfo);
			Map public_yn = dao.view(params);//??????????????? ??????
			
			String passwdCheck = passwdCheck(boardInfo,public_yn,(String)params.get("password"));
			
			if("1".equals(passwdCheck) || "Y".equals(public_yn.get("public_yn"))){
				dao.viewcount(params);
				Map view = dao.view(params);
				rstMap.put("view", view);
				params.put("table_nm", "MC_ARTICLE");
				params.put("table_seq", params.get("article_seq"));
				rstMap.put("files", attachDAO.list(params));
				
				/*	????????? ????????? */
				Map prev = new HashMap();
				MCMap map = dao.prev_seq(params);
				if(map != null){
					prev.put("article_seq", map.getStrNull("article_seq"));
					Map prev_view = dao.view(prev);
					rstMap.put("prev", prev_view);
				}
				
				Map next = new HashMap();
				map = dao.next_seq(params);
				if(map != null){
					next.put("article_seq", map.getStrNull("article_seq"));
					Map next_view = dao.view(next);
					rstMap.put("next", next_view);
				}
				
				request.setAttribute("data", rstMap);
				request.setAttribute("params", params);
				return "bbs/{{BOARD_TYPE}}/view";
			}else if(passwdCheck.equals("0")){
				//???????????? ????????????
				request.setAttribute("params", params);
				return "bbs/{{BOARD_TYPE}}/password";
			}else if(passwdCheck.equals("2")){
				//????????? ???????????? ??????
				request.setAttribute("message", "??????????????? ??????????????????");
				return "message";
			}else{
				//????????? ?????????????????? ?????? ??????
				request.setAttribute("message", "????????? ????????????.");
				return "message";
			}			
		}else{
			request.setAttribute("message", "????????? ????????????.");
			return "message";
		}
	}
	
	public String modifyForm(Map params) throws Exception {
		HttpServletRequest request = EgovHttpRequestHelper.getCurrentRequest();
		Map boardInfo = (Map)boardInfo(params).get("info");
		if(authCheck("U",params)){//????????????
			
			Map view = dao.view(params);
			String passwdCheck = passwdCheck(boardInfo,view,(String)params.get("password"));
			if(passwdCheck.equals("1")){//????????? ???????????? ??????
				Map rstMap = new HashMap();
				request.setAttribute("boardInfo", boardInfo);
				Map public_yn = dao.view(params);//??????????????? ??????
				
				rstMap.put("view", view);
				params.put("table_nm", "MC_ARTICLE");
				params.put("table_seq", params.get("article_seq"));
				rstMap.put("files", attachDAO.list(params));
				request.setAttribute("data", rstMap);
				return "bbs/{{BOARD_TYPE}}/modifyForm";
			}else if(passwdCheck.equals("0")){//???????????? ?????? ??????
				request.setAttribute("params", params);
				return "bbs/{{BOARD_TYPE}}/password";
			}else{//???????????? ?????? ??????
				request.setAttribute("message", "????????? ????????????.");
				return "message";
			}
		}else{
			request.setAttribute("message", "????????? ????????????.");
			return "message";
		}
	}

	@Override
	public String modify(Map params, List<MultipartFile> attachList, List<String> delAttachList) throws Exception {
		HttpServletRequest request = EgovHttpRequestHelper.getCurrentRequest();
		Map boardInfo = (Map)boardInfo(params).get("info");
			if(authCheck("C", params)){//????????????
				
				if (MCDoubleSubmitHelper.checkAndSaveToken(params)) {//??? ?????? ?????? ??????  
					dao.modify(params);
					Map delMap = new HashMap();
					int order_seq = 1;
					if(delAttachList != null){//?????? ???????????? ??????
						for (int i = 0; i < delAttachList.size(); i++) {
							delMap.put("uuid", delAttachList.get(i));
							attachService.remove(delMap);
						}
						List getFileList = (List)attachDAO.list(params);//????????? ??? ????????? ????????? ???????????? ?????????
						attachDAO.delete_all(params);//?????? ??????
						for (int i = 0; i < getFileList.size(); i++) {
							Map m = (Map) getFileList.get(i);
							m.put("order_seq",order_seq++);//?????? ??????
							m.put("table_nm", "MC_ARTICLE");
							m.put("table_seq", params.get("article_seq"));
							m.put("session_member_id", m.get("reg_id"));
							m.put("session_member_nm", m.get("reg_nm"));
							attachDAO.insert(m);//?????? ?????? ????????????
						}
					}
					List<Map<String,String>> fileList = new ArrayList<Map<String,String>>();
					if(attachList != null){
						fileList = fileUtil.upload(attachList, Integer.parseInt((String)params.get("limit_file_size")), request.getSession().getServletContext().getRealPath(Globals.FILE_PATH));
						for (int i = 0; i < fileList.size(); i++) {
							Map m = (Map) fileList.get(i);
							m.put("order_seq", order_seq++);
							m.put("table_nm", "MC_ARTICLE");
							m.put("table_seq", params.get("article_seq"));
							m.put("session_member_id", params.get("session_member_id"));
							m.put("session_member_nm", params.get("session_member_nm"));
							m.put("ip", params.get("ip"));
							attachDAO.insert(m);
						}
					}
					//??????????????? ??????,????????? ???
					Map p = new HashMap();
					p.put("site_id", request.getAttribute("site_id"));
					p.put("t_menu_seq", request.getAttribute("menu_seq"));
					p.put("sub_seq", params.get("article_seq"));
					p.put("title", params.get("title"));
					filterService.report_update(p);
					return "redirect:list.do";
			    }else{
			    	request.setAttribute("message", "?????? ????????? ????????? ????????????.");
			    	request.setAttribute("redirect", "list.do");
					return "message";
			    }
			}else{
				request.setAttribute("message", "????????? ????????????.");
				return "message";
			}
	}
	
	public String delete(Map params) throws Exception {
		HttpServletRequest request = EgovHttpRequestHelper.getCurrentRequest();
		Map boardInfo = (Map)boardInfo(params).get("info");
			if(authCheck("D",params)){//????????????
				
				Map view = dao.view(params);
				String passwdCheck = passwdCheck(boardInfo,view,(String)params.get("password"));
				if(passwdCheck.equals("1")){//????????? ???????????? ??????
					List<String> deleteList = StringUtil.strToList((String)params.get("article_seq"), ",");
					params.put("seq_list", deleteList);
					dao.delete(params);
					//??????????????? ????????? ???
					for (String seq : deleteList) {
						filterService.report_delete(String.valueOf(request.getAttribute("menu_seq")), seq);
					}
					return "redirect:list.do";
				}else if(passwdCheck.equals("0")){//???????????? ?????? ??????
					//???????????? ????????????
					request.setAttribute("params", params);
					return "bbs/{{BOARD_TYPE}}/password";
				}else{//???????????? ?????? ??????
					request.setAttribute("message", "????????? ????????????.");
					return "message";
				}
			}else{
				request.setAttribute("message", "????????? ????????????.");
				return "message";
			}
	}
}
