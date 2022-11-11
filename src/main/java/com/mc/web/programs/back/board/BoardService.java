package com.mc.web.programs.back.board;

import java.util.List;
import java.util.Map;

public interface BoardService{
	public Map list(Map params) throws Exception;
	public Map menu_list(Map params) throws Exception;
	public Map insert(Map params) throws Exception;
	public Map modify(Map params) throws Exception;
	public Map info(Map params) throws Exception;
	public Map delete(Map params) throws Exception;
	public List<Map> customColumnList() throws Exception;
	public List<Map> customElementList(Map params) throws Exception;
	public List<Map> typeList() throws Exception;
	public Map typeInsert(Map<String, String> params);
	public Map typeModify(Map<String, String> params);
	public Map typeDelete(Map<String, String> params) throws Exception;
}