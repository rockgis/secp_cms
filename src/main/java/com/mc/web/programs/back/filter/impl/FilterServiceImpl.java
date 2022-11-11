package com.mc.web.programs.back.filter.impl;

import java.io.OutputStream;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.DataFormat;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.Row;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;
import org.jsoup.helper.StringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mc.web.MCMap;
import com.mc.web.programs.back.filter.FilterDAO;
import com.mc.web.programs.back.filter.FilterHelper;
import com.mc.web.programs.back.filter.FilterService;
import com.mc.web.common.SessionInfo;

import egovframework.com.cmm.util.EgovHttpRequestHelper;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service("FilterService")
public class FilterServiceImpl extends EgovAbstractServiceImpl implements FilterService{
	
	@Autowired
	private FilterDAO dao;
	
	@Autowired
	private FilterHelper helper;
	
	public Map dashboardData(Map params) throws Exception {
		Map rstMap = new HashMap();
		rstMap.put("dashboardSetStatus", dao.dashboardSetStatus(params)); 
		rstMap.put("dashboardChart1", dao.dashboardChart1(params)); 
		rstMap.put("dashboardChart2", dao.dashboardChart2(params)); 
		return rstMap;
	}
	
	public Map daylistData(Map params) throws Exception {
		Map rstMap = new HashMap();
		rstMap.put("daylistData", dao.daylistChart(params)); 
		return rstMap;
	}
	
	public Map menulistData(Map params) throws Exception {
		Map rstMap = new HashMap();
		rstMap.put("list", dao.daylist(params));
		rstMap.put("pagination", dao.daylist_pagination(params));
		return rstMap;
	}
	
	public Map setting(Map params) throws Exception {
		Map rstMap = new HashMap();
		rstMap.put("default_filter", dao.get_default_filter(params));
		rstMap.put("list", dao.list(params));
		rstMap.put("pagination", dao.pagination(params));
		return rstMap;
	}
	
	public Map set_default_filter(Map params) throws Exception {
		SessionInfo.sessionAuth(params);
		Map rstMap = new HashMap();
		dao.set_default_filter(params);
		rstMap.put("rst", dao.set_default_filter_all(params));
		return rstMap;
	}
	
	public Map set_menu_filter(Map params) throws Exception {
		SessionInfo.sessionAuth(params);
		Map rstMap = new HashMap();
		if("Y".equals(params.get("filter_yn"))){
			rstMap.put("rst", dao.set_menu_filter(params));
		}else{
			rstMap.put("rst", dao.del_filter(params));
		}
		return rstMap;
	}
	
	public Map set_each_filter(Map params) throws Exception {
		SessionInfo.sessionAuth(params);
		Map rstMap = new HashMap();
		rstMap.put("rst", dao.set_menu_filter(params));
		return rstMap;
	}
	
	public Map get_menu_filter(Map params) throws Exception {
		return dao.get_menu_filter(params);
	}

	public Map modify(Map params) throws Exception {
		SessionInfo.sessionAuth(params);
		Map rstMap = new HashMap();
		rstMap.put("rst", dao.modify(params));
		return rstMap;
	}
	
