<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<div ng-controller="ModifyPwCtrl" title="그룹선택">
		<form id="pFrm" name="pFrm" method="post" data-ng-submit="save()" novalidate="novalidate">
        <table class="type1">
        	<colgroup>
        		<col width="120">
        		<col width="">
        	</colgroup>
        	<tr ng-if="form.member_id==form.session_member_id">
				<th>기존 비밀번호 확인</th>
        		<td>
					<input type="password" style="width:100%;" data-ng-model="form.old_member_pw" id="old_member_pw" name="old_member_pw" class="normal" required autocomplete="off"/>
					<div style="margin-top:5px;" ng-show="pFrm.old_member_pw.$error.required">기존 비밀번호를 입력해주세요.</div>
				</td>
			</tr>
		    <tr>
				<th>비밀번호</th>
        		<td>
					<input type="password" style="width:100%;" data-ng-model="form.member_pw" id="member_pw" name="member_pw" class="normal" maxlength="20" data-ng-minlength="6" data-ng-maxlength="20" data-ng-pattern="/(^.*(?=.{8,15})(?=.*[0-9])(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9_]).*$)|(^.*(?=.{10,15})(?=.*[0-9])(?=.*[a-zA-Z])|(?=.{10,15})(?=.*[^a-zA-Z0-9_])(?=.*[a-zA-Z])|(?=.{10,15})(?=.*[^a-zA-Z0-9_])(?=.*[0-9]).*$)/" required="required" autocomplete="off"/>
					<div style="margin-top:5px;" ng-show="pFrm.member_pw.$error.required">변경하실 비밀번호를 입력하세요.</div>
					<div style="margin-top:5px;" ng-show="pFrm.member_pw.$dirty && pFrm.member_pw.$invalid"><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>
						비밀번호 10자리이상 2조합 or 8자리 이상 3조합으로 입력바랍니다.
					</div>
					<div style="margin-top:5px;" ng-show="pFrm.member_pw.$dirty && pFrm.member_pw.$valid">사용가능한 비밀번호 입니다.</div>
				</td>
			</tr>
		    <tr>
				<th>비밀번호 확인</th>
        		<td>
					<input type="password" style="width:100%;" data-ng-model="form.member_pw_confirm" id="member_pw_confirm" name="member_pw_confirm" class="normal" pw-check="member_pw" required autocomplete="off"/>
					<div style="margin-top:5px;" ng-show="pFrm.member_pw_confirm.$error.required">비밀번호를 한번 더 입력해주세요.</div>
					<div style="margin-top:5px;" ng-show="pFrm.member_pw_confirm.$error.pwmatch"><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>
						비밀번호가 일치하지 않습니다.
					</div>
					<div style="margin-top:5px;" ng-show="pFrm.member_pw_confirm.$dirty && pFrm.member_pw_confirm.$valid">비밀번호가 일치합니다.</div>
				</td>
			</tr>
		</table>
		
		<div class="btn_bottom">
			<div class="r_btn">
				<input type="button" value="저장" class="bt_big_bt4" data-ng-click="save()"/>
			</div>
		</div>
		</form>
	</div>