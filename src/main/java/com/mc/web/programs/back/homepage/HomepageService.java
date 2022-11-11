package com.mc.web.programs.back.homepage;

import java.util.List;
import java.util.Map;


public interface HomepageService{
	
	public String dashboard(Map params) throws Exception;
	public List left_list(Map params) throws Exception;
	public Map view(Map params) throws Exception;
	public String modifyFrm(Map params) throws Exception;
	public String contentFrm(Map params) throws Exception;
	public Map write(Map params) throws Exception;
	public Map modify(Map params) throws Exception;
	public Map contentSave(Map params) throws Exception;
	public Map temp_save(Map params) throws Exception;
	public Map backup_list(Map params) throws Exception;
	public Map content_backup_list(Map params) throws Exception;
	public Map menu_move(Map params) throws Exception;
	public Map del(Map params) throws Exception;
	public Map page_navi(Map params) throws Exception;
	public String left() throws Exception;
	public Map update_favorites(Map params);
	public List get_favorites(Map params);
	public Map get_menu_toggle(Map params);
	public Map update_menu_toggle(Map params);
	public String help(Map params) throws Exception;
	public String header(Map params) throws Exception;
	public Map overplus(Map params) throws Exception;
	public Map alram_close(Map params) throws Exception;

}