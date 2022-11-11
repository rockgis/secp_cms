package com.mc.web.programs.back.email;

import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

public interface EmailAdminService{

	public Map list(Map params) throws Exception;
	public Map user_list(Map params) throws Exception;
	public Map write(Map params) throws Exception;
	public Map view(Map params) throws Exception;
	public Map modify(Map params) throws Exception;
	public Map del(Map params) throws Exception;
	public Map target_list(Map params) throws Exception;
	public Map target_write(Map params) throws Exception;
	public Map target_view(Map params) throws Exception;
	public Map queue_list(Map params) throws Exception;
	public Map queue_update(Map params) throws Exception;
	public Map target_modify(Map params) throws Exception;
	public Map target_del(Map params) throws Exception;
	public Map form_list(Map params) throws Exception;
	public Map form_write(Map params) throws Exception;
	public Map form_view(Map params) throws Exception;
	public Map form_modify(Map params) throws Exception;
	public Map form_del(Map params) throws Exception;
	public Map smtp_list(Map params) throws Exception;
	public Map smtp_write(Map params) throws Exception;
	public Map smtp_view(Map params) throws Exception;
	public Map smtp_modify(Map params) throws Exception;
	public Map smtp_del(Map params) throws Exception;
	public Map targetExcelUpload(Map params, MultipartFile excelfile) throws Exception;
	public Map send_mail(Map params) throws Exception;
	public Map smtp_test(Map params) throws Exception;
	public String receive(Map<String, String> params);

}
