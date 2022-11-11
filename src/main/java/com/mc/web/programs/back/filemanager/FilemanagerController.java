package com.mc.web.programs.back.filemanager;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.json.simple.JSONValue;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import com.mc.common.util.StringUtil;


@Controller
public class FilemanagerController {
	
	@Autowired
	private FilemanagerService service;
	
	@Autowired
	private FilemanagerHelper helper;

	@ResponseBody
	@RequestMapping("/super/system/filemanager/list.do")
	public Map list(@RequestParam Map<String, String> params, HttpServletRequest request, HttpSession session) throws Exception{
		return service.list(params);
	}

	@ResponseBody
	@RequestMapping("/super/system/filemanager/filelist.do")
	public Map filelist(@RequestParam Map<String, String> params, HttpServletRequest request, HttpSession session) throws Exception{
		return service.filelist(params);
	}

	@ResponseBody
	@RequestMapping("/super/system/filemanager/getRealFile.do")
	public Map getRealFile(@RequestParam Map<String, String> params, HttpServletRequest request, HttpSession session) throws Exception{
		return service.getRealFile(params);
	}

	@ResponseBody
	@RequestMapping("/super/system/filemanager/modifyRealFile.do")
	public Map modifyRealFile(@RequestParam Map<String, Object> jsonObject, HttpServletRequest request, HttpSession session) throws Exception{
		Map params = (JSONObject) JSONValue.parse((String)jsonObject.get("jData"));	//JSON으로 보내준 데이터를 사용
		return service.modifyRealFile(params);
	}

	@ResponseBody
	@RequestMapping("/super/system/filemanager/source_list.do")
	public Map source_list(@RequestParam Map<String, String> params, HttpServletRequest request, HttpSession session) throws Exception{
		return service.source_list(params);
	}

	@ResponseBody
	@RequestMapping("/super/system/filemanager/previous_source.do")
	public Map previous_source(@RequestParam Map<String, String> params, HttpServletRequest request, HttpSession session) throws Exception{
		return service.previous_source(params);
	}

	@ResponseBody
	@RequestMapping("/super/system/filemanager/createFolder.do")
	public Map createFolder(@RequestParam Map<String, String> params, HttpServletRequest request, HttpSession session) throws Exception{
		return service.createFolder(params);
	}

	@ResponseBody
	@RequestMapping("/super/system/filemanager/renameTo.do")
	public Map renameTo(@RequestParam Map<String, String> params, HttpServletRequest request, HttpSession session) throws Exception{
		return service.renameTo(params);
	}

	@ResponseBody
	@RequestMapping("/super/system/filemanager/delete.do")
	public Map delete(@RequestParam Map<String, String> params, HttpServletRequest request, HttpSession session) throws Exception{
		return service.delete(params);
	}
	@RequestMapping("/super/system/filemanager/upload.do")
	public String ajaxUpload(MultipartHttpServletRequest request, 
			@RequestParam(value = "file_path", defaultValue="/") String file_path, 
			@RequestParam(value = "file_name", defaultValue="file") String file_name, 
			@RequestParam(value = "ignore", defaultValue="N") String ignore) throws Exception{
		Map rst = null;
		
		Map<String, MultipartFile> files = request.getFileMap();
		CommonsMultipartFile file = (CommonsMultipartFile) files.get(file_name);
		
		rst = helper.uploadFile(request.getSession().getServletContext().getRealPath(StringUtil.fileClearXSS(file_path)), file, ignore);
		request.setAttribute("json", rst);
		return "json";
	}
	
}
