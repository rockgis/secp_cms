package com.mc.web.programs.back.satifaction.impl;

import java.io.IOException;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mc.common.util.StringUtil;
import com.mc.web.MCMap;
import com.mc.web.programs.back.satifaction.SatisfactionDAO;
import com.mc.web.programs.back.satifaction.SatisfactionService;
import com.mc.web.common.SessionInfo;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import jxl.CellView;
import jxl.Workbook;
import jxl.format.Alignment;
import jxl.format.Border;
import jxl.format.BorderLineStyle;
import jxl.format.Colour;
import jxl.format.VerticalAlignment;
import jxl.write.Label;
import jxl.write.WritableCellFormat;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;
import jxl.write.WriteException;

@Service("SatisfactionService")
public class SatisfactionServiceImpl extends EgovAbstractServiceImpl implements SatisfactionService {

	@Autowired
	private SatisfactionDAO dao;
	
	public Map estimate(Map params) throws Exception {
		SessionInfo.sessionAuth(params);
		Map rstMap = new HashMap();
		if(dao.isOverlap(params) > 0){
			rstMap.put("rst", "-1");
			rstMap.put("msg", "이미 참여 하셨습니다. 감사합니다.");
		}else{
			dao.estimate(params);
			rstMap.put("rst", "1");
			rstMap.put("data", dao.page_satisfaction(params));
		}
		return rstMap;
	}

	@Override
	public Map list(Map params) throws Exception {
		Map rstMap = new HashMap();
		rstMap.put("list", dao.stat_list(params));
		rstMap.put("pagination", dao.stat_pagination(params));
		return rstMap;
	}
	@Override
	public Map etclist(Map params) throws Exception {
		Map rstMap = new HashMap();
		rstMap.put("list", dao.etc_list(params));
		rstMap.put("pagination", dao.etc_pagination(params));
		return rstMap;
	}
	@Override
	public Map result(Map params) throws Exception {
		Map rstMap = new HashMap();
		rstMap.put("list", dao.detail_list(params));
		rstMap.put("pagination", dao.detail_pagination(params));
		return rstMap;
	}

