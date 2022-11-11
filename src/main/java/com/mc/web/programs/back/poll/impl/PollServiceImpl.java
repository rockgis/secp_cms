package com.mc.web.programs.back.poll.impl;

import java.io.OutputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
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

import com.mc.common.util.StringUtil;
import com.mc.web.programs.back.poll.PollDAO;
import com.mc.web.programs.back.poll.PollService;
import com.mc.web.common.SessionInfo;

@Service("PollService")
public class PollServiceImpl implements PollService{
	Logger logger = Logger.getLogger(this.getClass());
	
	@Autowired
	private PollDAO dao;
	
	public Map list(Map<String, String> params) throws Exception {
		Map rstMap = new HashMap();
		rstMap.put("list", dao.getList(params));
		rstMap.put("pagination", dao.getPageInfo(params));
		return rstMap;
	}

	public Map write(Map<String, Object> params) throws Exception {
		Map rstMap = new HashMap();
		SessionInfo.sessionAuth(params);
		dao.pollWrite(params);//설문조사 타이틀 Insert
		questionListInsert(params);
		return rstMap;
	}

	public Map view(Map<String, String> params) {
		Map rstMap = new HashMap();
		rstMap.put("view",dao.article(params));
		rstMap.put("question",dao.questionList(params));		
		return rstMap;
	}

	public Map modify(Map<String, Object> params) throws Exception {
		Map rstMap = new HashMap();
		SessionInfo.sessionAuth(params);
		dao.pollUpdate(params);//설문조사 타이틀 Insert
		dao.deleteQuestion(params);
		dao.deleteAnswer(params);
		questionListInsert(params);
		return rstMap;
	}
	
	public Map resultInit(Map<String, String> params) throws Exception {
		Map rstMap = new HashMap();
		dao.resultInit(params);
		rstMap.put("rst", "1");
		return rstMap;
	}
	
	public Map result(Map<String, String> params) {
		Map rstMap = new HashMap();
		rstMap.put("view",dao.article(params));
		rstMap.put("question",dao.resultQuestionList(params));
		rstMap.put("answers",dao.resultAnswerList(params));
		return rstMap;
	}
	
	public Map resultDetail(Map<String, String> params) throws Exception {
		Map rstMap = new HashMap();
		rstMap.put("list", dao.resultDetailList(params));
		return rstMap;
	}
	
	public Map delete(Map params) throws Exception {
		Map rstMap = new HashMap();
		List deleteList = StringUtil.strToList((String)params.get("article_seq"), ",");
		params.put("seq_list", deleteList);
		dao.mc_poll_update(params); //mc_poll update
		dao.mc_poll_answer_update(params); //mc_poll_answer update
		dao.mc_poll_question_update(params); //mc_poll_question update
		dao.mc_poll_result_update(params); //mc_poll_result delete
		return rstMap;
	}

	private void questionListInsert(Map<String, Object> params) {
		List<Map<String,Object>> questionList = (List)params.get("question");	//JSON으로 보내준 데이터를 사용
		for(Map<String,Object> question_m : questionList){
			int x = 0;
			question_m.put("poll_seq", params.get("poll_seq"));
			dao.pollWriteQuestion(question_m);//질문 타이틀 Insert
			List<Map> answerList = (List)question_m.get("answers");
			for(Map<String,Object> answer_m : answerList){
				answer_m.put("poll_seq", params.get("poll_seq"));
				answer_m.put("answer_seq", x++);
				dao.pollWriteAnwser(answer_m);//답변 문항 Insert
			}
		}
	}

	public void resultExcel(Map<String, String> params, HttpServletResponse response) throws Exception {
		Map view = dao.article(params);
		List question = dao.resultQuestionList(params);
		List answers = dao.resultAnswerList(params);
		List resultGroup = dao.resultGroup(params);
		//List resultList = dao.resultList(params);
		
		String filename = java.net.URLEncoder.encode(String.valueOf(view.get("title")),"UTF-8");
		OutputStream output = response.getOutputStream();
		response.setContentType("application/xls");
		response.setHeader("Content-Disposition","attachment; filename="+filename+".xls");
		
		HSSFWorkbook xlsxWb = new HSSFWorkbook(); // Excel 2007 이전 버전
		// Sheet 생성
		HSSFSheet sheet1 = xlsxWb.createSheet(filename);
        DataFormat format = xlsxWb.createDataFormat();
        
//      Cell 스타일 생성
        HSSFFont tf = xlsxWb.createFont();
        tf.setFontHeightInPoints((short) 10);
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
        tcs.setFillForegroundColor(IndexedColors.YELLOW.index);
        tcs.setFillPattern(CellStyle.SOLID_FOREGROUND);

        CellStyle tcs2 = xlsxWb.createCellStyle();
        tcs2.cloneStyleFrom(dcs);
        tcs2.setFont(tf);
        tcs2.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.index);
        tcs2.setFillPattern(CellStyle.SOLID_FOREGROUND);
        

        //기본 문자 스타일
        CellStyle cs = xlsxWb.createCellStyle();
        cs.cloneStyleFrom(dcs);
        cs.setFont(f);
         
        Row row = null;
        Cell cell = null;
        //----------------------------------------------------------
        
