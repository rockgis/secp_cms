<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"  uri="http://www.springframework.org/security/tags" %>
<div class="contents" data-ng-cloak>
	<!-- 
	<div class="cms_tab">
	  	<ul>
	  		<li><input type="button" value="전송관리" class="btall" data-my-href="/list"></li>
	  		<li><input type="button" value="그룹관리" class="btall_on" data-my-href="/target_list"></li>
	  		<li><input type="button" value="내용관리" class="btall" data-my-href="/form_list"></li>
	  		<li><input type="button" value="호스트관리" class="btall" data-my-href="/smtp_list"></li>
	  	</ul>
    </div>
     -->
        	
	<form id="wFrm" name="wFrm" method="post" novalidate="novalidate" enctype="multipart/form-data">
	<sec:csrfInput />
    <table class="type1">
	    <colgroup>
		    <col style="width:200px;" />
		    <col />
	    </colgroup>
    	<caption>그룹 관리</caption>
    	<tr>
			<th scope="row">그룹명</th>
			<td>
				<input type="text" class="normal w175" data-ng-model="form.title" required="required"/>
			</td>
		</tr>
    	<tr>
			<th scope="row">회원선택</th>
			<td>
           		<button class="bt_small page2 ui-selectee" value="선택" data-ng-click="openUserSelect()" onclick="return false;">선택</button>
			</td>
		</tr>
		<tr>
			<th scope="row">엑셀일괄등록</th>
			<td>
				<input type="button" value="샘플다운로드" class="btalls" style="display:block; margin-bottom:10px;" data-ng-click="sampleDownload()">
				<input type="file" id="excelfile" name="excelfile" onchange="angular.element(this).scope().upload()"/>
			</td>
		</tr>
		<tr>
			<th scope="row">그룹리스트</th>
			<td>
				<div style="margin-bottom:10px;">
					<input type="text" class="normal w100" ng-model="form.temp_name" placeholder="이름">
					<input type="text" class="normal w175" ng-model="form.temp_email" ng-pattern="/^[a-z]+[a-z0-9._]+@[a-z]+\.[a-z.]{2,5}$/" placeholder="이메일">
					<input type="button" class="btalls" value="추가" data-ng-click="addEmail()" />
				</div>
				<div style="height:400px; overflow-y:scroll;">
					<table class="type1" style="margin-top:0;">
						<colgroup>
							<col />
							<col style="width:35%;" />
							<col style="width:6%;" />
						</colgroup>
						<tr>
							<th scope="col" class="center">이름</th>
							<th scope="col" class="center">이메일</th>
							<th scope="col" class="center">삭제</th>
						</tr>
						<tr data-ng-repeat="item in form.target_list">
							<td class="center">{{item.user_name}}</td>
							<td class="center">{{item.user_email}}</td>
							<td class="center"><input type="button" value="삭제" class="btalls" data-ng-click="removeEmail($index)"></td>
						</tr>
					</table>
				</div>
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
