package com.mc.web.programs.back.program;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;

import com.mc.web.service.Globals;

import egovframework.com.cmm.util.EgovHttpRequestHelper;

@Service
public class ProgramHelper {
	private String url = null;
	private String manage_url = null;
	private String middel_url_path = null;
	private String admin_jsp_path = null;
	private String last_path = null;
	private String jsp_path = null;
	private String jsp_path2 = null;
	private String sub_name_lower = null;
	private String sub_name_camel = null;
	private String user_name = null;
	private String title = null;
	private String SAMPLE_JSP_DIR = Globals.MC_SRCPATH + "/main/resources/template/program/web";
	private String TARGET_JSP_DIR = Globals.MC_SRCPATH + "/main/webapp/WEB-INF/jsp";
	private String SAMPLE_JAVA_DIR = Globals.MC_SRCPATH + "/main/resources/template/program/java";
	private String TARGET_JAVA_DIR = Globals.MC_SRCPATH + "/main/java/com/mc/web/programs";
	
	private List<String> fileList = null;
	
	public void makeFiles(Map<String, String> params) throws IOException {
		fileList = new ArrayList();
		title = params.get("program_nm");
		url = params.get("url");
		middel_url_path = params.get("url").substring(0, params.get("url").lastIndexOf("/"));
		manage_url = params.get("manage_url");
		last_path = params.get("url").substring(params.get("url").lastIndexOf("/")+1).replaceAll(".do", "");
		jsp_path = params.get("url").replaceAll(".do", "");
		jsp_path2 = params.get("url").substring(1, params.get("url").lastIndexOf("/"));
		sub_name_lower = params.get("folder").toLowerCase();
		sub_name_camel = params.get("folder").substring(0, 1).toUpperCase()+params.get("folder").substring(1).toLowerCase();
		user_name = System.getProperty("user.name");
		
		copyJAVA();
//		copyJSP();
		if(manage_url!=null){
			admin_jsp_path = params.get("manage_url").replaceAll("/index.do", "");
			Pattern super_pattern = Pattern.compile("/super/homepage/[a-zA-Z0-9_]+/index.do");
			Matcher match = super_pattern.matcher(manage_url);
			if(match.find()){
				copyAdminJAVA();
				copyAdminJSP();
			}
		}
		writeFileList();
	}
	
