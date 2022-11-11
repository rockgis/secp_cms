<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
		<div class="contents" data-ng-cloak>
			<!-- <div class="cms_tab">
			  	<ul>
			  		<li><input type="button" value="전송관리" class="btall" data-my-href="/list"></li>
			  		<li><input type="button" value="그룹관리" class="btall" data-my-href="/target_list"></li>
			  		<li><input type="button" value="내용관리" class="btall" data-my-href="/form_list"></li>
			  		<li><input type="button" value="호스트관리" class="btall_on" data-my-href="/smtp_list"></li>
			  	</ul>
          	</div> -->
          	
			<form id="wFrm" name="wFrm" method="post" novalidate="novalidate">
		    <table class="type1" style="margin-top:0;">
			    <colgroup>
				    <col style="width:200px;" />
				    <col />
			    </colgroup>
		    	<caption>호스트관리</caption>
		    	<tr>
					<th scope="row">호스트관리</th>
					<td>
						<input type="text" class="normal w175" data-ng-model="form.title" required="required" placeholder="호스트명"/>
					</td>
				</tr>
				<tr>
					<th scope="row">SMTP HOST</th>
					<td>
						<input type="text" class="normal w175" data-ng-model="form.host" required="required" placeholder="smtp.cafe24.com"/>
					</td>
				</tr>
				<tr>
					<th scope="row">SMTP PORT</th>
					<td>
						<input type="text" class="normal w175" data-ng-model="form.port" required="required" placeholder="25"/>
					</td>
				</tr>
				<tr>
					<th scope="row">관리 아이디</th>
					<td>
						<input type="text" class="normal w175" data-ng-model="form.auth_id" autocomplete="off"/>
					</td>
				</tr>
				<tr>
					<th scope="row">관리 비밀번호</th>
					<td>
						<input type="password" class="normal w175" data-ng-model="form.auth_pw" autocomplete="off"/>
					</td>
				</tr>
				<tr>
					<th scope="row">SSL 사용</th>
					<td>
						<ol class="select">
							<li class="first"><label><input type="radio" data-ng-model="form.ssl_yn" value="Y"/> 사용</label></li>
							<li><label><label><input type="radio" data-ng-model="form.ssl_yn" value="N" data-ng-init="form.ssl_yn = 'N'"/> 사용안함</label></li>
						</ol>
					</td>
				</tr>
				<tr>
					<th scope="row">TLS 사용</th>
					<td>
						<ol class="select">
							<li class="first"><label><input type="radio" data-ng-model="form.tls_yn" value="Y"/> 사용</label></li>
							<li><label><input type="radio" data-ng-model="form.tls_yn" value="N" data-ng-init="form.tls_yn = 'N'"/> 사용안함</label></li>
						</ol>
					</td>
				</tr>
		    </table>
		    
		    <div class="btn_bottom">
		    	<div class="r_btn">
			        <input type="button" value="저장" class="bt_big_bt4" data-ng-click="save()"/>
			        <input type="button" value="취소" class="bt_big_bt3" onclick="window.history.go(-1);"/>
		        </div>
		    </div>
		    
			</form>
		</div>
