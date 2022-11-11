package kr.ggbaro.util.common.execl;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.ListIterator;
import java.util.Map;
import java.util.Set;
import java.util.UUID;

import com.mc.web.MCMap;
import com.spire.xls.CellRange;
import com.spire.xls.CellStyle;
import com.spire.xls.ExcelPicture;
import com.spire.xls.Workbook;
import com.spire.xls.Worksheet;

public class ExeclToPdf {
	

	public static void main(String[] args) throws Exception {
		List<Map<String,Object>> params = new ArrayList<Map<String,Object>>();
		
		Map<String,Object> map1 = new HashMap<String,Object>();
		
		map1.put("templatesFile", "C:\\Workspace\\secp_cms\\src\\main\\webapp\\upload\\common\\biz001\\templates\\biz001_templates_new.xlsx");
		map1.put("sheetOrder","1");
		map1.put("UPLOAD_PATH","C:\\Workspace\\data\\ggbaro\\data\\pdf");
		//map1.put("savePdf",map1.get("UPLOAD_PATH")+"\\"+map1.get("#{USER_ID}").toString()+".pdf");
		map1.put("savePdf",map1.get("UPLOAD_PATH")+"\\지원계획서.pdf");
		
		Map<String,Object> map2 = new HashMap<String,Object>();
		map2.put("USER_ID","jsjung");
		map2.put("RPRSNTV","정지석");
		map2.put("ENTRPS_NM","업체명!");
		map2.put("EMPLY_CO","1");
		
		
		params.add(map1);
		params.add(map2);
		
		
		
		
		System.out.println(params);
		
		realConvertExcelToPdf(params);
	}
	
	public static String realConvertExcelToPdf(List<Map<String,Object>> params) {
	
		 //Create a Workbook instance and load an Excel file
        Workbook workbook = new Workbook();
        workbook.loadFromFile(params.get(0).get("templatesFile").toString());

        //Set worksheets to fit to width when converting
        workbook.getConverterSetting().setSheetFitToWidth(true);
        workbook.getConverterSetting().setXDpi(200);

        //Get the first worksheet 
        Worksheet worksheet = workbook.getWorksheets().get(Integer.parseInt(params.get(0).get("sheetOrder").toString())); //시트순서
        
        
        
        CellRange[] ranges = null; 
        
        
        for(int i=0;i<params.get(1).size();i++) {
        	System.out.println(params.get(1).toString());
        	Set<String> s = params.get(1).keySet();
        	//System.out.println(s.iterator().);
        	//System.out.println(params.get(1).values());
        	System.out.println(params.get(1).keySet().toArray()[i]);
        	System.out.println(params.get(1).values().toArray()[i]);
        	
        	if(!params.get(1).keySet().toArray()[i].equals("")) {
        		ranges = worksheet.findAllString(params.get(1).keySet().toArray()[i].toString(), false, false);
        		for (CellRange range : ranges)
        	        {
        	            //Replace the text with new text
        	            range.setText(params.get(1).values().toArray()[i].toString());
        	        }
        	}
        }
        
        try {
        worksheet.saveToPdf(params.get(0).get("savePdf").toString());
        	String uuid = UUID.randomUUID().toString();
        	System.out.println(uuid);
        	return uuid;
        }catch (Exception e) {
			// TODO: handle exception
        	return "FAIL";
		}
        
        
        
        //for(int i=0;i<params.get(1).keySet().toArray())

//        //Convert to PDF and save the resulting document to a specified path
//        if(!params.get("#{USER_ID}").equals("")) {
//	        CellRange[] ranges = worksheet.findAllString("#{USER_ID}", false, false);
//	
//	        for (CellRange range : ranges)
//	        {
//	            //Replace the text with new text
//	            range.setText(params.get("#{USER_ID}").toString());
//	            //range.setValue("변환된 데이터!!!");
//	        }
//        }
//        
//        
//        if(!params.get("#{RPRSNTV}").equals("")) {
//	        CellRange[] ranges1 = worksheet.findAllString("#{RPRSNTV}", false, false);
//	
//	        for (CellRange range : ranges1)
//	        {
//	            //Replace the text with new text
//	            range.setText(params.get("#{RPRSNTV}").toString());
//	            //range.setValue("변환된 데이터!!!");
//	        }
//        }
//        
//        if(!params.get("#{ENTRPS_NM}").equals("")) {
//	        CellRange[] ranges1 = worksheet.findAllString("#{ENTRPS_NM}", false, false);
//	
//	        for (CellRange range : ranges1)
//	        {
//	            //Replace the text with new text
//	            range.setText(params.get("#{ENTRPS_NM}").toString());
//	            //range.setValue("변환된 데이터!!!");
//	        }
//        }
//        
//        if(!params.get("#{EMPLY_CO}").equals("")) {
//	        CellRange[] ranges1 = worksheet.findAllString("#{EMPLY_CO}", false, false);
//	
//	        for (CellRange range : ranges1)
//	        {
//	            //Replace the text with new text
//	            range.setText(params.get("#{EMPLY_CO}").toString());
//	            //range.setValue("변환된 데이터!!!");
//	        }
//        }
//        
//                
//        //ExcelPicture pic = worksheet.getPictures().add(5, 3,"D:\\경상원프로젝트\\01.문서\\test.png");
//       
//        //Set image width and height
//       
//        //pic.setWidth(300);
//        
//        //worksheet.setText(1, 1, "AAAAAAAAAAAAAAAA");
//        worksheet.saveToPdf(params.get("savePdf").toString());
		
		
	}
	
	
	public static void ConvertExcelToPdf() {

    	 //Create a Workbook instance and load an Excel file
        Workbook workbook = new Workbook();
        workbook.loadFromFile("C:\\Workspace\\secp_cms\\src\\main\\webapp\\upload\\common\\biz001\\templates\\biz001_templates.xlsx");

        //Set worksheets to fit to width when converting
        workbook.getConverterSetting().setSheetFitToWidth(true);
        workbook.getConverterSetting().setXDpi(300);

        //Get the first worksheet 
        Worksheet worksheet = workbook.getWorksheets().get(1); //신청서

        //Convert to PDF and save the resulting document to a specified path
        CellRange[] ranges = worksheet.findAllString("#{AAA}", false, false);

        for (CellRange range : ranges)
        {
            //Replace the text with new text
            range.setText("변환된 데이터!!!변환된 데이터!!!변환된 데이터!!!변환된 데이터!!!변환된 데이터!!!변환된 데이터!!!변환된 데이터!!!변환된 데이터!!!변환된 데이터!!!변환된 데이터!!!");
            //range.setValue("변환된 데이터!!!");
        }
        
        
        CellRange[] ranges1 = worksheet.findAllString("#{BBB}", false, false);

        for (CellRange range : ranges1)
        {
            //Replace the text with new text
            range.setText("변환된 데이터1!!!변환된 데이터1!!!변환된 데이터1!!!변환된 데이터1!!!변환된 데이터1!!!변환된 데이터1!!!");
            //range.setValue("변환된 데이터!!!");
        }
        
        ExcelPicture pic = worksheet.getPictures().add(5, 3,"D:\\경상원프로젝트\\01.문서\\test.png");
       
        //Set image width and height
       
        pic.setWidth(300);
        
        //worksheet.setText(1, 1, "AAAAAAAAAAAAAAAA");
        worksheet.saveToPdf("D:\\경상원프로젝트\\01.문서\\내부(업무분장)_300dpi.pdf");
    }

}
