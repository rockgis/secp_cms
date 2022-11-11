package com.mc.web.programs.front.search.impl;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.solr.client.solrj.SolrClient;
import org.apache.solr.client.solrj.SolrQuery;
import org.apache.solr.client.solrj.SolrQuery.ORDER;
import org.apache.solr.client.solrj.SolrServerException;
import org.apache.solr.client.solrj.impl.HttpSolrClient;
import org.apache.solr.client.solrj.response.FacetField;
import org.apache.solr.client.solrj.response.FacetField.Count;
import org.apache.solr.client.solrj.response.QueryResponse;
import org.apache.solr.common.SolrDocument;
import org.apache.solr.common.SolrDocumentList;
import org.apache.solr.common.SolrInputDocument;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mc.common.util.DateUtil;
import com.mc.common.util.RequestSnack;
import com.mc.common.util.StringUtil;
import com.mc.web.MCMap;
import com.mc.web.programs.front.search.SearchDAO;
import com.mc.web.programs.front.search.SearchHelper;
import com.mc.web.programs.front.search.SearchService;
import com.mc.web.programs.front.social.api.SocialAuthHttp;
import com.mc.web.service.Globals;

import egovframework.com.cmm.util.EgovHttpRequestHelper;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service("SearchService")
public class SearchServiceImpl extends EgovAbstractServiceImpl implements SearchService{
	
	@Autowired
	private SearchHelper helper;
	
	@Autowired
	private SearchDAO dao;
	
	private SolrClient solr = null;
	
	private String start_dt = "";
	private String end_dt = "";

	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public String search(Map params) throws Exception {
		return "programs/search/search";
	}
	
	@Transactional(rollbackFor = {Exception.class})
	public Map searchKeyword(Map<String, Object> params) throws Exception {
		String filter = params.get("filter") == null ? "" : params.get("filter").toString();
		
		Map<String, Object> map = new HashMap<>();
		if ("apply".equals(filter)) {
			map.put("apply", dao.searchKeywordApply(params));
		} else if ("board".equals(filter)) {
			map.put("board", dao.searchKeywordBoard(params));
		} else if ("file".equals(filter)) {
			map.put("file", dao.searchKeywordFile(params));
		} else {
			map.put("apply", dao.searchKeywordApply(params));
			map.put("board", dao.searchKeywordBoard(params));
			map.put("file", dao.searchKeywordFile(params));
		}
		return map;
	}

	private String getFieldQuery(String field, String[] fields, boolean fit, String total_keyword) {
		String q = "(";
		
		if(field == "") {
			for (int i = 0; i < fields.length; i++) {
				String key = fields[i];
				if(i>0) {
					q += " OR ";
				}
				q += (key + ":" + (fit?"*":"")  +  total_keyword + (fit?"*":""));
			}
		}else {
			q += (field + ":" + (fit?"*":"")  +  total_keyword + (fit?"*":""));
		}
		
		q+=")";
		return q;
	}
	
	public MCMap getPageInfo(Map params, SolrDocumentList results){
		MCMap rst = new MCMap();
		rst.putNumber("totalcount", results.getNumFound());
		int totalpage = (int) (results.getNumFound() / (int)(params.get("rows")));
		rst.putNumber("totalpage", totalpage);
		return rst;
	}
	
