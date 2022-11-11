<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<div ng-controller="moveMemberGroupCtrl" title="회원부서이동 관리">
		<form id="mgFrm" name="mgFrm" method="post" data-ng-submit="save()">
        <table class="type1">
        	<colgroup>
        		<col width="120">
        		<col width="">
        	</colgroup>
        	<tr>
        		<th>그룹</th>
        		<td>
					<select title="그룹 선택" class="normal w150" data-ng-model="form.group_seq" data-ng-options="item.group_seq|number as main.deptspace(item.level)+item.group_nm for item in main.dept" required="required">
            		</select>
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