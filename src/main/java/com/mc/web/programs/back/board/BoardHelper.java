package com.mc.web.programs.back.board;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;

import com.mc.web.service.Globals;

import egovframework.com.cmm.util.EgovHttpRequestHelper;

@Service
public class BoardHelper {
	private String board_type = null;
	private String user_name = null;
	private String title = null;
	private String SAMPLE_JSP_DIR = Globals.MC_SRCPATH + "/main/resources/template/bbs/web";
	private String TARGET_JSP_DIR = Globals.MC_SRCPATH + "/main/webapp/WEB-INF/jsp";
	private String SAMPLE_JAVA_DIR = Globals.MC_SRCPATH + "/main/resources/template/bbs/java";
	private String TARGET_JAVA_DIR = Globals.MC_SRCPATH + "/main/java/com/mc/web/programs";
	
	private List<String> fileList = null;
	
	public void makeFiles(Map<String, String> params) throws IOException {
		fileList = new ArrayList();
		title = params.get("name");
		board_type = params.get("board_type").toUpperCase();
		user_name = System.getProperty("user.name");
		
		copyJAVA();
		copyAdminJAVA();
		copyJSP();
		copyAdminJSP();
//		writeFileList();
	}
	
	/*private void writeFileList() throws IOException {
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
			    repLine = repLine.replaceAll("\\{\\{BOARD_TYPE\\}\\}", board_type);
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
	}*/
	
	private void copyJSP() throws IOException {
		File srcDir = new File(SAMPLE_JSP_DIR+"/front/WEB-INF/jsp");
		File destDir = new File((TARGET_JSP_DIR+"/bbs/"+board_type).replaceAll("//", "/"));
		copyDirectory(srcDir, destDir);
	}
	
	private void copyAdminJSP() throws IOException {
		File srcDir = new File(SAMPLE_JSP_DIR+"/back/WEB-INF/jsp/super");
		File destDir = new File((TARGET_JSP_DIR+"/super/homepage/bbs/"+board_type).replaceAll("//", "/"));
		copyDirectory(srcDir, destDir);
	}
	
	private void copyJAVA() throws IOException {
		File srcDir = new File(SAMPLE_JAVA_DIR+"/front");
		File destDir = new File((TARGET_JAVA_DIR+"/front/bbs/"+board_type).replaceAll("//", "/"));
		copyDirectory(srcDir, destDir);
	}
	private void copyAdminJAVA() throws IOException {
		File srcDir = new File(SAMPLE_JAVA_DIR+"/back");
		File destDir = new File((TARGET_JAVA_DIR+"/back/bbs/"+board_type).replaceAll("//", "/"));
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
    		String targetFileName = target.getName().replaceAll("Sample", board_type);
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
			    repLine = repLine.replaceAll("\\{\\{BOARD_TYPE\\}\\}", board_type);
			    repLine = repLine.replaceAll("\\{\\{USER_NAME\\}\\}", user_name);
	
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