	public SolrDocumentList getAddHighlightingList(QueryResponse responseSolr){
		SolrDocumentList list = responseSolr.getResults();
		Map<String, Map<String, List<String>>> hmap = responseSolr.getHighlighting();
		for (SolrDocument item : list) {
			String id = (String) item.get("id");
			List<String> tlist = hmap.get(id).get("title");
			List<String> plist = hmap.get(id).get("page_navi");
			List<String> clist = hmap.get(id).get("conts");
			List<String> glist = hmap.get(id).get("group_nm");
			List<String> mlist = hmap.get(id).get("member_nm");
			List<String> fList = hmap.get(id).get("files");
			String title = (tlist==null)?null:tlist.get(0);
			String page_navi = (plist==null)?null:plist.get(0);
			String conts = (clist==null)?null:clist.get(0);
			String group_nm = (glist==null)?null:glist.get(0);
			String member_nm = (mlist==null)?null:mlist.get(0);
			if(title!=null){
				item.put("title", title);
			}
			if(page_navi!=null){
				item.put("page_navi", page_navi);
			}
			if(conts!=null){
				item.put("conts", conts);
			}
			if(group_nm!=null){
				item.put("group_nm", group_nm);
			}
			if(member_nm!=null){
				item.put("member_nm", member_nm);
			}
			if(fList!=null){
				item.put("files", fList);
			}
		}
		return list;
	}
	
	public Map rank(Map params) throws SolrServerException, IOException {
		Map rst = new HashMap();
				
		SolrDocumentList results = null;
		QueryResponse responseSolr = null;

		SolrQuery query = new SolrQuery();
	    query.set("wt","json");
	    query.set("facet.field", "keyword");
	    query.setFacet(true);
	    query.setFacetLimit(10);
	    query.setFacetMinCount(1);

		if("month".equals(params.get("gubun"))){
			solr = new HttpSolrClient(Globals.SOLR_URL+"search_text");
		    query.setQuery("create_dt:["+DateUtil.getMonthCal("yyyyMMddHHmm", -1) +" TO *]");
		    responseSolr = solr.query(".", query);
		    
		    FacetField field = responseSolr.getFacetField("keyword");
			rst.put("list", getCustomList(field));
		}else if("week".equals(params.get("gubun"))){
			solr = new HttpSolrClient(Globals.SOLR_URL+"search_text");

		    query.setQuery("create_dt:["+DateUtil.getDateCal("yyyyMMddHHmm", -7) +" TO *]");
		    responseSolr = solr.query(".", query);
		    
		    FacetField field = responseSolr.getFacetField("keyword");
			rst.put("list", getCustomList(field));
		}else if("day".equals(params.get("gubun"))){

		    query.setQuery("create_dt:["+DateUtil.getDateCal("yyyyMMddHHmm", -1) +" TO *]");
		    responseSolr = solr.query(".", query);
		    
		    FacetField field = responseSolr.getFacetField("keyword");
			rst.put("list", getCustomList(field));
		}
		return rst;
	}
	
	public List getCustomList(FacetField field){
		List list = new ArrayList();
		List<Count> l = field.getValues();
	    for (Count count : l) {
	    	Map m = new HashMap();
	    	m.put("label", count.getName());
	    	list.add(m);
		}
		return list;
	}

	public List autocomplete(String prefix) throws SolrServerException, IOException {
		Map rst = new HashMap();
		List list = new ArrayList();
		SolrDocumentList results = null;
		QueryResponse responseSolr = null;

		SolrQuery query = new SolrQuery();
	    query.set("wt","json");
	    query.set("facet.field", "keyword");
	    query.setQuery("*.*");
	    query.setFacet(true);
	    query.setFacetLimit(10);
	    query.setFacetPrefix(prefix);
	    
	    SolrClient solr = new HttpSolrClient(Globals.SOLR_URL+"search_text");
	    responseSolr = solr.query(".", query);
	    FacetField field = responseSolr.getFacetField("keyword");
	    List<Count> l = field.getValues();
	    for (Count count : l) {
	    	Map m = new HashMap();
	    	m.put("label", count.getName());
	    	m.put("value", count.getName());
	    	list.add(m);
		}

	    rst.put("result", list);
		return list;
	}
	
	public Map crawling(Map params) throws Exception {
    	String jsonStr = SocialAuthHttp.getHttpPost(Globals.SOLR_URL+"gathring/crawling.do", params);
    	JSONObject accessToken = (JSONObject) JSONValue.parse(jsonStr);
		
		return accessToken;
	}
}