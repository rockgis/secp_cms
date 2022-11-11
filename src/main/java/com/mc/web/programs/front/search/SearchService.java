package com.mc.web.programs.front.search;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.apache.solr.client.solrj.SolrServerException;

public interface SearchService{

	public String search(Map params) throws Exception;
	
	public Map searchKeyword(Map<String, Object> params) throws Exception;
	
	public Map rank(Map params) throws SolrServerException, IOException;

	public List autocomplete(String prefix) throws SolrServerException, IOException ;
	public Map crawling(Map params) throws Exception;
	
}