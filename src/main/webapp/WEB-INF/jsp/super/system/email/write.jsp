<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<div class="contents" data-ng-cloak>
		<!-- <div class="cms_tab">
		  	<ul>
		  		<li><input type="button" value="전송관리" class="btall_on" data-my-href="/list"></li>
		  		<li><input type="button" value="그룹관리" class="btall" data-my-href="/target_list"></li>
		  		<li><input type="button" value="내용관리" class="btall" data-my-href="/form_list"></li>
		  		<li><input type="button" value="호스트관리" class="btall" data-my-href="/smtp_list"></li>
		  	</ul>
        </div> -->
         	
		<form id="wFrm" name="wFrm" method="post" novalidate="novalidate">
	    <table class="type1" style="margin-top:0;">
		    <colgroup>
			    <col style="width:200px;" />
			    <col />
		    </colgroup>
		    <caption>메일 관리</caption>
	    	<tr>
				<th scope="row">제목</th>
				<td>
					<input type="text" class="normal" style="width:50%;" data-ng-model="form.title" required="required"/>
				</td>
			</tr>
	    	<tr>
				<th scope="row">그룹발송</th>
				<td>
					<select class="normal w175" title="그룹 선택" data-ng-model="form.target_seq" data-ng-options="item.seq as item.title for item in target_list" required="required">
						<option value="">회원발송</option>
            		</select>
				</td>
			</tr>
	    	<tr>
				<th scope="row">발송자</th>
				<td>
					<input type="text" class="normal w175" data-ng-model="form.sender_nm" required="required"/>
				</td>
			</tr>
	    	<tr>
				<th scope="row">발송자 메일</th>
				<td>
					<input type="text" class="normal w175" data-ng-model="form.sender_mail" required="required"/>
				</td>
			</tr>
			<tr>
				<th scope="row">내용</th>
				<td>
					<select class="normal w175" title="폼 선택" style="display:block; margin-bottom:10px;" data-ng-model="form.form_seq" data-ng-options="item.seq as item.title for item in form_list" ng-change="formSelect()" >
						<option value="">직접입력</option>
            		</select>
					<textarea style="width:75%;height:400px;" data-ng-model="form.conts" global-editor></textarea>
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
