<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<div ng-controller="groupEditCtrl" title="그룹추가">
		<form id="groupFrm" name="groupFrm" method="post" novalidate="novalidate" data-ng-submit="save()">
		<table class="type1">
		<colgroup>
		    <col width="20%" />
		    <col width="*" />
		</colgroup>
		<tr>
			<th>그룹명</th>
			<td><input type="text" class="normal" style="width:100%;" data-ng-model="form.group_nm" required="required"/></td>
		</tr>
		<tr>
			<th>대표전화</th>
       		<td>
				<select title="전화번호 앞자리 선택" class="normal" style="width:60px;" data-ng-model="form.tel1" data-ng-options="item.code as item.code for item in main.tel1" data-ng-init="form.tel1=main.tel1[0].code">
           		</select> - 
           		<input type="text" class="normal w100" data-ng-model="form.tel2" maxlength="4" data-ng-pattern="/[0-9]{3,4}/"/> - <input type="text" class="normal w100" data-ng-model="form.tel3" maxlength="4" data-ng-pattern="/[0-9]{4}/"/>
			</td>
		</tr>
		<tr>
			<th>FAX</th>
       		<td>
				<select title="전화번호 앞자리 선택" class="normal" style="width:60px;" data-ng-model="form.fax1" data-ng-options="item.code as item.code for item in main.tel1" data-ng-init="form.fax1=main.tel1[0].code">
           		</select> - 
           		<input type="text" class="normal w100" data-ng-model="form.fax2" maxlength="4" data-ng-pattern="/[0-9]{3,4}/"/> - <input type="text" class="normal w100" data-ng-model="form.fax3" maxlength="4" data-ng-pattern="/[0-9]{4}/"/>
			</td>
		</tr>
		<tr>
			<th>담당업무</th>
       		<td>
				<textarea style="width:100%; height:50px; box-sizing:border-box;" data-ng-model="form.responsibilities"></textarea>
			</td>
		</tr>
		<tr data-ng-if="model.mode=='MOD'">
			<th>담당그룹설정</th>
       		<td>
       			<button value="권한설정" class="bt_small page2" data-ng-click="groupStaff()" onclick="return false;">권한설정</button>
				<div class="layout_g1" ng-show="form.staff_list.length>0">
				    <span ui-sortable="staffSortable" data-ng-model="form.staff_list">
						<span data-ng-repeat="item in form.staff_list">{{item.title}}</span>
					</span>
				</div>
			</td>
		</tr>
		<tr>
			<th>사용여부</th>
			<td>
				<ol class="select">
					<li><label><input type="radio" data-ng-model="form.use_yn" value="Y"/>사용</label></li>
					<li><label><input type="radio" data-ng-model="form.use_yn" value="N"/>사용안함</label></li>
				</ol>
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