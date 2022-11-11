<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<div ng-controller="memberHistoryCtrl" title="로그보기">
		<p style="margin-top:17px; font-size:15px; font-family:'NanumBarunGothicB';">계정명 : {{param.member_nm}}({{param.member_id}})</p>
        <table class="type1">
        	<colgroup>
        		<col width="8%">
        		<col width="16%">
        		<col width="16%">
        		<col width="12%">
        		<col width="12%">
        		<col width="*">
        	</colgroup>
        	<thead>
	        	<tr>
	        		<th class="center">순번</th>
	        		<th class="center">일시</th>
	        		<th class="center">접속IP</th>
	        		<th class="center">아이디</th>
	        		<th class="center">이름</th>
	        		<th class="center">내용</th>
	        	</tr>
	        </thead>
        	<tbody id="listWrap">
				<tr data-ng-if="board.list.length==0"><td colspan="6" class="center">결과가 없습니다.</td></tr>
	        	<tr data-ng-repeat="item in board.list">
					<td class="center">{{(board.totalCount|num) + 1 - (item.rn|num)}}</td>
					<td class="center">{{item.mod_dt|myDate:('yyyy/MM/dd HH:mm')}}</td>
					<td class="center">{{item.mod_ip}}</td>
					<td class="center">{{item.mod_id}}</td>
					<td class="center">{{item.mod_nm}}</td>
					<td ng-bind-html="item.conts"></td>
	        	</tr>
	        </tbody>
		</table>
		<pagination total-page="board.totalPage" current-page="board.currentPage" on-select-page="board.go(page)"></pagination>
		
		<div class="btn_bottom">
		  	<div class="r_btn">
				<input type="button" value="닫기" class="bt_big_bt4" data-ng-click="cancel()"/>
		  	</div>	
		</div>
	</div>