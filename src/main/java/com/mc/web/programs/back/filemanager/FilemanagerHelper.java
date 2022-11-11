package com.mc.web.programs.back.filemanager;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.FilenameUtils;
import org.apache.log4j.Logger;
import org.mozilla.universalchardet.UniversalDetector;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.mc.common.util.DateUtil;
import com.mc.common.util.FileUtil;
import com.mc.common.util.StringUtil;
import com.mc.web.MCMap;
import com.mc.web.service.Globals;

import egovframework.com.cmm.util.EgovHttpRequestHelper;
import egovframework.rte.fdl.cmmn.exception.EgovBizException;

/**
 * 
 *
 * @Description : 
 * @ClassName   : com.mc.web.programs.back.filemanager.FilemanagerHelper.java
 * @Modification Information
 *
 * @author 이창기
 * @since 2017. 6. 16.
 * @version 1.0 *  
 * Copyright (C)  All right reserved.
 */
@Service
public class FilemanagerHelper {
	Logger logger = Logger.getLogger(this.getClass());

	private int id = 0;
	private String cut_path = null;
	private List<String> WHITE_FILE_EXTENTSIONS = Arrays.asList(new String[]{"CSS", "JS", "JSP", "HTML", "HTM", "TXT"});
	private List<String> READ_FILE_EXTENTSIONS = Arrays.asList(new String[]{"CSS", "JS", "JSP", "HTML", "HTM", "TXT", "XML", "PROPERTIES", "JAVA"});
	private List<String> BLACK_FOLDER = Arrays.asList(new String[]{"CLASSES", "META-INF", "LOGS"});

	public List getRoot(String path) {
		HttpServletRequest request = EgovHttpRequestHelper.getCurrentRequest();
		cut_path = request.getSession().getServletContext().getRealPath("/");
		cut_path = cut_path.replaceAll("\\\\", "/");
		cut_path = cut_path.replaceAll("\\/$", "");
		id = 0;
		
		List rootList = new ArrayList();
		File file = new File(path);
		if(file.isDirectory()){
			rootList.add(getFolder(file.getAbsolutePath()));
		}
		return rootList;
	}
	
	public Map getFolder(String path){
		List list = new ArrayList();
		File files = new File(path);
		if(BLACK_FOLDER.contains(files.getName().toUpperCase())){
			return null;
		}
		Map map = new HashMap();
		String tPath = files.getAbsolutePath().replaceAll("\\\\", "/");
		map.put("id", id++);
		map.put("text", files.getName());
		map.put("path", tPath.replaceAll(cut_path, ""));
		map.put("icon", "/images/super/folder.png");
		for (File file : files.listFiles()) {
			if(file.isDirectory()){
				Map r = getFolder(file.getAbsolutePath());
				if(r != null){
					list.add(r);
					map.put("children", list);
					map.put("icon", "/images/super/folder.png");
				}
			}
		}
		return map;
	}

	public List getFileList(String path) {
		HttpServletRequest request = EgovHttpRequestHelper.getCurrentRequest();

		File files = new File(path);
		List rootList = new ArrayList();
		Map map = new HashMap();
		if(!files.getAbsolutePath().replaceAll("\\\\", "/").equals(cut_path)){
			String fPath = files.getParent();
			fPath = fPath.replaceAll("\\\\", "/");
			map.put("path", fPath.replaceAll(cut_path, ""));
			map.put("text", "..");
			map.put("use_child", "Y");
			map.put("icon", "/images/super/folder.png");
			rootList.add(map);
		}
		
		for (File file : files.listFiles()) {
			map = new HashMap();
			map.put("text", file.getName());
			String tPath = file.getAbsolutePath().replaceAll("\\\\", "/");
			map.put("path", tPath.replaceAll(cut_path, ""));
//			if(!WHITE_FILE_EXTENTSIONS.contains(FilenameUtils.getExtension(file.getName()).toUpperCase())){
//				continue;
//			}
			if(BLACK_FOLDER.contains(file.getName().toUpperCase())){
				continue;
			}
			if(file.isDirectory()){
				map.put("use_child", "Y");
				map.put("gubun", "파일 폴더");
				map.put("icon", "/images/super/folder.png");
				map.put("mod_dt", DateUtil.formatDate("yyyy-MM-dd aa hh시 mm분", new Date(file.lastModified())));
			}else{
				map.put("icon", "/images/super/file.png");
				map.put("size", FileUtil.readableFileSize(file.length()));
				map.put("gubun", FilenameUtils.getExtension(file.getName()).toUpperCase() +" 파일");
				map.put("mod_dt", DateUtil.formatDate("yyyy-MM-dd aa hh시 mm분", new Date(file.lastModified())));
			}
			rootList.add(map);
		}
		return rootList;
	}