	public Map check(HttpServletRequest request,Map params) throws Exception {
		Map rstMap = new HashMap();
		List<String> nameList = Arrays.asList(new String[]{"contents", "conts","title"});
		Map p = new HashMap();
		p.put("site_id", params.get("site_id"));
		if(com.mc.common.util.StringUtil.isEmptyByParam(params, "t_menu_seq")){
			p.put("cms_menu_seq", params.get("cms_menu_seq"));
		}else{
			p.put("cms_menu_seq", params.get("t_menu_seq"));
		}
		MCMap fmap = dao.get_menu_filter(p);
		List<String> juminList = new ArrayList<String>();
		List<String> emailList = new ArrayList<String>();
		List<String> businoList = new ArrayList<String>();
		List<String> bubinoList = new ArrayList<String>();
		List<String> cardList = new ArrayList<String>();
		List<String> telList = new ArrayList<String>();
		List<String> cellList = new ArrayList<String>();
		List<String> textList = new ArrayList<String>();

		String key = null;
		String val = null;
		if(request.getParameter("jData")!=null) { //관리자페이지
			Map sp = (JSONObject) JSONValue.parse((String)request.getParameter("jData"));	//JSON으로 보내준 데이터를 사용
			Iterator<String> it = sp.keySet().iterator();
			for (String k : nameList) {
				val = (String)sp.get(k);
				if(val == null){
					continue;
				}
				helper.juminFilter(juminList, val);
				helper.emailFilter(emailList, val);
				helper.businoFilter(businoList, val);
				helper.bubinoFilter(bubinoList, val);
				helper.cardFilter(cardList, val);
				helper.telFilter(telList, val);
				helper.cellFilter(cellList, val);
				helper.textFilter(textList, fmap.getStrNull("forbidden_word"), val);
			}
		}else {//사용자페이지
			Enumeration enumeration = request.getParameterNames();
			while(enumeration.hasMoreElements()){
				key = (String)enumeration.nextElement();
				if(!nameList.contains(key)){
					continue;
				}
				val = request.getParameter(key);
				helper.juminFilter(juminList, val);
				helper.emailFilter(emailList, val);
				helper.businoFilter(businoList, val);
				helper.bubinoFilter(bubinoList, val);
				helper.cardFilter(cardList, val);
				helper.telFilter(telList, val);
				helper.cellFilter(cellList, val);
				helper.textFilter(textList, fmap.getStrNull("forbidden_word"), val);
			}
		}
		if(juminList.size()>0 || emailList.size()>0 || businoList.size()>0 || bubinoList.size()>0 || cardList.size()>0 || telList.size()>0 || cellList.size()>0 || textList.size()>0){
			rstMap.put("_jumin_yn", fmap.getStrNullVal("jumin_yn", "N"));
			rstMap.put("_email_yn", fmap.getStrNullVal("email_yn", "N"));
			rstMap.put("_busino_yn", fmap.getStrNullVal("busino_yn", "N"));
			rstMap.put("_bubino_yn", fmap.getStrNullVal("bubino_yn", "N"));
			rstMap.put("_tel_yn", fmap.getStrNullVal("tel_yn", "N"));
			rstMap.put("_cell_yn", fmap.getStrNullVal("cell_yn", "N"));
			rstMap.put("_card_yn", fmap.getStrNullVal("card_yn", "N"));

			rstMap.put("jumin_cnt", juminList.size());
			rstMap.put("email_cnt", emailList.size());
			rstMap.put("busino_cnt", businoList.size());
			rstMap.put("bubino_cnt", bubinoList.size());
			rstMap.put("tel_cnt", telList.size());
			rstMap.put("cell_cnt", cellList.size());
			rstMap.put("card_cnt", cardList.size());
			rstMap.put("text_cnt", textList.size());
			rstMap.put("juminList", juminList);
			rstMap.put("emailList", emailList);
			rstMap.put("businoList", businoList);
			rstMap.put("bubinoList", bubinoList);
			rstMap.put("telList", telList);
			rstMap.put("cellList", cellList);
			rstMap.put("cardList", cardList);
			rstMap.put("textList", textList);
			rstMap.put("jumin_conts", StringUtil.join(juminList, ","));
			rstMap.put("email_conts", StringUtil.join(emailList, ","));
			rstMap.put("busino_conts", StringUtil.join(businoList, ","));
			rstMap.put("bubino_conts", StringUtil.join(bubinoList, ","));
			rstMap.put("tel_conts", StringUtil.join(telList, ","));
			rstMap.put("cell_conts", StringUtil.join(cellList, ","));
			rstMap.put("card_conts", StringUtil.join(cardList, ","));
			rstMap.put("text_conts", StringUtil.join(textList, ","));
		}else{
			rstMap.put("clean", "Y");
		}
		return rstMap;
	}
	
