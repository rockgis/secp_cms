<%@ page language="java" contentType="text/plain; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="org.json.simple.JSONObject" %>
<%@ page import="org.json.simple.JSONArray" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.*" %>
<%
String json="";
Object obj = request.getAttribute("json");
if(obj instanceof Map){
	Map<String, String> data = (Map)obj;
	json = JSONObject.toJSONString(data);
}else if(obj instanceof List){
	List data = (List)obj;
	json = JSONArray.toJSONString(data);
}
out.print(json);
%>