	public MCMap getRealFile(String path) throws Exception {
		MCMap m = new MCMap();
		File f = new File(path);
		if(!READ_FILE_EXTENTSIONS.contains(FilenameUtils.getExtension(f.getName()).toUpperCase())){
			m.put("rst", "-1");
			return m;
		}
		
		String readFile= "";
		String encoding = "";
		BufferedReader in = null;
	    try {
	    	encoding = EncodingCheck(path);
	    	if(!"".equals(encoding)){
	    		in = new BufferedReader(new InputStreamReader(new FileInputStream(path), encoding));
	    	}else{
	    		in = new BufferedReader(new FileReader(f));
	    	}
	        String s;
	        while ((s = in.readLine()) != null) {
	            readFile += s+"\n";
	        }
	    } catch (IOException e) {
	    	logger.error(e.getMessage());
	    }finally {
	    	try {
				in.close();
			} catch (IOException e) {}
		}
	    m.put("source", readFile);
	    m.put("encoding", encoding);
		return m;
	}

	public MCMap createFolder(String path) {
		MCMap m = new MCMap();
		File newdir = new File(path);
		if(newdir.mkdir()){
			m.put("rst", "1");
		}else{
			m.put("rst", "-1");
		}
		return m;
	}

	public MCMap renameTo(String path, String oldFile, String newFile) {
		MCMap m = new MCMap();
		File file = new File(path, oldFile);
		if(file.exists()){
			file.renameTo(new File(path , newFile));
			m.put("rst", "1");
		}else{
			m.put("rst", "-1");
		}
		return m;
	}

	public boolean deleteFolder(File targetFolder) {
		File[] childFile = targetFolder.listFiles();
	    int size = childFile.length;
	    if (size > 0) {
	        for (int i = 0; i < size; i++) {
	            if (childFile[i].isFile()) {
	                childFile[i].delete();
	            } else {
	                deleteFolder(childFile[i]);
	            }
	        }
	    }
	    return targetFolder.delete();
	}

	public int modifyRealFile(Map<String, String> params) {
		int rst = 0;
		HttpServletRequest request = EgovHttpRequestHelper.getCurrentRequest();
		String path = request.getSession().getServletContext().getRealPath(params.get("file_path"));
		File org_file = new File(path);
		if(!WHITE_FILE_EXTENTSIONS.contains(FilenameUtils.getExtension(org_file.getName()).toUpperCase())){
			rst = -1;
			return rst;
		}
		File tmp_file = new File(path+DateUtil.getTime("yyyyMMddHHmmss"));
		org_file.renameTo(tmp_file);

		BufferedWriter bw = null;
		try {
			if(StringUtil.isEmptyByParam(params, "encoding")){
				bw = new BufferedWriter(new FileWriter(path));
			}else{
				bw = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(path), params.get("encoding")));
			}
			bw.write(params.get("source"));
			tmp_file.delete();
			rst = 1;
		} catch (IOException e) {
	    	logger.error(e.getMessage());
	    	rst = -2;
		}finally {
	    	try {
	    		bw.close();
			} catch (IOException e) {}
		}
		return rst;
	}
	
	public Map<String, String> uploadFile(String path, MultipartFile file, String ignore) throws Exception{
		String extension = FilenameUtils.getExtension(file.getOriginalFilename()).toLowerCase();
		if(!Globals.WHITE_FILE_EXTENTSIONS.contains(extension)){
			throw new EgovBizException("보안상 올리실수 없는 형식의 파일입니다.");
		}
		Map<String, String> map = new LinkedHashMap<String, String>();
		if(file == null || file.getSize() == 0)
			return null;
		File dir = new File(path, file.getOriginalFilename());
		if(!dir.isFile()){
			file.transferTo(new File(path + "/" + file.getOriginalFilename()));
			map.put("rst", "1");//완료
		}else{
			if("Y".equals(ignore)){
				file.transferTo(new File(path + "/" + file.getOriginalFilename()));
				map.put("rst", "1");//완료
			}else{
				map.put("rst", "D");//중복
			}
		}
		
		return map;
	}
	
	public String EncodingCheck(String path) throws Exception{
		String rst = "";
		byte[] buf = new byte[4096]; 
		FileInputStream fis = new FileInputStream(path); 
		UniversalDetector detector = new UniversalDetector(null); 
		int nread;
		while ((nread = fis.read(buf)) > 0 && !detector.isDone()) 
		{ 
			detector.handleData(buf, 0, nread); 
		} 
		detector.dataEnd(); 
		String encoding = detector.getDetectedCharset(); 
		if (encoding != null) {
			rst = encoding;
		}
		detector.reset();
		return rst;
	}
	
}