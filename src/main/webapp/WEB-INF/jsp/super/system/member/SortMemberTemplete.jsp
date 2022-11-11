<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<div ng-controller="SortMemberCtrl" title="정렬">
		<div style="overflow:hidden">
			<div class="nav nav_style_1" scrollable="scrollOption" style="float:left; position:relative; top:0; left:0; width:300px; height:auto; padding:15px 0">
			   <div class="dept_container sort" >
					<ul class="list treeview2">
						<li class="expandable">
							<span>그룹</span>
						</li>
					</ul>
			   </div>
			</div> 
			
			<table class="type1" style="float:right; width:300px; margin-top:0;">
			  <colgroup>
				<col width="20%">
				<col width="40%">
			  	<col width="*">
				</colgroup><thead>
					<tr>
						<th class="center">순번</th>
						<th class="center">직책</th>
						<th class="center">성명</th>
					</tr>
				</thead>
				<tbody ui-sortable="sortableOptions" ng-model="board.list">
					<tr data-ng-if="board.list.length==0"><td colspan="3" class="center">결과가 없습니다.</td></tr>
					<tr data-ng-repeat="item in board.list">
						<td class="center">{{item.order_seq}}</td>
						<td class="center">{{item.positions}}</td>
						<td class="center">{{item.member_nm}}</td>
					</tr>
				</tbody>
			</table>
		</div>
		<div class="btn_bottom">
			<div class="r_btn">
				<input type="button" value="저장" class="bt_big_bt4" data-ng-click="save()"/>
			</div>
		</div>
	</div>