	@Override
	public void excel(Map<String, String> params, HttpServletResponse response) throws IOException, Exception {
		
		List<MCMap> list = dao.excel_list(params);
		
		OutputStream output = response.getOutputStream();
		response.setContentType("application/xls");
		response.setHeader("Content-Disposition","attachment; filename=satisfaction.xls");
		
		WritableWorkbook writebook = Workbook.createWorkbook(output);
		WritableSheet writeSheet = writebook.createSheet("설문조사 통계 관리", 0);

		WritableCellFormat headerFormat = new WritableCellFormat(); // 번호 셀 포멧 생성
		WritableCellFormat dataFormat = new WritableCellFormat(); // 데이터 셀 포멧 생성
		WritableCellFormat textFormat = new WritableCellFormat(); // 데이터 셀 포멧 생성

		headerFormat.setAlignment(Alignment.CENTRE); // 셀 가운데 정렬
		headerFormat.setVerticalAlignment(VerticalAlignment.CENTRE); // 셀 수직 가운데 정렬
		headerFormat.setBorder(Border.ALL, BorderLineStyle.THIN); // 보더와 보더라인스타일 설정
		headerFormat.setBackground(Colour.GRAY_25);
		
		dataFormat.setAlignment(Alignment.CENTRE); // 셀 가운데 정렬
		dataFormat.setVerticalAlignment(VerticalAlignment.CENTRE); // 셀 수직 가운데 정렬
		dataFormat.setBorder(Border.ALL, BorderLineStyle.THIN); // 보더와 보더라인스타일 설정
		dataFormat.setWrap(true);
		
		textFormat.setAlignment(Alignment.LEFT); // 셀 가운데 정렬
		textFormat.setVerticalAlignment(VerticalAlignment.CENTRE); // 셀 수직 가운데 정렬
		textFormat.setBorder(Border.ALL, BorderLineStyle.THIN); // 보더와 보더라인스타일 설정
		textFormat.setWrap(true);
		
		writeSheet.setColumnView(0, 60); 
		writeSheet.setColumnView(1, 10); 
		writeSheet.setColumnView(2, 10); 
		writeSheet.setColumnView(3, 10); 
		writeSheet.setColumnView(4, 10); 
		writeSheet.setColumnView(5, 10); 
		writeSheet.setColumnView(6, 10); 
		writeSheet.setColumnView(7, 10); 
		writeSheet.setColumnView(8, 10); 
		writeSheet.setColumnView(9, 80); 
		
		CellView cv = new CellView();
		cv.setAutosize(true);
		int i = 1;
		
		String[] header = {"메뉴명", "매운만족", "만족", "보통", "불만족", "매우불만족", "합계(점수)", "평균(평점)", "설문횟수", "기타의견"};
		if (header != null && header.length > 0)
		{
			for(int x=0;x<header.length;x++){
				Label headerLabels =new Label(x, i, header[x], headerFormat); // 데이터 포멧에 맞게 대문자 A에서 E까지 생성
				writeSheet.addCell(headerLabels); // 셀에 삽입
			}
			i++;
		}
		try {
			for(MCMap map : list){
				int cell = 0;
				writeSheet.addCell(new Label(cell++, i, StringUtil.isNullDef((String)map.get("title"), "메뉴명"), textFormat));
				writeSheet.addCell(new Label(cell++, i, StringUtil.getThousand(map.getIntNullVal("sum_score5", 0)), dataFormat));
				writeSheet.addCell(new Label(cell++, i, StringUtil.getThousand(map.getIntNullVal("sum_score4", 0)), dataFormat));
				writeSheet.addCell(new Label(cell++, i, StringUtil.getThousand(map.getIntNullVal("sum_score3", 0)), dataFormat));
				writeSheet.addCell(new Label(cell++, i, StringUtil.getThousand(map.getIntNullVal("sum_score2", 0)), dataFormat));
				writeSheet.addCell(new Label(cell++, i, StringUtil.getThousand(map.getIntNullVal("sum_score1", 0)), dataFormat));
				writeSheet.addCell(new Label(cell++, i, StringUtil.getThousand(map.getIntNullVal("sum_score", 0)), dataFormat));
				writeSheet.addCell(new Label(cell++, i, StringUtil.getThousand(map.getIntNullVal("avg_score", 0)), dataFormat));
				writeSheet.addCell(new Label(cell++, i, StringUtil.getThousand(map.getIntNullVal("total_count", 0)), dataFormat));
				writeSheet.addCell(new Label(cell++, i, map.getStrNull("etc"), textFormat));
				
				i++;
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		writebook.write(); // 준비된 정보를 엑셀 포멧에 맞게 작성
		writebook.close(); // 처리 후 메모리에서 해제 처리
	}
	@Override
	public void detail_execeldown(Map<String, String> params, HttpServletResponse response) throws IOException, Exception {
		params.put("rows", "9999");
		List<MCMap> list = dao.detail_list(params);
		
		String filename = java.net.URLEncoder.encode("만족도_상세보기","UTF-8");
		OutputStream output = response.getOutputStream();
		response.setContentType("application/xls");
		response.setHeader("Content-Disposition","attachment; filename="+filename+".xls");
		
		WritableWorkbook writebook = Workbook.createWorkbook(output);
		WritableSheet writeSheet = writebook.createSheet("설문조사 상세결과", 0);
		
		WritableCellFormat headerFormat = new WritableCellFormat(); // 번호 셀 포멧 생성
		WritableCellFormat dataFormat = new WritableCellFormat(); // 데이터 셀 포멧 생성
		WritableCellFormat textFormat = new WritableCellFormat(); // 데이터 셀 포멧 생성
		
		headerFormat.setAlignment(Alignment.CENTRE); // 셀 가운데 정렬
		headerFormat.setVerticalAlignment(VerticalAlignment.CENTRE); // 셀 수직 가운데 정렬
		headerFormat.setBorder(Border.ALL, BorderLineStyle.THIN); // 보더와 보더라인스타일 설정
		headerFormat.setBackground(Colour.GRAY_25);
		
		dataFormat.setAlignment(Alignment.CENTRE); // 셀 가운데 정렬
		dataFormat.setVerticalAlignment(VerticalAlignment.CENTRE); // 셀 수직 가운데 정렬
		dataFormat.setBorder(Border.ALL, BorderLineStyle.THIN); // 보더와 보더라인스타일 설정
		dataFormat.setWrap(true);
		
		textFormat.setAlignment(Alignment.LEFT); // 셀 가운데 정렬
		textFormat.setVerticalAlignment(VerticalAlignment.CENTRE); // 셀 수직 가운데 정렬
		textFormat.setBorder(Border.ALL, BorderLineStyle.THIN); // 보더와 보더라인스타일 설정
		textFormat.setWrap(true);
		
		writeSheet.setColumnView(0, 30); 
		writeSheet.setColumnView(1, 30); 
		writeSheet.setColumnView(2, 50); 
		
		CellView cv = new CellView();
		cv.setAutosize(true);
		int i = 1;
		
		String[] header = {"일자", "만족도", "기타의견"};
		if (header != null && header.length > 0)
		{
			for(int x=0;x<header.length;x++){
				Label headerLabels =new Label(x, i, header[x], headerFormat); // 데이터 포멧에 맞게 대문자 A에서 E까지 생성
				writeSheet.addCell(headerLabels); // 셀에 삽입
			}
			i++;
		}
		try {
			for(MCMap map : list){
				int cell = 0;
				String v = "";
				switch (map.getStrNull("score")) {
				case "1":
					v = "매우불만족";
					break;
				case "2":
					v = "불만족";
					break;
				case "3":
					v = "보통";
					break;
				case "4":
					v = "만족";
					break;
				case "5":
					v = "매우만족";
					break;
				default:
					v = "기타";
					break;
				}
				writeSheet.addCell(new Label(cell++, i, map.getStrNull("reg_dt"), textFormat));
				writeSheet.addCell(new Label(cell++, i, v, textFormat));
				writeSheet.addCell(new Label(cell++, i, map.getStrNull("etc"), textFormat));
				
				i++;
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		writebook.write(); // 준비된 정보를 엑셀 포멧에 맞게 작성
		writebook.close(); // 처리 후 메모리에서 해제 처리
	}
}
