package com.mc.web.programs.front.social.api;
import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.HashMap;
import java.util.Map;

import org.apache.log4j.Logger;
import org.junit.Test;

import com.google.api.client.auth.oauth2.Credential;
import com.google.api.client.http.GenericUrl;
import com.google.api.client.http.HttpRequest;
import com.google.api.client.http.HttpRequestFactory;
import com.google.api.client.http.HttpResponse;
import com.google.api.client.http.HttpTransport;
import com.google.api.client.http.UrlEncodedContent;
import com.google.api.client.http.javanet.NetHttpTransport;

public class SocialAuthHttp {
	Logger log = Logger.getLogger(SocialAuthHttp.class);

	public static String getHttpGet(String http_url) throws Exception {
		HttpTransport transport =  new NetHttpTransport();
    	HttpRequestFactory requestFactory = transport.createRequestFactory();
    	HttpResponse httpResponse = requestFactory.buildGetRequest(new GenericUrl(http_url)).execute();            
    	
    	StringBuffer buffer = new StringBuffer();
    	BufferedReader reader = new BufferedReader(new InputStreamReader(httpResponse.getContent(), "UTF8"));
		String dataLine = null;
		while((dataLine = reader.readLine()) != null){
			buffer.append(dataLine);
		}
		return buffer.toString();
	}

	public static String getHttpGet(String http_url, Credential credential) throws Exception {
		HttpTransport transport =  new NetHttpTransport();
    	HttpRequestFactory requestFactory = transport.createRequestFactory(credential);
    	HttpResponse httpResponse = requestFactory.buildGetRequest(new GenericUrl(http_url)).execute();            
    	
    	StringBuffer buffer = new StringBuffer();
    	BufferedReader reader = new BufferedReader(new InputStreamReader(httpResponse.getContent(), "UTF8"));
		String dataLine = null;
		while((dataLine = reader.readLine()) != null){
			buffer.append(dataLine);
		}
		return buffer.toString();
	}

	public static String getHttpPost(String http_url, Map params) throws Exception {
		HttpTransport transport =  new NetHttpTransport();
    	HttpRequestFactory requestFactory = transport.createRequestFactory();
    	HttpRequest request = requestFactory.buildPostRequest(new GenericUrl(http_url), new UrlEncodedContent(params));
    	
    	HttpResponse httpResponse = request.execute();            
    	StringBuffer buffer = new StringBuffer();
    	BufferedReader reader = new BufferedReader(new InputStreamReader(httpResponse.getContent(), "UTF8"));
		String dataLine = null;
		while((dataLine = reader.readLine()) != null){
			buffer.append(dataLine);
		}
		return buffer.toString();
	}

	public static String getHttpPost(String http_url, Credential credential, Map params) throws Exception {
		HttpTransport transport =  new NetHttpTransport();
    	HttpRequestFactory requestFactory = transport.createRequestFactory(credential);
    	HttpRequest request = requestFactory.buildPostRequest(new GenericUrl(http_url), new UrlEncodedContent(params));
    	
    	HttpResponse httpResponse = request.execute();            
    	StringBuffer buffer = new StringBuffer();
    	BufferedReader reader = new BufferedReader(new InputStreamReader(httpResponse.getContent(), "UTF8"));
		String dataLine = null;
		while((dataLine = reader.readLine()) != null){
			buffer.append(dataLine);
		}
		return buffer.toString();
	}

}
