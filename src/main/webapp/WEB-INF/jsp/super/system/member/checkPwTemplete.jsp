<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<div ng-controller="checkPwCtrl" title="그룹선택">
		<form id="pFrm" name="pFrm" method="post" data-ng-submit="save()" novalidate="novalidate">
        <table class="type1">
        	<colgroup>
        		<col width="120">
        		<col width="">
        	</colgroup>
			<tr>
				<th>관리자 비밀번호 확인</th>
        		<td>
					<input type="password" style="width:100%;" data-ng-model="form.super_member_pw" id="super_member_pw" name="super_member_pw" class="normal" required autocomplete="off"/>
					<div style="margin-top:5px;" ng-show="pFrm.super_member_pw.$error.required">관리자 비밀번호를 입력해주세요.</div>
				</td>
			</tr>
		</table>
		
		<div class="btn_bottom">
			<div class="r_btn">
				<input type="button" value="확인" class="bt_big_bt4" data-ng-click="enter()"/>
			</div>
		</div>
		</form>
	</div>