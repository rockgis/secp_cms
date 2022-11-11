package com.mc.web.programs.back.email.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.Future;

import javax.servlet.http.HttpServletRequest;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.mc.common.util.StringUtil;
import com.mc.web.MCMap;
import com.mc.web.programs.back.email.EmailAdminDAO;
import com.mc.web.programs.back.email.EmailAdminHelper;
import com.mc.web.programs.back.email.EmailAdminService;
import com.mc.web.common.SessionInfo;

import egovframework.com.cmm.util.EgovHttpRequestHelper;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service("EmailAdminService")
public class EmailAdminServiceImpl extends EgovAbstractServiceImpl implements EmailAdminService{
	
	@Autowired
	private EmailAdminDAO dao;
	@Autowired
	private EmailAdminHelper helper;
	
	private Future<String> ajob = null;
	
	public Map list(Map params) throws Exception {
		Map rstMap = new HashMap();
		rstMap.put("list", dao.list(params));
		rstMap.put("pagination", dao.pagination(params));
		return rstMap;
	}
	
	public Map user_list(Map params) throws Exception {
		Map rstMap = new HashMap();
		List<String> groupList = StringUtil.strToList((String)params.get("group_seqs"), ",");
		params.put("seq_list", groupList);
		rstMap.put("list", dao.user_list(params));
		return rstMap;
	}

	public Map write(Map params) throws Exception {
		SessionInfo.sessionAuth(params);
		Map rstMap = new HashMap();
		rstMap.put("rst", dao.write(params));
		
		Map p = new HashMap();
		p.put("seq", params.get("target_seq"));
		List<MCMap> list = dao.target_list_dtl(p);
		for (MCMap map : list) {
			map.put("p_seq", params.get("seq"));
			dao.insert_mail_queue(map);
		}
		return rstMap;
	}
	
	public Map modify(Map params) throws Exception {
		SessionInfo.sessionAuth(params);
		Map rstMap = new HashMap();
		rstMap.put("rst", dao.modify(params));
		
		dao.delete_mail_queue(params);
		Map p = new HashMap();
		p.put("seq", params.get("target_seq"));
		List<MCMap> list = dao.target_list_dtl(p);
		for (MCMap map : list) {
			map.put("p_seq", params.get("seq"));
			dao.insert_mail_queue(map);
		}
		return rstMap;
	}
	
	public MCMap view(Map params) throws Exception {
		return dao.view(params);
	}
	
	public Map del(Map params) throws Exception {
		SessionInfo.sessionAuth(params);
		Map rstMap = new HashMap();
		rstMap.put("rst", dao.del(params));
		return rstMap;
	}
	
	public Map target_list(Map params) throws Exception {
		Map rstMap = new HashMap();
		rstMap.put("list", dao.target_list(params));
		rstMap.put("pagination", dao.target_pagination(params));
		return rstMap;
	}

	public Map target_write(Map params) throws Exception {
		SessionInfo.sessionAuth(params);
		Map rstMap = new HashMap();
		rstMap.put("rst", dao.target_write(params));
		
		List list = (List) params.get("target_list");
		if(list != null){
			for (int i = 0; i < list.size(); i++) {
				Map m = (Map) list.get(i);
				m.put("p_seq", params.get("p_seq"));
				dao.target_list_write(m);
			}
		}
		return rstMap;
	}
	
	public Map target_modify(Map params) throws Exception {
		SessionInfo.sessionAuth(params);
		Map rstMap = new HashMap();
		rstMap.put("rst", dao.target_modify(params));

		dao.target_list_del(params);
		List list = (List) params.get("target_list");
		if(list != null){
			for (int i = 0; i < list.size(); i++) {
				Map m = (Map) list.get(i);
				m.put("p_seq", params.get("seq"));
				dao.target_list_write(m);
			}
		}
		return rstMap;
	}
	
	public Map target_view(Map params) throws Exception {
		Map rstMap = new HashMap();
		rstMap.put("view", dao.target_view(params));
		rstMap.put("target_list", dao.target_list_dtl(params));
		return rstMap;
	}
	
	public Map target_del(Map params) throws Exception {
		SessionInfo.sessionAuth(params);
		Map rstMap = new HashMap();
		rstMap.put("rst", dao.target_del(params));
		return rstMap;
	}
	
	public Map queue_list(Map params) throws Exception {
		Map rstMap = new HashMap();
		rstMap.put("list", dao.queue_list(params));
		return rstMap;
	}
	
	public Map queue_update(Map params) throws Exception {
		Map rstMap = new HashMap();
		
		dao.delete_mail_queue(params);
		Map p = new HashMap();
		p.put("seq", params.get("target_seq"));
		List<MCMap> list = dao.target_list_dtl(p);
		for (MCMap map : list) {
			map.put("p_seq", params.get("seq"));
			dao.insert_mail_queue(map);
		}
		rstMap.put("rst", "1");
		return rstMap;
	}
	
