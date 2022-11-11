package com.mc.web.programs.back.site;

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
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import com.mc.web.service.Globals;

import egovframework.com.cmm.util.EgovHttpRequestHelper;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Service("SiteManagerHelper")
public class SiteManagerHelper {
	private String site_id = null;
	private String sub_path = null;
	private String sub_name_lower = null;
	private String sub_name_camel = null;
	private String user_name = null;
	private String title = null;
	private String JSON_PATH = Globals.MC_SRCPATH + "/main/resources/config/mcsite.json";
	private String SAMPLE_INDEX = Globals.MC_SRCPATH + "/main/resources/template/layout/web";
	private String TARGET_INDEX = Globals.MC_SRCPATH + "/main/webapp";	
	private String SAMPLE_JSP_DIR = Globals.MC_SRCPATH + "/main/resources/template/layout/web/WEB-INF/jsp";
	private String TARGET_JSP_DIR = Globals.MC_SRCPATH + "/main/webapp/WEB-INF/jsp";
	private String SAMPLE_JAVA_DIR = Globals.MC_SRCPATH + "/main/resources/template/layout/java";
	private String TARGET_JAVA_DIR = Globals.MC_SRCPATH + "/main/java/com/mc/web/page";
	
	private List<String> fileList = null;
	
	public void updateJSON(Map<String, String> params) throws IOException {
		fileList = new ArrayList();
		JSONArray jsonArray = getJSONFile();
		boolean check = false;
		for (int i = 0; i < jsonArray.size(); i++) {
			JSONObject json = jsonArray.getJSONObject(i);
			if(String.valueOf(params.get("cms_menu_seq")).equals(json.getString("site_id"))){
				json.put("title", params.get("title"));
				json.put("site_id", String.valueOf(params.get("cms_menu_seq")));
				json.put("sub_path", params.get("sub_path"));
				check = true;
				break;
			}
		}
		if(!check){
			JSONObject json = new JSONObject();
			json.put("title", params.get("title"));
			json.put("site_id", String.valueOf(params.get("cms_menu_seq")));
			json.put("sub_path", params.get("sub_path"));
			if("Y".equals(params.get("create_file_yn"))) {
				copyINDEX(json);
				copyJSP(json);
				copyJAVA(json);
				writeFileList();
			}
			jsonArray.add(json);
		}
		setJSONFile(jsonArray);
	}
	
	private void writeFileList() throws FileNotFoundException {
		String str = "";
		for (String path : fileList) {
			str+=path+"<br />";
		}
		File sample = new File(SAMPLE_JSP_DIR, "index.jsp");
		File index = new File(TARGET_JSP_DIR+sub_path, "index.jsp");
		
		BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(new FileInputStream(sample)));
		BufferedWriter bufferedWriter = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(index)));
		
		try {
			String line;
			String repLine;
			while ((line = bufferedReader.readLine()) != null) {
			    // 일치하는 패턴에서는 바꿀 문자로 변환
			    repLine = line.replaceAll("\\{\\{TITLE\\}\\}", title);
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

	private void copyINDEX(JSONObject json) throws IOException {
		File srcDir = new File(SAMPLE_INDEX);
		File destDir = new File((TARGET_INDEX+"/"+json.getString("sub_path")).replaceAll("//", "/"));
		site_id = json.getString("site_id");
		sub_path = json.getString("sub_path");
		sub_name_lower = json.getString("sub_path").replaceAll("/", "").toLowerCase();
		sub_name_camel = json.getString("sub_path").replaceAll("/", "").substring(0, 1).toUpperCase()+json.getString("sub_path").replaceAll("/", "").substring(1).toLowerCase();
		user_name = System.getProperty("user.name");
		title = json.getString("title");
		if (!destDir.exists()) {
			destDir.mkdir();
	    }
		copyFile(new File(srcDir, "index.jsp"), new File(destDir, "index.jsp"));
	}
	
	private void copyJSP(JSONObject json) throws IOException {
		File srcDir = new File(SAMPLE_JSP_DIR);
		File destDir = new File((TARGET_JSP_DIR+"/"+json.getString("sub_path")).replaceAll("//", "/"));
		title = json.getString("title");
		copyDirectory(srcDir, destDir);
	}
	
	private void copyJAVA(JSONObject json) throws IOException {
		File srcDir = new File(SAMPLE_JAVA_DIR);
		File destDir = new File((TARGET_JAVA_DIR+"/"+json.getString("sub_path")).replaceAll("//", "/"));
		title = json.getString("title");
		copyDirectory(srcDir, destDir);
	}
	
	private void copyDirectory(File source, File target) throws IOException {
	    if (!target.exists()) {
	        target.mkdir();
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
			    repLine = repLine.replaceAll("\\{\\{SITE_ID\\}\\}", site_id);
			    repLine = repLine.replaceAll("\\{\\{SUB_PATH\\}\\}", sub_path);
			    repLine = repLine.replaceAll("\\{\\{SUB_NAME\\}\\}", sub_path);
			    repLine = repLine.replaceAll("\\{\\{SUB_NAME_LOWER\\}\\}", sub_name_lower);
			    repLine = repLine.replaceAll("\\{\\{SUB_NAME_CAMEL\\}\\}", sub_name_camel);
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

	public void deleteJSON(Map<String, String> params) throws IOException {
		JSONArray jsonArray = getJSONFile();
		for (int i = 0; i < jsonArray.size(); i++) {
			JSONObject json = jsonArray.getJSONObject(i);
			if(String.valueOf(params.get("cms_menu_seq")).equals(json.getString("site_id"))){
				jsonArray.remove(i);
				break;
			}
		}
		setJSONFile(jsonArray);
	}
	
	public JSONArray getJSONFile() throws IOException{
		JSONArray jsonArray = new JSONArray();
		File file = new File(JSON_PATH);
	    String content = FileUtils.readFileToString(file, "utf-8");
	    jsonArray = JSONArray.fromObject(content);
		return jsonArray;
	}
	
	public void setJSONFile(JSONArray json) throws IOException{
		FileUtils.writeStringToFile(new File(JSON_PATH), json.toString(4));
	}
	
	
	@Autowired
	private SiteManagerDAO dao;

	@Cacheable(value="dashboardCache", keyGenerator="defaultKeyGenerator")
	public Map dashboardData(Map params) throws Exception {
		Map rstMap = new HashMap();
		Map p = new HashMap();		
		//보안설정 현황
		rstMap.put("security_status", dao.security_status(params));
		
		//예약업데이트 현황
		rstMap.put("reserve_count", dao.reserve_count(p));
		
		//화면/배너 현황
		rstMap.put("banner_status", dao.banner_status(params));
		
		//사용종료 예정
		rstMap.put("banner_end_schedule", dao.banner_end_schedule(params));
		
		
		return rstMap;
	}
}
