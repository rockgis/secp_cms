<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
		<div class="contents" data-ng-cloak>
			<form id="wFrm" name="wFrm" method="post" novalidate="novalidate" data-ng-submit="save()">
	        <table class="type1" style="margin-top:0;">
	        	<colgroup>
	        		<col width="140">
	        		<col width="">
	        	</colgroup>
				<tr>
	        		<th>아이디 <b class="essential">*</b></th>
	        		<td>{{form.member_id}}</td>
	        	</tr>
	        	<tr>
	        		<th>이름 <b class="essential">*</b></th>
	        		<td>{{form.member_nm}}</td>
	        	</tr>
	        	<tr>
					<th>직위 <b class="essential">*</b></th>
		       		<td>
						<input type="text" class="normal w175" data-ng-model="form.positions" style="width:100%;" required="required" />
					</td>
				</tr>	
				<tr>
	        		<th>비밀번호확인 <b class="essential">*</b></th>
	        		<td>
	        			<div id="pw_div">
							<input type="password" data-ng-model="form.member_pw_check" name="member_pw_check" class="normal w175" maxlength="16" required="required" ng-init="on_pw_check()"/>
							<input type="button" value="확인" class="btalls" data-ng-click="pw_check()">
							<div style="margin-top:5px;" ng-show="wFrm.member_pw_check.$invalid">
								<span class="ui-icon ui-icon-alert" style="display:inline-block;"></span>
								<span>관리자정보를 변경하시려면 비밀번호를 입력해주세요.</span>
							</div>
							<div style="margin-top:5px;" ng-show="wFrm.member_pw_check.$valid">
								<span class="ui-icon ui-icon-check" style="display:inline-block;"></span>
								<span style="color:#658ede; font-weight:500;">확인</span>
							</div>
						</div>
					</td>
	        	</tr>
				<tr>
	        		<th>새 비밀번호</th>
	        		<td>
						<input type="password" data-ng-model="form.member_pw" name="member_pw" class="normal w175" maxlength="20" data-ng-minlength="6" data-ng-maxlength="20" data-ng-pattern="/(^.*(?=.{8,15})(?=.*[0-9])(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9_]).*$)|(^.*(?=.{10,15})(?=.*[0-9])(?=.*[a-zA-Z])|(?=.{10,15})(?=.*[^a-zA-Z0-9_])(?=.*[a-zA-Z])|(?=.{10,15})(?=.*[^a-zA-Z0-9_])(?=.*[0-9]).*$)/" />
						<div style="margin-top:5px;" ng-show="wFrm.member_pw.$dirty && wFrm.member_pw.$invalid">
							<span class="ui-icon ui-icon-alert" style="display:inline-block;"></span>
							<span>비밀번호 10자리이상 2조합 or 8자리 이상 3조합으로 입력바랍니다.</span>
						</div>
					</td>
	        	</tr>
				<tr>
	        		<th>새 비밀번호 확인</th>
	        		<td>
						<input type="password" data-ng-model="form.member_pw_confirm" name="member_pw_confirm" class="normal w175" maxlength="16" ng-change="pw_confirm()"/>
						<div style="margin-top:5px;" ng-show="wFrm.member_pw_confirm.$dirty && wFrm.member_pw_confirm.$invalid">
							<span class="ui-icon ui-icon-alert" style="display:inline-block;"></span>
							<span style="color:#e86561;">입력하신 비밀번호와 다릅니다.</span>
						</div>
					</td>
	        	</tr>
	        	<tr>
	        		<th>전화번호 <b class="essential">*</b></th>
	        		<td>
						<select title="전화번호 앞자리 선택" class="normal" style="width:60px" data-ng-model="form.tel1" data-ng-options="item.code as item.code for item in main.tel1" data-ng-init="form.tel1=main.tel1[0].code">
	            		</select>
	            		<input type="text" class="normal w100" data-ng-model="form.tel2" maxlength="4" data-ng-pattern="/[0-9]{3,4}/"/> - <input type="text" class="normal w100" data-ng-model="form.tel3" maxlength="4" data-ng-pattern="/[0-9]{4}/"/>
					</td>         	
				</tr>
	        	<tr>
	        		<th>휴대폰</th>
	        		<td>
						<select title="휴대폰 앞자리 선택" class="normal" style="width:60px" data-ng-model="form.cell1" data-ng-options="item.code as item.code for item in main.cell1" data-ng-init="form.cell1=main.cell1[0].code">
	            		</select>
	            		<input type="text" class="normal w100" data-ng-model="form.cell2" maxlength="4" data-ng-pattern="/[0-9]{3,4}/"/> - <input type="text" class="normal w100" data-ng-model="form.cell3" maxlength="4" data-ng-pattern="/[0-9]{4}/"/>
					</td>         	
				</tr>
	        	<tr>
	        		<th>이메일 <b class="essential">*</b></th>
	        		<td>
	            		<input type="text" class="normal w100" data-ng-model="form.email1" required="required"/> @ <input type="text" class="normal w100" data-ng-model="form.email2" required="required"/>
						<select title="이메일선택" class="normal w100" data-ng-model="form.email2" data-ng-options="item.code_nm as item.code_nm for item in main.email2">
	          				<option value="">직접입력</option>
	            		</select>
					</td>         	
				</tr>
				<tr>
					<th>담당업무</th>
		       		<td>
						<textarea class="normal" data-ng-model="form.responsibilities"></textarea>
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
