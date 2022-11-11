package com.mc.web.programs.back.filemanager;

import java.util.Map;

public interface FilemanagerService{

	public Map list(Map<String, String> params) throws Exception;
	public Map filelist(Map<String, String> params) throws Exception;
	public Map getRealFile(Map<String, String> params) throws Exception;
	public Map modifyRealFile(Map<String, String> params) throws Exception;
	public Map source_list(Map<String, String> params) throws Exception;
	public Map previous_source(Map<String, String> params) throws Exception;
	public Map createFolder(Map<String, String> params) throws Exception;
	public Map renameTo(Map<String, String> params) throws Exception;
	public Map delete(Map<String, String> params) throws Exception;

}
