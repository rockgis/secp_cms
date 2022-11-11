package com.mc.web.programs.back.analytics.impl;

import java.io.OutputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.hssf.util.Region;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.DataFormat;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.Row;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mc.common.util.DateUtil;
import com.mc.web.MCMap;
import com.mc.web.programs.back.analytics.AnalyticsDAO;
import com.mc.web.programs.back.analytics.AnalyticsService;

import egovframework.com.cmm.util.EgovHttpRequestHelper;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service("AnalyticsService")
public class AnalyticsServiceImpl extends EgovAbstractServiceImpl implements AnalyticsService {

	@Autowired
	private AnalyticsDAO dao;
	
	public String add_weblog(Map params) throws Exception {
		HttpSession session = EgovHttpRequestHelper.getCurrentSession();
		HttpServletRequest req = EgovHttpRequestHelper.getCurrentRequest();
		String home_url = req.getScheme() + "://"
			    +  req.getServerName()
				+  (req.getServerPort()==80||req.getScheme()=="https"?"":":"+req.getServerPort());
		
		params.put("request_uri", params.get("url").toString().replace(home_url, ""));
		params.put("locale", req.getLocale().toString());
		params.put("ip", req.getRemoteAddr());
		params.put("ymd", DateUtil.getTime("yyMMddHH"));
		params.put("yyyy", DateUtil.getTime("yyyy"));
		params.put("mm", DateUtil.getTime("MM"));
		params.put("dd", DateUtil.getTime("dd"));
		params.put("hh", DateUtil.getTime("HH"));
		params.put("session_id", session.getId());
		MCMap member = (MCMap) session.getAttribute("cms_member");
		params.put("member_id", member==null?"":member.getStrNull("member_id"));
		
		/*
		 * 20210318 로컬여부 상관없이 동일하게 통계 적용 
		 */
		//if(!"127.0.0.1".equals(EgovHttpRequestHelper.getRequestIp())){
		if(dao.has_ymd(params)<=0){
			dao.add_weblog(params);
		}else{
			dao.plus_weblog(params);
		}
		//}
		
		return "ok";
	}
	
	public Map intro(Map params) throws Exception {
		Map rstMap = new HashMap();
		rstMap.put("data1", dao.day(params));
		
		params.put("rows", 5);
		params.put("cpage", 1);
		params.put("total_visit_cnt", dao.total_visit_cnt(params));
		rstMap.put("data2", dao.list(params));
		rstMap.put("browser", dao.browser(params));
		rstMap.put("os", dao.os(params));
		
		
		return rstMap;
	}
	
	public Map day(Map params) throws Exception {
		Map rstMap = new HashMap();
		rstMap.put("data1", dao.days(params));
		rstMap.put("browser", dao.browser(params));
		rstMap.put("os", dao.os(params));
		return rstMap;
	}
	
	public Map time(Map params) throws Exception {
		Map rstMap = new HashMap();
		rstMap.put("data1", dao.times(params));
		rstMap.put("browser", dao.browser(params));
		rstMap.put("os", dao.os(params));
		return rstMap;
	}
	
	public Map browser(Map params) throws Exception {
		Map rstMap = new HashMap();
		rstMap.put("browser", dao.browser(params));
		return rstMap;
	}
	
	public Map os(Map params) throws Exception {
		Map rstMap = new HashMap();
		rstMap.put("os", dao.os(params));
		return rstMap;
	}
	
	public Map page(Map params) throws Exception {
		Map rstMap = new HashMap();
		params.put("total_visit_cnt", dao.total_visit_cnt(params));
		rstMap.put("list", dao.list(params));
		rstMap.put("pagination", dao.pagination(params));
		return rstMap;
	}

	public String execeldown(HttpServletResponse res, Map params) throws Exception {
		List<MCMap> chart = dao.days(params);
		List<MCMap> browser = dao.browser(params);
		List<MCMap> os = dao.os(params);
		params.put("rows", "9999");
		params.put("total_visit_cnt", dao.total_visit_cnt(params));
		List<MCMap> list = dao.list(params);
		
		HSSFWorkbook xlsxWb = new HSSFWorkbook(); // Excel 2007 이전 버전
		// Sheet 생성
		HSSFSheet sheet1 = xlsxWb.createSheet("방문분석");
		HSSFSheet sheet2 = xlsxWb.createSheet("페이지별");
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
        
        for (int i = 0; i < 6; i++) {
        	Row t_row = sheet1.createRow(i);
        	t_row.createCell(0);
        	t_row.createCell(1);
        	t_row.createCell(2);
        	t_row.createCell(3);
        	t_row.createCell(4);
        	t_row.createCell(5);
        	t_row.createCell(6);
		}
        
        // 첫 번째 줄
        row = sheet1.createRow(0);
        
        String[] header = new String[]{"일자", "방문자수", "방문횟수", "페이지뷰"};
        if (header[0] != null && header.length > 0){
			for(int i=0;i<header.length;i++){
				cell = row.createCell(i);
				cell.setCellValue(header[i]);
		        cell.setCellStyle(tcs);
			}
		}
        
        //두번째 줄부터 데이터 입력
        row = sheet1.createRow(1);
        for (MCMap mp : chart) {
			cell = row.createCell(0);
			cell.setCellValue(mp.getStrNull("dis"));
			cell.setCellStyle(cs);
			
			cell = row.createCell(1);
			cell.setCellValue(mp.getStrNull("visit_cnt"));
			cell.setCellStyle(cs);
			
			cell = row.createCell(2);
			cell.setCellValue(mp.getStrNull("visitant_cnt"));
			cell.setCellStyle(cs);
			
			cell = row.createCell(3);
			cell.setCellValue(mp.getStrNull("view_cnt"));
			cell.setCellStyle(cs);
			
			row = sheet1.createRow(sheet1.getLastRowNum()+1);
		}
        
        //browser
        
        int c=5;
        row = sheet1.getRow(0);
    	cell = row.createCell(c);
		cell.setCellValue("브라우저별 접속정보");
		cell.setCellStyle(tcs);
		if(browser.size()>0){
			sheet1.addMergedRegion(new Region(0,(short)5,0,(short)(browser.size()+4))); 
	        for (MCMap mp : browser) {
	        	row = sheet1.getRow(1);
	        	cell = row.createCell(c);
				cell.setCellValue(mp.getStrNull("browser"));
				cell.setCellStyle(tcs);
	        	row = sheet1.getRow(2);
	        	cell = row.createCell(c++);
				cell.setCellValue(mp.getStrNull("cnt"));
				cell.setCellStyle(cs);
	        }
		}
        
        //os
        c=5;
        row = sheet1.getRow(4);
    	cell = row.createCell(c);
		cell.setCellValue("OS별 접속정보");
		cell.setCellStyle(tcs);
		if(os.size()>0){
			sheet1.addMergedRegion(new Region(4,(short)5,4,(short)(os.size()+4))); 
	        for (MCMap mp : os) {
	        	row = sheet1.getRow(5);
	        	cell = row.createCell(c);
				cell.setCellValue(mp.getStrNull("os"));
				cell.setCellStyle(tcs);
	        	row = sheet1.getRow(6);
	        	cell = row.createCell(c++);
				cell.setCellValue(mp.getStrNull("cnt"));
				cell.setCellStyle(cs);
	        }
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
        res.setHeader("Content-Disposition","attachment; filename=noname.xls");
        xlsxWb.write(output);
        return "";
	}

}