	public void report_update(Map params) throws Exception {
		HttpServletRequest request = EgovHttpRequestHelper.getCurrentRequest();
		Map rst = check(request, params);
		rst.put("site_id", params.get("site_id"));
		rst.put("cms_menu_seq", params.get("t_menu_seq"));
		rst.put("sub_seq", params.get("sub_seq"));
		rst.put("title", params.get("title"));
		if(!"Y".equals(rst.get("clean"))){//추가,수정
			report_record(rst);
		}else{//삭제
			report_delete(String.valueOf(params.get("t_menu_seq")), String.valueOf(params.get("sub_seq")));
		}
	}
	
	public Map report_record(Map params) throws Exception {
		Map rstMap = new HashMap();
		rstMap.put("rst", dao.report_record(params));
		return rstMap;
	}
	
	public Map report_delete(String cms_menu_seq, String sub_seq) throws Exception {
		Map rstMap = new HashMap();
		Map p = new HashMap();
		p.put("cms_menu_seq", cms_menu_seq);
		p.put("sub_seq", sub_seq);
		rstMap.put("rst", dao.report_delete(p));
		return rstMap;
	}
	
	public Map reportList(Map params) throws Exception {
		Map rstMap = new HashMap();
		rstMap.put("total_list", dao.report_list_all(params));
		rstMap.put("list", dao.report_list(params));
		rstMap.put("pagination", dao.report_pagination(params));
		return rstMap;
	}
	
	public Map detailList(Map params) throws Exception {
		Map rstMap = new HashMap();
		rstMap.put("list", dao.detail_list(params));
		rstMap.put("pagination", dao.detail_pagination(params));
		return rstMap;
	}
	
	public String report_excel(HttpServletResponse res, Map<String, String> params) throws Exception {
		List<MCMap> list = dao.report_list_all(params);
		
		HSSFWorkbook xlsxWb = new HSSFWorkbook(); // Excel 2007 이전 버전
		// Sheet 생성
		HSSFSheet sheet1 = xlsxWb.createSheet("개인정보 필터분석");
		HSSFSheet sheet2 = xlsxWb.createSheet("차트");
        DataFormat format = xlsxWb.createDataFormat();
        
//      Cell 스타일 생성
        HSSFFont tf = xlsxWb.createFont();
        tf.setFontHeightInPoints((short) 12);
        tf.setColor(HSSFColor.BLACK.index);
        tf.setFontName("맑은 고딕");
        tf.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD); //폰트굵게
        
        HSSFFont f = xlsxWb.createFont();
        f.setFontHeightInPoints((short) 10);
        f.setColor(HSSFColor.BLACK.index);
        f.setFontName("맑은 고딕");
        
        //기본 스타일
        CellStyle dcs = xlsxWb.createCellStyle();
        dcs.setAlignment(HSSFCellStyle.ALIGN_CENTER);
        dcs.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
        dcs.setBorderBottom(HSSFCellStyle.BORDER_THIN);
        dcs.setBorderLeft(HSSFCellStyle.BORDER_THIN);
        dcs.setBorderRight(HSSFCellStyle.BORDER_THIN);
        dcs.setBorderTop(HSSFCellStyle.BORDER_THIN);
        dcs.setWrapText(true);//자동줄바꿈

