package com.mc.web.programs.front.social.api;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import org.json.simple.JSONObject;
import org.json.simple.JSONValue;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.junit.Test;
import org.springframework.stereotype.Component;

import com.mc.web.MCMap;



@Component
public class BlogClient {

	public List timeline(MCMap map) {
		List list = new ArrayList();
		try{
			Document doc = Jsoup.connect(map.getStrNull("blog_rss")).get();
			Elements items = doc.select("item");
			MCMap data = null;
			for (Element item : items) {
				data = new MCMap();
				data.put("uni_id", item.select("guid").text());
				data.put("gubun", map.getStrNull("gubun"));
				data.put("division", map.getStrNull("division"));
				data.put("division_detail", map.getStrNull("division_detail"));
				data.put("org_data", item.toString());
				data.put("reg_dt", formatDate(item.select("pubDate").text()));
//				
//				data.put("described", map.getStrNull("described"));
//				data.put("title", item.select("title").text().replace("<![CDATA[", "").replace("]]>", ""));
//            	data.put("conts", item.select("description").text());
//            	data.put("reg_dt", formatDate(item.select("pubDate").text()));
//            	data.put("link", item.select("guid").text());
            	list.add(data);
			}
			
		}catch(IOException e){
			
		}
		return list;
	}
	
	@Test
	public void s(){
		List list = new ArrayList();
		
		
		try{
			Document doc = Jsoup.connect("http://blog.rss.naver.com/dlckdrl.xml")
//					.userAgent("Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2228.0 Safari/537.36")
					.get();
			
			
			Elements items = doc.select("item");
			Map data = null;
			for (Element item : items) {
				data = new HashMap();
				data.put("title", item.select("title").text().replace("<![CDATA[", "").replace("]]>", ""));
            	data.put("conts", item.select("description").text());
            	data.put("reg_dt", formatDate(item.select("pubDate").text()));
            	data.put("link", item.select("guid").text());
            	String jsonObjet = JSONObject.toJSONString(data);
            	System.out.println(JSONValue.parse(jsonObjet));
			}
			
		}catch(IOException e){
			return;
		}
		
	}
	
	public String formatDate(String created_at){
		//Wed, 07 Oct 2015 11:32:37 +0900
		String dateString;
		try {
			Date date = new SimpleDateFormat("EEE',' dd MMM yyyy HH:mm:ss Z", Locale.ENGLISH).parse(created_at);
			dateString = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(date);
		} catch (ParseException e) {
			dateString = created_at;
			e.printStackTrace();
		}
		return dateString;
	}
	
}
