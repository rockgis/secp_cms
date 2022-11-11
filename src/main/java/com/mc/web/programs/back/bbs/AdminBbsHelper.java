package com.mc.web.programs.back.bbs;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mc.common.util.StringUtil;
import com.mc.web.programs.back.filter.FilterHelper;
import com.mc.web.attach.AttachDAO;
import com.mc.web.common.FileUtil;
import com.mc.web.service.Globals;

@Service
public class AdminBbsHelper {
	Logger logger = Logger.getLogger(this.getClass());
	
	@Autowired
	private AdminBbsDAO dao;
	
	@Autowired
	private FilterHelper helper;
	
	@Autowired
	private AttachDAO attachDAO;
	
	@Autowired
	private FileUtil fileUtil;

	public void articleFileUpload(Map params, HttpServletRequest request) throws IOException {
		List list = (List) params.get("files");
		if(list != null){
			for (int i = 0; i < list.size(); i++) {
				Map m = (Map) list.get(i);
				m.put("order_seq", i+1);
				m.put("table_nm", "MC_ARTICLE");
				m.put("table_seq", params.get("article_seq"));//mysql auto_increment 의 값을 가져온 값
				m.put("session_member_id", params.get("session_member_id"));
				m.put("session_member_nm", params.get("session_member_nm"));
				m.put("ip", params.get("ip"));
				String path = request.getSession().getServletContext().getRealPath(Globals.FILE_PATH + File.separator + m.get("yyyy") + File.separator + m.get("mm"));
				attachDAO.insert(m);
				fileUtil.copy(request.getSession().getServletContext().getRealPath(Globals.TEMP_PATH) + File.separator + m.get("uuid"), path + File.separator + m.get("uuid"),path);
			}
		}
	}
	
	//게시물 예약 등록시 첨부파일(article_seq 없이 등록 후 예약등록되고 나면 article_seq 업데이트)
	public void articleFileUploadTemp(Map params, HttpServletRequest request) throws IOException {
		List list = (List) params.get("files");
		if(list != null){
			for (int i = 0; i < list.size(); i++) {
				Map m = (Map) list.get(i);
				m.put("order_seq", i+1);
				m.put("table_nm", "MC_ARTICLE");
				m.put("table_seq", params.get("article_seq"));
				m.put("session_member_id", params.get("session_member_id"));
				m.put("session_member_nm", params.get("session_member_nm"));
				m.put("ip", params.get("ip"));
				String path = request.getSession().getServletContext().getRealPath(Globals.FILE_PATH + File.separator + m.get("yyyy") + File.separator + m.get("mm"));
				attachDAO.insertTemp(m);
				fileUtil.copy(request.getSession().getServletContext().getRealPath(Globals.TEMP_PATH) + File.separator + m.get("uuid"), path + File.separator + m.get("uuid"),path);
			}
		}
	}
	
	public void articleThumb(Map params, HttpServletRequest request) throws Exception {
		if(params.get("thumb") != null && !("").equals(params.get("thumb"))){
			String thumb = (String)params.get("thumb");
			String filepath = request.getSession().getServletContext().getRealPath(thumb);
			int resultInt = fileUtil.thumb(filepath, filepath+"_thumb" , 172, 118, false);
			if(resultInt == 1){
				params.put("thumb",params.get("thumb")+"_thumb");
			}
		}
	}

	public Map articleMove(Map params) throws Exception {
		Map rstMap = new HashMap();
		try{
			List deleteList = StringUtil.strToList((String)params.get("article_seq"), ",");
			params.put("seq_list", deleteList);
			dao.articleMove(params);
			rstMap.put("msg", "게시물이 이동되었습니다.");
		}catch(Exception e){
			rstMap.put("msg", "게시물중 에러가 발새하였습니다.");
		}
		return rstMap;
	}
	
	/*public void personal_data_report(Map params,Map boardInfo){//개인정보 필터링
		Map m = new HashMap();
		Map rst = new HashMap();
		//기본정보 입력
		m.put("conts", params.toString());
		m.put("table_nm", "MC_ARTICLE");
		m.put("table_seq", params.get("article_seq"));
		m.put("board_seq", params.get("board_seq"));
		
		if("Y".equals(boardInfo.get("busino_yn"))){//사업자
			rst.clear();
			rst = helper.businoFilter(m);
			m.put("busino_yn", rst.get("busino_filter"));
			if("Y".equals(rst.get("busino_filter"))){
				m.put("busino_conts", rst.get("filter_conts"));
			}
		}
		if("Y".equals(boardInfo.get("jumin_yn"))){//주민번호
			rst.clear();
			rst = helper.juminFilter(m);
			m.put("jumin_yn", rst.get("jumin_filter"));
			if("Y".equals(rst.get("jumin_filter"))){
				m.put("jumin_conts", rst.get("filter_conts"));
			}
		}
		if("Y".equals(boardInfo.get("email_yn"))){//이메일
			rst.clear();
			rst = helper.emailFilter(m);
			m.put("email_yn", rst.get("email_filter"));
			if("Y".equals(rst.get("email_filter"))){
				m.put("email_conts", rst.get("filter_conts"));
			}
		}
		if("Y".equals(boardInfo.get("cell_yn"))){//휴대전화
			rst.clear();
			rst = helper.cellFilter(m);
			m.put("cell_yn", rst.get("cell_filter"));
			if("Y".equals(rst.get("cell_filter"))){
				m.put("cell_conts", rst.get("filter_conts"));
			}
		}
		if("Y".equals(boardInfo.get("tel_yn"))){//전화번호
			rst.clear();
			rst = helper.telFilter(m);
			m.put("tel_yn", rst.get("tel_filter"));
			if("Y".equals(rst.get("tel_filter"))){
				m.put("tel_conts", rst.get("filter_conts"));
			}
		}
		if("Y".equals(boardInfo.get("bubino_yn"))){//법인번호
			rst.clear();
			rst = helper.bubinoFilter(m);
			m.put("bubino_yn", rst.get("bubino_filter"));
			if("Y".equals(rst.get("bubino_filter"))){
				m.put("bubino_conts", rst.get("filter_conts"));
			}
		}
		if("Y".equals(boardInfo.get("card_yn"))){//법인번호
			rst.clear();
			rst = helper.cardFilter(m);
			m.put("card_yn", rst.get("card_filter"));
			if("Y".equals(rst.get("card_filter"))){
				m.put("card_conts", rst.get("filter_conts"));
			}
		}
		dao.personal_report(m);
	}*/
}