	private void writeFileList() throws IOException {
		String str = "";
		for (String path : fileList) {
			str+=path+"<br />";
		}
		File sample = new File(SAMPLE_JSP_DIR+"/front/WEB-INF/jsp", "intro.jsp");
		File index = new File(TARGET_JSP_DIR+"/programs/"+jsp_path2, last_path+".jsp");
		File dir = new File(TARGET_JSP_DIR+"/programs/", jsp_path2);
		if (!dir.exists()) {
			dir.mkdirs();
	    }
		fileList.add(index.getCanonicalPath().replaceAll("\\\\", "/"));
		
		BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(new FileInputStream(sample)));
		BufferedWriter bufferedWriter = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(index)));
		
		try {
			String line;
			String repLine;
			while ((line = bufferedReader.readLine()) != null) {
			    // 일치하는 패턴에서는 바꿀 문자로 변환
			    repLine = line.replaceAll("\\{\\{TITLE\\}\\}", title);
			    repLine = repLine.replaceAll("\\{\\{URL\\}\\}", url);
			    repLine = repLine.replaceAll("\\{\\{MIDDEL_URL_PATH\\}\\}", middel_url_path);
			    repLine = repLine.replaceAll("\\{\\{SUB_NAME_LOWER\\}\\}", sub_name_lower);
			    repLine = repLine.replaceAll("\\{\\{SUB_NAME_CAMEL\\}\\}", sub_name_camel);
			    repLine = repLine.replaceAll("\\{\\{JSP_PATH\\}\\}", jsp_path);
			    repLine = repLine.replaceAll("\\{\\{LAST_PATH\\}\\}", last_path);
			    repLine = repLine.replaceAll("\\{\\{USER_NAME\\}\\}", user_name);
			    repLine = repLine.replaceAll("\\{\\{FILELIST\\}\\}", str);
	
			    // 새로운 파일에 쓴다.
			    bufferedWriter.write(repLine, 0, repLine.length());
			    bufferedWriter.newLine();
			}
		}catch(IOException e){
			e.printStackTrace();
		}finally{
			try {
				bufferedReader.close();
			} catch (IOException e) {
			}
			try {
				bufferedWriter.close();
			} catch (IOException e) {
			}
		}
	}
	
	private void copyJSP() throws IOException {
		File srcDir = new File(SAMPLE_JSP_DIR+"/front/WEB-INF/jsp");
		File destDir = new File((TARGET_JSP_DIR+"/programs/"+jsp_path2).replaceAll("//", "/"));
		copyDirectory(srcDir, destDir);
	}
	
	private void copyAdminJSP() throws IOException {
		File srcDir = new File(SAMPLE_JSP_DIR+"/back/WEB-INF/jsp/super");
		File destDir = new File((TARGET_JSP_DIR+"/"+admin_jsp_path).replaceAll("//", "/"));
		copyDirectory(srcDir, destDir);
	}
	
	private void copyJAVA() throws IOException {
		File srcDir = new File(SAMPLE_JAVA_DIR+"/front");
		File destDir = new File((TARGET_JAVA_DIR+"/front/"+sub_name_lower).replaceAll("//", "/"));
		copyDirectory(srcDir, destDir);
	}
	private void copyAdminJAVA() throws IOException {
		File srcDir = new File(SAMPLE_JAVA_DIR+"/back");
		File destDir = new File((TARGET_JAVA_DIR+"/back/"+sub_name_lower).replaceAll("//", "/"));
		copyDirectory(srcDir, destDir);
	}
	
	private void copyDirectory(File source, File target) throws IOException {
	    if (!target.exists()) {
	        target.mkdirs();
	    }

	    for (String f : source.list()) {
	        copy(new File(source, f), new File(target, f));
	    }
	}
	
	public void copy(File sourceLocation, File targetLocation) throws IOException {
	    if (sourceLocation.isDirectory()) {
	        copyDirectory(sourceLocation, targetLocation);
	    } else {
	        copyFile(sourceLocation, targetLocation);
	    }
	}
	
	private void copyFile(File source, File target) throws IOException {
		HttpServletRequest request = EgovHttpRequestHelper.getCurrentRequest();
    	if(target.getName().indexOf("Sample")>-1){
    		String targetFileName = target.getName().replaceAll("Sample", sub_name_camel);
    		target = new File(target.getAbsolutePath().replaceAll(target.getName(), ""), targetFileName);
    	}
    	
		BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(new FileInputStream(source)));
		BufferedWriter bufferedWriter = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(target)));
		
		try {
			String line;
			String repLine;
			while ((line = bufferedReader.readLine()) != null) {
			    // 일치하는 패턴에서는 바꿀 문자로 변환
			    repLine = line.replaceAll("\\{\\{TITLE\\}\\}", title);
			    repLine = repLine.replaceAll("\\{\\{URL\\}\\}", url);
			    repLine = repLine.replaceAll("\\{\\{MIDDEL_URL_PATH\\}\\}", middel_url_path);
			    repLine = repLine.replaceAll("\\{\\{SUB_NAME_LOWER\\}\\}", sub_name_lower);
			    repLine = repLine.replaceAll("\\{\\{SUB_NAME_CAMEL\\}\\}", sub_name_camel);
			    repLine = repLine.replaceAll("\\{\\{JSP_PATH\\}\\}", jsp_path);
			    repLine = repLine.replaceAll("\\{\\{LAST_PATH\\}\\}", last_path);
			    repLine = repLine.replaceAll("\\{\\{USER_NAME\\}\\}", user_name);
			    repLine = repLine.replaceAll("\\{\\{MANAGE_URL\\}\\}", manage_url);
	
			    // 새로운 파일에 쓴다.
			    bufferedWriter.write(repLine, 0, repLine.length());
			    bufferedWriter.newLine();
			}
			fileList.add(target.getCanonicalPath().replaceAll("\\\\", "/"));
		}catch(IOException e){
			
		}finally{
			try {
				bufferedReader.close();
			} catch (IOException e) {
			}
			try {
				bufferedWriter.close();
			} catch (IOException e) {
			}
		}
		
	}
	
	
}
