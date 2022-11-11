package com.mc.web.programs.front.docview;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.mc.web.MCMap;
import com.mc.web.service.CmsAbstractDAO;


@Repository
public class DocviewDAO extends CmsAbstractDAO {
	
	public MCMap getArticle(Map<String, String> params){
		return (MCMap) selectOne("attach.article", params);
	}
}