        //타이틀 스타일
        CellStyle tcs = xlsxWb.createCellStyle();
        tcs.cloneStyleFrom(dcs);
        tcs.setFont(tf);
        tcs.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.index);
        tcs.setFillPattern(CellStyle.SOLID_FOREGROUND);

        //기본 문자 스타일
        CellStyle cs = xlsxWb.createCellStyle();
        cs.cloneStyleFrom(dcs);
        cs.setFont(f);
        
        //날짜 스타일
        CellStyle dc = xlsxWb.createCellStyle();
        dc.cloneStyleFrom(dcs);
        dc.setDataFormat(format.getFormat("m/d/yy h:mm"));
        
        //숫자 스타일
        CellStyle nc = xlsxWb.createCellStyle();
        nc.cloneStyleFrom(dcs);
        nc.setDataFormat(format.getFormat("#,##0"));
        
        //화폐 스타일
        CellStyle bc = xlsxWb.createCellStyle();
        bc.cloneStyleFrom(dcs);
        bc.setDataFormat(format.getFormat("₩#,##0"));
         
        Row row = null;
        Cell cell = null;
        //----------------------------------------------------------

        // 첫 번째 줄
        row = sheet1.createRow(0);
        
        String[] header = new String[]{"메뉴명", "전체", "주민번호", "이메일", "카드번호", "사업자번호", "법인번호", "휴대전화번호", "일반전화번호"};
        if (header[0] != null && header.length > 0){
			for(int i=0;i<header.length;i++){
				cell = row.createCell(i);
				cell.setCellValue(header[i]);
		        cell.setCellStyle(tcs);
			}
		}
        
        //두번째 줄부터 데이터 입력
        row = sheet1.createRow(1);
        for (MCMap mp : list) {
			cell = row.createCell(0);
			cell.setCellValue(mp.getStrNull("menu_nm"));
			cell.setCellStyle(cs);

			cell = row.createCell(1);
			cell.setCellValue(mp.getStrNull("total")+"건");
			cell.setCellStyle(cs);
			
			cell = row.createCell(2);
			cell.setCellValue(mp.getStrNull("jumin_total")+"건");
			cell.setCellStyle(cs);
			
			cell = row.createCell(3);
			cell.setCellValue(mp.getStrNull("email_total")+"건");
			cell.setCellStyle(cs);
			
			cell = row.createCell(4);
			cell.setCellValue(mp.getStrNull("card_total")+"건");
			cell.setCellStyle(cs);
			
			cell = row.createCell(5);
			cell.setCellValue(mp.getStrNull("busino_total")+"건");
			cell.setCellStyle(cs);
			
			cell = row.createCell(6);
			cell.setCellValue(mp.getStrNull("bubino_total")+"건");
			cell.setCellStyle(cs);
			
			cell = row.createCell(7);
			cell.setCellValue(mp.getStrNull("cell_total")+"건");
			cell.setCellStyle(cs);
			
			cell = row.createCell(8);
			cell.setCellValue(mp.getStrNull("tel_total")+"건");
			cell.setCellStyle(cs);
		
			row = sheet1.createRow(sheet1.getLastRowNum()+1);
		}
        
        //2번시트
        row = sheet2.createRow(0);
        
        header = new String[]{"타이틀", "URL", "방문횟수"};
        if (header[0] != null && header.length > 0){
			for(int i=0;i<header.length;i++){
				cell = row.createCell(i);
				cell.setCellValue(header[i]);
		        cell.setCellStyle(tcs);
			}
		}
        
        row = sheet2.createRow(1);
        for (MCMap mp : list) {
			cell = row.createCell(0);
			cell.setCellValue(mp.getStrNull("title"));
			cell.setCellStyle(cs);
			
			cell = row.createCell(1);
			cell.setCellValue(mp.getStrNull("request_uri"));
			cell.setCellStyle(cs);
			
			cell = row.createCell(2);
			cell.setCellValue(mp.getStrNull("cnt"));
			cell.setCellStyle(cs);
			
			row = sheet2.createRow(sheet2.getLastRowNum()+1);
		}
        
        OutputStream output = res.getOutputStream();
        res.setContentType("application/xls");
        res.setHeader("Content-Disposition","attachment; filename=personal_filter.xls");
        xlsxWb.write(output);
        return "";
	}
	
	public String detail_excel(HttpServletResponse res, Map<String, String> params) throws Exception {
		List<MCMap> list = dao.detail_list_all(params);
		
		HSSFWorkbook xlsxWb = new HSSFWorkbook(); // Excel 2007 이전 버전
		// Sheet 생성
		HSSFSheet sheet1 = xlsxWb.createSheet("메뉴별 검출내역");
		DataFormat format = xlsxWb.createDataFormat();
		
//      Cell 스타일 생성
		HSSFFont tf = xlsxWb.createFont();
		tf.setFontHeightInPoints((short) 12);
		tf.setColor(HSSFColor.BLACK.index);
		tf.setFontName("맑은 고딕");
		tf.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD); //폰트굵게
		
		HSSFFont f = xlsxWb.createFont();
		f.setFontHeightInPoints((short) 10);
		f.setColor(HSSFColor.BLACK.index);
		f.setFontName("맑은 고딕");
		
		//기본 스타일
		CellStyle dcs = xlsxWb.createCellStyle();
		dcs.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		dcs.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		dcs.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		dcs.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		dcs.setBorderRight(HSSFCellStyle.BORDER_THIN);
		dcs.setBorderTop(HSSFCellStyle.BORDER_THIN);
		dcs.setWrapText(true);//자동줄바꿈
		
		//타이틀 스타일
		CellStyle tcs = xlsxWb.createCellStyle();
		tcs.cloneStyleFrom(dcs);
		tcs.setFont(tf);
		tcs.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.index);
		tcs.setFillPattern(CellStyle.SOLID_FOREGROUND);
		
		//기본 문자 스타일
		CellStyle cs = xlsxWb.createCellStyle();
		cs.cloneStyleFrom(dcs);
		cs.setFont(f);
		
		//날짜 스타일
		CellStyle dc = xlsxWb.createCellStyle();
		dc.cloneStyleFrom(dcs);
		dc.setDataFormat(format.getFormat("m/d/yy h:mm"));
		
		//숫자 스타일
		CellStyle nc = xlsxWb.createCellStyle();
		nc.cloneStyleFrom(dcs);
		nc.setDataFormat(format.getFormat("#,##0"));
		
		//화폐 스타일
		CellStyle bc = xlsxWb.createCellStyle();
		bc.cloneStyleFrom(dcs);
		bc.setDataFormat(format.getFormat("₩#,##0"));
		
		Row row = null;
		Cell cell = null;
		//----------------------------------------------------------
		
		// 첫 번째 줄
		row = sheet1.createRow(0);
		
		String[] header = new String[]{"번호", "게시물제목", "주민번호", "이메일", "카드번호", "사업자번호", "법인번호", "휴대전화번호", "일반전화번호", "등록일"};
		if (header[0] != null && header.length > 0){
			for(int i=0;i<header.length;i++){
				cell = row.createCell(i);
				cell.setCellValue(header[i]);
				cell.setCellStyle(tcs);
			}
		}
		
		//두번째 줄부터 데이터 입력
		row = sheet1.createRow(1);
		for (MCMap mp : list) {
			cell = row.createCell(0);
			cell.setCellValue(mp.getStrNull("rn"));
			cell.setCellStyle(cs);
			
			cell = row.createCell(1);
			cell.setCellValue(mp.getStrNull("title"));
			cell.setCellStyle(cs);
			
			cell = row.createCell(2);
			cell.setCellValue(mp.getStrNull("jumin_conts"));
			cell.setCellStyle(cs);
			
			cell = row.createCell(3);
			cell.setCellValue(mp.getStrNull("email_conts"));
			cell.setCellStyle(cs);
			
			cell = row.createCell(4);
			cell.setCellValue(mp.getStrNull("card_conts"));
			cell.setCellStyle(cs);
			
			cell = row.createCell(5);
			cell.setCellValue(mp.getStrNull("busino_conts"));
			cell.setCellStyle(cs);
			
			cell = row.createCell(6);
			cell.setCellValue(mp.getStrNull("bubino_conts"));
			cell.setCellStyle(cs);
			
			cell = row.createCell(7);
			cell.setCellValue(mp.getStrNull("cell_conts"));
			cell.setCellStyle(cs);
			
			cell = row.createCell(8);
			cell.setCellValue(mp.getStrNull("tel_conts"));
			cell.setCellStyle(cs);
			
			cell = row.createCell(9);
			cell.setCellValue(mp.getStrNull("reg_dt"));
			cell.setCellStyle(cs);
			
			row = sheet1.createRow(sheet1.getLastRowNum()+1);
		}
		
		
		OutputStream output = res.getOutputStream();
		res.setContentType("application/xls");
		res.setHeader("Content-Disposition","attachment; filename=personal_filter.xls");
		xlsxWb.write(output);
		return "";
	}
}
