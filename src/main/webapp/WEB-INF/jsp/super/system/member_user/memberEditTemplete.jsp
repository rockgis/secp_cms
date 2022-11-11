<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<div id="memberEditDiv" ng-controller="memberEditCtrl" title="회원 등록">
		<form id="memberFrm" name="memberFrm" method="post" data-ng-submit="save()">
        <table class="type1">
        	<colgroup>
        		<col width="120">
        		<col width="">
        	</colgroup>
        	<tr>
        		<th>그룹 <b class="essential">*</b></th>
        		<td>
					<select title="그룹 선택" class="normal w150" data-ng-model="form.group_seq" data-ng-options="item.group_seq as main.deptspace(item.level)+item.group_nm for item in main.dept" required="required">
            		</select>
				</td>
        	</tr>
			<tr>
        		<th>아이디 <b class="essential">*</b></th>
        		<td style="white-space:normal;" data-ng-if="model.mode=='ADD'"><input type="text" style="width:100%;" id="member_id" name="member_id" data-ng-model="form.member_id" class="normal" data-ng-minlength="4" autocomplete="off" required="required" idcheck/>
					<div style="margin-top:5px;" data-ng-show="memberFrm.member_id.$dirty && memberFrm.member_id.$error.idcheck"><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>
						사용하실수 없는 아이디 입니다. 다른아이디를 이용하여 주시기 바랍니다.
					</div>
				</td>
        		<td data-ng-if="model.mode=='MOD'">{{form.member_id}}</td>
        	</tr>
			<tr data-ng-if="model.mode=='ADD'">
        		<th>비밀번호 <b class="essential">*</b></th>
        		<td style="white-space:normal;">
					<input type="password" style="width:100%;" data-ng-model="form.member_pw" id="member_pw" name="member_pw" class="normal" maxlength="20" data-ng-minlength="6" data-ng-maxlength="20" autocomplete="off" data-ng-pattern="/^.*(?=.{6,20})(?=.*[0-9])(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9_]).*$/" required="required"/>
					<div style="margin-top:5px; " ng-show="memberFrm.member_pw.$dirty && memberFrm.member_pw.$invalid"><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 0px 0;"></span>
						6~20자의 영문 대소문자, 숫자, 특수문자를 조합하여 사용하실 수 있습니다.
					</div>
				</td>
        	</tr>
        	<tr data-ng-if="model.mode=='MOD'">
        		<th>비밀번호 <b class="essential">*</b></th>
        		<td>
					<button value="초기화" class="bt_small refresh" data-ng-click="init_pw(form)" onclick="return false;">초기화</button>
					<button value="변경" class="bt_small modify" style="margin-left:3px;" data-ng-click="modify_pw(form)" onclick="return false;">변경</button>
        		</td>
        	</tr>
        	<tr>
        		<th>이름 <b class="essential">*</b></th>
        		<td><input type="text" style="width:100%;" name="member_nm" data-ng-model="form.member_nm" class="normal" required="required"/></td>
        	</tr>	  
        	<tr>
        		<th>전화번호</th>
        		<td>
					<select title="전화번호 앞자리 선택" class="normal" style="width:60px" data-ng-model="form.tel1" data-ng-options="item.code as item.code for item in main.tel1" data-ng-init="form.tel1 != null && form.tel1 != '' ? form.tel1 : form.tel1=main.tel1[0].code">
            		</select> - 
            		<input type="text" class="normal w100" data-ng-model="form.tel2" maxlength="4" data-ng-pattern="/[0-9]{3,4}/" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"/> - 
            		<input type="text" class="normal w100" data-ng-model="form.tel3" maxlength="4" data-ng-pattern="/[0-9]{4}/" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"/>
				</td>         	
			</tr>
        	<tr>
        		<th>휴대폰 <b class="essential">*</b></th>
        		<td>
					<select title="휴대폰 앞자리 선택" class="normal" style="width:60px" data-ng-model="form.cell1" data-ng-options="item.code as item.code for item in main.cell1" data-ng-init="form.cell1 != null && form.cell1 != '' ? form.cell1 : form.cell1=main.cell1[0].code" required="required">
            		</select> - 
            		<input type="text" class="normal w100" data-ng-model="form.cell2" maxlength="4" data-ng-pattern="/[0-9]{3,4}/" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" required="required" /> - 
            		<input type="text" class="normal w100" data-ng-model="form.cell3" maxlength="4" data-ng-pattern="/[0-9]{4}/" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" required="required" />
            		
					<ol class="select" style="margin-top:8px;">
						<li><label><input type="radio" data-ng-model="form.sms_yn" value="Y"/>수신</label></li>
						<li><label><input type="radio" data-ng-model="form.sms_yn" value="N"/>미수신</label></li>
					</ol>
				</td>         	
			</tr>
        	<tr>
        		<th>이메일 <b class="essential">*</b></th>
        		<td>
            		<input type="text" class="normal w100" data-ng-model="form.email1" required="required" /> @ <input type="text" class="normal w100" data-ng-model="form.email2" required="required" />
					<select title="이메일선택" class="normal w100" data-ng-model="form.email2" data-ng-options="item.code_nm as item.code_nm for item in main.email2">
          				<option value="">직접입력</option>
            		</select>
            		
					<ol class="select" style="margin-top:8px;">
						<li><label><input type="radio" data-ng-model="form.email_yn" value="Y"/>수신</label></li>
						<li><label><input type="radio" data-ng-model="form.email_yn" value="N"/>미수신</label></li>
					</ol>
				</td>         	
			</tr>
			<tr data-ng-if="model.mode!='ADD'">
				<th>계정잠김</th>
				<td>
        			<span data-ng-if="form.block_yn == 'Y'">
						{{form.last_login|myDate:('yyyy-MM-dd HH:mm:ss')}}<br />
						<button value="잠금해제" class="bt_small lock" style="margin-left:5px;" data-ng-click="init_block(form)" onclick="return false;">잠금해제</button>
					</span>
				</td>
			</tr>
			<tr data-ng-if="model.mode!='ADD'">
				<th>최종접속/로그</th>
				<td>{{form.last_login|myDate:('yyyy-MM-dd HH:mm:ss')}} <button class="bt_small log" style="margin-left:5px;" value="로그보기" data-ng-click="memberHistory(form)" onclick="return false;">로그보기</button></td>
			</tr>
			<tr data-ng-if="model.mode!='ADD'">
				<th>가입일/탈퇴</th>
				<td>
					<p>가입 : {{form.reg_dt|myDate:('yyyy년 MM월 dd일 HH시 mm분 ss초')}}</p>
					<p ng-if="form.del_yn=='Y'">탈퇴 : {{form.del_dt|myDate:('yyyy년 MM월 dd일 HH시 mm분 ss초')}}</p>
				</td>
			</tr>
		</table>
		
		<div class="btn_bottom">
		  	<div class="r_btn">
				<input type="button" value="저장" class="bt_big_bt4" data-ng-click="save()"/>
				<input data-ng-if="model.mode!='ADD'" type="button" value="삭제" class="bt_big_bt3" data-ng-click=""/>
		  	</div>	
		</div>
		</form>
	</div>