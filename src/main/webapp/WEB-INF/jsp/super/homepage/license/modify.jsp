<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="contents_wrap">
	<div class="ct_wrap">
		<div class="conwrap_tap">
			<ul>
				<li id='contManagerTab' ng-if="param.permit=='Y'"><a href="<c:url value="/super/homepage/modifyFrm.do"/>?cms_menu_seq={{param.cms_menu_seq}}&amp;parent_menu_seq={{param.parent_menu_seq }}&amp;permit={{param.permit}}"><span>메뉴관리</span></a></li>
				<li class="on"><a href=?cms_menu_seq={{param.cms_menu_seq}}&amp;parent_menu_seq={{param.parent_menu_seq}}&amp;permit={{param.permit}}" target="_self"><span>프로그램관리</span></a></li>
			</ul>
		</div>
		<div class="contents">
	    <form id="wFrm" name="wFrm" method="post" novalidate="novalidate">
		<sec:csrfInput />
	      	<table class="type1" style="margin-top:0;">
	        	<colgroup>
	          		<col width="200px" />
	          		<col width="*" />
	        	</colgroup>
	        	<tr>
	          		<th>구분</th>
	          		<td>
	          			<select data-ng-model="form.gubun" class="normal w175">
							<option ng-value="0">개발</option>
							<option ng-value="1">운영</option>
						</select>
	          		</td>
	        	</tr>
	        	<tr>
	          		<th>성명</th>
	          		<td><input type="text" class="normal" style="width:100%" data-ng-model="form.name" required/></td>
	        	</tr>
	        	<tr>
	          		<th>이메일</th>
	          		<td><input type="email" class="normal w175" style="width:100%" data-ng-model="form.email" required/></td>
	        	</tr>
	        	<tr>
	          		<th>소속/회사</th>
	          		<td><input type="text" class="normal w175" style="width:100%" data-ng-model="form.company" required/></td>
	        	</tr>
	        	<tr>
	          		<th>발급일</th>
	          		<td><input type="text" class="normal w175" style="position:relative; z-index:100; margin-right:3px;" data-ng-model="form.issued_dt" required datetimepicker/></td>
	        	</tr>
	        	<tr ng-if="form.gubun=='1'">
	          		<th>Mac 주소</th>
	          		<td><input type="text" class="normal" style="width:100%" data-ng-model="form.mac_address" required ng-pattern="/^([0-9a-fA-F][0-9a-fA-F][:\-]){5}[0-9a-fA-F]{2}$/"/></td>
	        	</tr>
	        	<tr>
	          		<th>빌드ID</th>
	          		<td><input type="text" class="normal w175" style="width:100%" data-ng-model="form.build_id" required disabled="disabled"/></td>
	        	</tr>
	        	<tr>
	          		<th>버전</th>
	          		<td><input type="text" class="normal" style="width:100%" data-ng-model="form.version" required /></td>
	        	</tr>
	      	</table>
		  	<div class="btn_bottom">
	        	<div class="r_btn">
	          		<input type="button" value="등록" class="bt_big_bt4" data-ng-click="save()"/>
	          		<input type="button" value="목록" class="bt_big_bt2" data-ng-click="list()"/>
	        	</div>
	      	</div>
		</form>  
	    </div>
	</div>
		
	<div id="topBar">
    	<div class="topBar_inner">
			<bookmark userid="${sessionScope.cms_member.member_id }"></bookmark>
		</div>
		<span class="optBtn"><a href="javascript:void(0)"><img src="/images/cms/opt_close.gif" alt=""></a></span>
    </div>
</div>
