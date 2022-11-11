<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<div ng-controller="userSelectCtrl" title="메뉴 목록">
		<table class="type1">
			<colgroup>
				<col style="width:200px;" />
				<col />
			</colgroup>
			<tr>
				<th scope="row">회원구분</th>
				<td>
					<ol class="select">
						<li data-ng-repeat="item in group_list"><label><input type="checkbox" checklist-model="param.group_list" checklist-value="item.group_seq"/> {{item.group_nm}}</label></li>
					</ol>
				</td>
			</tr>
			<tr>
				<th scope="row">연회비납부</th>
				<td>
					<ol class="select">
						<li><label><input type="radio" data-ng-model="param.use_yn" value=""/> 전체</label></li>
						<li><label><input type="radio" data-ng-model="param.use_yn" value="N"/> 미납부</label></li>
						<li><label><input type="radio" data-ng-model="param.use_yn" value="Y"/> 납부완료</label></li>
					</ol>
				</td>
			</tr>
			<tr>
				<th scope="row">검색</th>
				<td>
					<select title="회원 검색조건 선택" class="normal w100" data-ng-model="param.condition" data-ng-init="param.condition='member_id'">
			            <option value="member_id">아이디</option>
			            <option value="member_nm">이름</option>
			        </select>
					<input type="text" class="normal w175" data-ng-model="param.keyword"/>
				</td>
			</tr>
			<tr>
				<th scope="row" colspan="2" style="text-align:center; padding-left:0px; padding-right:0px;"><a class="bt_big_bt5" data-ng-click="board.go(1)">검색</a></th>
			</tr>
		</table>
		
		<table id="board_div" class="type1">
			<colgroup>
				<col style="width:50px" />
				<col style="width:100px;" />
				<col style="width:100px;" />
				<col style="width:100px;" />
				<col />
			</colgroup>
			<thead>
				<tr>
					<th scope="col" class="center"><input type="checkbox" data-ng-model="board.chk_all" value="on" data-ng-change="chk_all_btn()"/></th>
					<th scope="col" class="center">회원구분</th>
					<th scope="col" class="center">아이디</th>
					<th scope="col" class="center">이름</th>
					<th scope="col" class="center">이메일</th>
				</tr>
			</thead>
			<tbody id="listWrap">
				<tr data-ng-if="board.list.length==0"><td colspan="5" class="center">결과가 없습니다.</td></tr>
				<tr data-ng-repeat="item in board.list">
					<td class="center"><input type="checkbox" value="{{item.member_id}}" data-ng-model="item.chk_yn"/></td>
					<td class="center">{{item.group_nm}}</td>
					<td class="center">{{item.member_id}}</td>
					<td class="center">{{item.member_nm}}</td>
					<td class="center">{{item.email}}</td>
				</tr>
			</tbody>
		</table>
		
		<div class="btn_bottom">
			<div class="r_btn">
				<input type="button" value="선택" class="bt_big_bt4" data-ng-click="select()"/>
				<input type="button" value="닫기" class="bt_big_bt2" data-ng-click="close()"/>
			</div>
		</div>
	</div>