        //	문항 셀병합
        int startTemp = 1;
        int endTemp = 0; 
        if("Y".equals(view.get("lot_yn"))){
        	sheet1.addMergedRegion(new Region(0, (short)0, 0, (short)(2)));
        	startTemp = 3;
        	endTemp = startTemp - 1;
        }
        for(int i=0;i<question.size();i++){
			Map q_m = (Map)question.get(i);
			if("N".equals((String)q_m.get("subject_yn"))){
				int size = 0;
				for(int x=0; x < answers.size();x++){
					Map m = (Map)answers.get(x);
					if(q_m.get("question_seq").equals(m.get("question_seq"))){
						size++;
					}
				}
		        sheet1.addMergedRegion(new Region(0, (short)startTemp, 0, (short)(endTemp+size)));
		        startTemp = startTemp+size;
		        endTemp = endTemp+size;
			}
		}
        // 문항 셀병합
        
        
        // 첫번째 줄 & 문항 셀 & 개인정보 셀 
        row = sheet1.createRow(0);
        cell = row.createCell(0);
    	cell.setCellValue("개인정보 / 문항");
		cell.setCellStyle(tcs);
        int temp = 0;
        int totalTemp = 1; 
        int totalCell = 0;
        if("Y".equals(view.get("lot_yn"))){
			cell = row.createCell(totalTemp++);
			cell.setCellStyle(tcs);
			cell = row.createCell(totalTemp++);
			cell.setCellStyle(tcs);
        }
        int question_cnt = 1;
		for(int i=0;i<question.size();i++){
			Map q_m = (Map)question.get(i);
			if("N".equals((String)q_m.get("subject_yn"))){
				for(int x=0; x < answers.size();x++){
					Map m = (Map)answers.get(x);
					if(q_m.get("question_seq").equals(m.get("question_seq"))){
						if(temp == 0){
							cell = row.createCell(totalTemp++);
							cell.setCellValue((question_cnt++)+". "+String.valueOf(q_m.get("question")));
							cell.setCellStyle(tcs);
							temp = 1;
						}else{
							cell = row.createCell(totalTemp++);
							cell.setCellStyle(tcs);
						}
					}
				}
				totalCell = totalTemp;
				temp = 0;
			}
		}
		
		// 두번째 줄 & 문항 답변 & 개인정보 입력 칸
		row = sheet1.createRow(1);
		totalTemp = 0;
		cell = row.createCell(totalTemp++);
    	cell.setCellValue("이름");
		cell.setCellStyle(tcs2);
        
        if("Y".equals(view.get("lot_yn"))){
			cell = row.createCell(totalTemp++);
			cell.setCellValue("전화번호");
			cell.setCellStyle(tcs2);
			cell = row.createCell(totalTemp++);
			cell.setCellValue("이메일");
			cell.setCellStyle(tcs2);
        }
        for(int i=0;i<question.size();i++){
			Map q_m = (Map)question.get(i);
			if("N".equals((String)q_m.get("subject_yn"))){
				int size = 0;
				for(int x=0; x < answers.size();x++){
					Map m = (Map)answers.get(x);
					if(q_m.get("question_seq").equals(m.get("question_seq"))){
						size++;
						cell = row.createCell(totalTemp++);
						cell.setCellValue(size+". "+String.valueOf(m.get("answer")));
						cell.setCellStyle(tcs2);
					}
				}
			}
		}
		
        // 세번째 줄 & 데이터 입력
        row = sheet1.createRow(2);
        for(int i=0; i < resultGroup.size(); i++){//설문인원 그룹화
        	Map group = (Map)resultGroup.get(i);
        	group.put("poll_seq", params.get("poll_seq"));
        	String tempRegSeq = String.valueOf(group.get("reg_seq"));
        	List resultList = dao.resultListSeq(group);
        	totalTemp = 0;
        	cell = row.createCell(totalTemp++);
        	cell.setCellValue(String.valueOf(group.get("reg_nm")));
        	cell.setCellStyle(cs);
            if("Y".equals(view.get("lot_yn"))){
    			cell = row.createCell(totalTemp++);
    			cell.setCellValue(String.valueOf(group.get("reg_tel")));
    			cell.setCellStyle(cs);
    			cell = row.createCell(totalTemp++);
    			cell.setCellValue(String.valueOf(group.get("reg_email")));
    			cell.setCellStyle(cs);
            }
            for(int z=0;z<question.size();z++){
    			Map q_m = (Map)question.get(z);
    			if("N".equals((String)q_m.get("subject_yn"))){
	    			for(int x=0; x < answers.size();x++){
	    				Map m = (Map)answers.get(x);
	    				if(q_m.get("question_seq").equals(m.get("question_seq"))){
	    					cell = row.createCell(totalTemp++);
	    					for(int y=0; y < resultList.size(); y++){
	    						Map result = (Map)resultList.get(y);
	    						String tempRegSeq2 = String.valueOf(result.get("reg_seq"));
	    						String tempQ = String.valueOf(result.get("question_seq"));
	    						String tempA = String.valueOf(result.get("answer_seq"));
	    						if(tempRegSeq.equals(tempRegSeq2)){//설문한 사람의 seq가 같을 경우
	    							if(String.valueOf(m.get("question_seq")).equals(tempQ) && String.valueOf(m.get("answer_seq")).equals(tempA)){
	    								cell.setCellValue("●");
	    								if(result.containsKey("answer")){//주관식이 있는지 확인
	    									String answer = String.valueOf(result.get("answer"));
	    									if(!"checked".equals(answer)){
	    										cell.setCellValue(answer);
	    									}
	    								}
	    							}
	    						}
	    					}
	    					cell.setCellStyle(cs);
	    				}
	    			}
    			}
            }
            row = sheet1.createRow(sheet1.getLastRowNum()+1);
        }
        for(int i=0;i < totalCell;i++){
        	sheet1.autoSizeColumn(i);
        }
        
        xlsxWb.write(output);
	}
}