	public Map form_list(Map params) throws Exception {
		Map rstMap = new HashMap();
		rstMap.put("list", dao.form_list(params));
		rstMap.put("pagination", dao.form_pagination(params));
		return rstMap;
	}

	public Map form_write(Map params) throws Exception {
		SessionInfo.sessionAuth(params);
		Map rstMap = new HashMap();
		rstMap.put("rst", dao.form_write(params));
		return rstMap;
	}
	
	public Map form_modify(Map params) throws Exception {
		SessionInfo.sessionAuth(params);
		Map rstMap = new HashMap();
		rstMap.put("rst", dao.form_modify(params));
		return rstMap;
	}
	
	public MCMap form_view(Map params) throws Exception {
		return dao.form_view(params);
	}
	
	public Map form_del(Map params) throws Exception {
		SessionInfo.sessionAuth(params);
		Map rstMap = new HashMap();
		rstMap.put("rst", dao.form_del(params));
		return rstMap;
	}
	
	public Map smtp_list(Map params) throws Exception {
		Map rstMap = new HashMap();
		rstMap.put("list", dao.smtp_list(params));
		rstMap.put("pagination", dao.smtp_pagination(params));
		return rstMap;
	}
	
	public Map smtp_write(Map params) throws Exception {
		SessionInfo.sessionAuth(params);
		Map rstMap = new HashMap();
		rstMap.put("rst", dao.smtp_write(params));
		return rstMap;
	}
	
	public Map smtp_modify(Map params) throws Exception {
		SessionInfo.sessionAuth(params);
		Map rstMap = new HashMap();
		rstMap.put("rst", dao.smtp_modify(params));
		return rstMap;
	}
	
	public MCMap smtp_view(Map params) throws Exception {
		return dao.smtp_view(params);
	}
	
	public Map smtp_test(Map params) throws Exception {
		MCMap map = dao.get_smtp_config(params);
		return helper.mail_test(map);
	}
	
	public Map smtp_del(Map params) throws Exception {
		SessionInfo.sessionAuth(params);
		Map rstMap = new HashMap();
		rstMap.put("rst", dao.smtp_del(params));
		return rstMap;
	}

	public Map targetExcelUpload(Map params, MultipartFile excelfile) throws Exception {
		Map rstMap = new HashMap();
		List list = new ArrayList();
		
		POIFSFileSystem fs = new POIFSFileSystem(excelfile.getInputStream());
		HSSFWorkbook workbook = new HSSFWorkbook(fs);
		
		HSSFSheet sheet = workbook.getSheetAt(0);
		int rows = sheet.getPhysicalNumberOfRows();
		
		
		MCMap data = null;
		for (int i = 1; i < rows; i++) {
			// 시트에 대한 행을 하나씩 추출
            HSSFRow row   = sheet.getRow(i);
			if (row != null) {
				if(getCellValue(row.getCell(1)) == null || getCellValue(row.getCell(1)) == ""){
					continue;
				}
				data = new MCMap();
				data.put("user_name"	, getCellValue(row.getCell(0)));
				data.put("user_email"	, getCellValue(row.getCell(1)));
				list.add(data);
			}
		}
		rstMap.put("list", list);
		return rstMap;
	}
	
	private String getCellValue(HSSFCell cell){
		String value = "";
		if (cell != null) {
			switch (cell.getCellType()) {
			case HSSFCell.CELL_TYPE_FORMULA:
				value = "" + cell.getCellFormula();
				break;
			case HSSFCell.CELL_TYPE_NUMERIC:
				value = Long.toString((long)cell.getNumericCellValue()) + ""; // double
				break;
			case HSSFCell.CELL_TYPE_STRING:
				value = "" + cell.getStringCellValue(); // String
				break;
			case HSSFCell.CELL_TYPE_BLANK:
				value = "";
				break;
			case HSSFCell.CELL_TYPE_BOOLEAN:
				value = "" + cell.getBooleanCellValue(); // boolean
				break;
			case HSSFCell.CELL_TYPE_ERROR:
				value = "" + cell.getErrorCellValue(); // byte
				break;
			default:
				value = "";
			}
		}
		return value;
	}
	
	public Map send_mail(Map params) throws Exception {
		Map rmap = new HashMap();

		HttpServletRequest req = EgovHttpRequestHelper.getCurrentRequest();
		String home_url = req.getScheme() + "://"
			    +  req.getServerName()
			    +  (req.getServerPort()==80||req.getScheme()=="https"?"":":"+req.getServerPort());
		params.put("home_url", home_url);
		
		String rst = "R";
		if(ajob == null){
			helper.send_result(params);
			ajob  = helper.future_send_mail(params);
		}else{
			if(ajob.isDone()){
				helper.send_result(params);
				ajob  = helper.future_send_mail(params);
			}else{
				rst = "P";
				rmap.put("cnt", helper.send_mail_cnt(params));
			}
		}
		rmap.put("rst", rst);
		return rmap;
	}

	@Override
	public String receive(Map<String, String> params) {
		dao.receive(params);
		return "";
	}
	
}
