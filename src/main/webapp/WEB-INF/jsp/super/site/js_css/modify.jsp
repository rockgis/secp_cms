<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
		<div class="contents" data-ng-cloak>
			<div class="cj_management">
				<h4>CSS 관리</h4>
			    <table class="type1">
			    	<colgroup>
				    	<col width="120px" />
				    	<col width="65px" />
				    	<col width="150px" />
				    	<col width="*" />
				    </colgroup>
				    <caption>기본설정</caption>
			    	<tr>
						<th>공통</th>
						<th><input type="button" value="관리" class="btalls" data-ng-click="openJsCssManage('common.css')"></th>
						<td>common.css</td>
						<td><span style="margin-left:10px;">최종수정 : {{main.common_css.reg_nm}}({{main.common_css.reg_id}}) &nbsp;&nbsp;&nbsp; {{main.common_css.reg_dt|myDate:'yyyy-MM-dd HH:mm'}}</span></td>
					</tr>
					<tr>
						<th>메인페이지</th>
						<th><input type="button" value="관리" class="btalls" data-ng-click="openJsCssManage('main.css')"></th>
						<td>main.css</td>
						<td><span style="margin-left:10px;">최종수정 : {{main.common_css.reg_nm}}({{main.common_css.reg_id}}) &nbsp;&nbsp;&nbsp; {{main.common_css.reg_dt|myDate:'yyyy-MM-dd HH:mm'}}</span></td>
					</tr>
					<tr>
						<th>서브페이지</th>
						<th><input type="button" value="관리" class="btalls" data-ng-click="openJsCssManage('sub.css')"></th>
						<td>sub.css</td>
						<td><span style="margin-left:10px;">최종수정 : {{main.sub_css.reg_nm}}({{main.sub_css.reg_id}}) &nbsp;&nbsp;&nbsp; {{main.sub_css.reg_dt|myDate:'yyyy-MM-dd HH:mm'}}</span></td>
					</tr>
					<tr>
						<th>게시판</th>
						<th><input type="button" value="관리" class="btalls" data-ng-click="openJsCssManage('article.css')"></th>
						<td>article.css</td>
						<td><span style="margin-left:10px;">최종수정 : {{main.article_css.reg_nm}}({{main.article_css.reg_id}}) &nbsp;&nbsp;&nbsp; {{main.article_css.reg_dt|myDate:'yyyy-MM-dd HH:mm'}}</span></td>
					</tr>
			    </table>
			    <h4 style="margin-top:30px;">JAVASCRIPT 관리</h4>
			    <table class="type1">
			    	<colgroup>
				    	<col width="120px" />
				    	<col width="65px" />
				    	<col width="150px" />
				    	<col width="*" />
				    </colgroup>
				    <caption>기본설정</caption>
			    	<tr>
						<th>공통</th>
						<th><input type="button" value="관리" class="btalls" data-ng-click="openJsCssManage('common.js')"></th>
						<td>common.js</td>
						<td><span style="margin-left:10px;">최종수정 : {{main.common_js.reg_nm}}({{main.common_js.reg_id}}) &nbsp;&nbsp;&nbsp; {{main.common_js.reg_dt|myDate:'yyyy-MM-dd HH:mm'}}</span></td>
					</tr>
			    	<tr>
						<th>메인페이지</th>
						<th><input type="button" value="관리" class="btalls" data-ng-click="openJsCssManage('main.js')"></th>
						<td>main.js</td>
						<td><span style="margin-left:10px;">최종수정 : {{main.main_js.reg_nm}}({{main.main_js.reg_id}}) &nbsp;&nbsp;&nbsp; {{main.main_js.reg_dt|myDate:'yyyy-MM-dd HH:mm'}}</span></td>
					</tr>
			    	<tr>
						<th>서브페이지</th>
						<th><input type="button" value="관리" class="btalls" data-ng-click="openJsCssManage('sub.js')"></th>
						<td>sub.js</td>
						<td><span style="margin-left:10px;">최종수정 : {{main.sub_js.reg_nm}}({{main.sub_js.reg_id}}) &nbsp;&nbsp;&nbsp; {{main.sub_js.reg_dt|myDate:'yyyy-MM-dd HH:mm'}}</span></td>
					</tr>
			    </table>
		    </div>
		</div>
