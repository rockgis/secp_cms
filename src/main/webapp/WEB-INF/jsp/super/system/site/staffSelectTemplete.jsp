<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<div ng-controller="staffSelectCtrl" title="그룹선택">
		<div>
		
		<form name="searchFrm" method="post">
			<table class="type1" style="margin-top:13px;">
		    	<colgroup>
		    		<col width="25%" />
		    		<col width="*" />
		    	</colgroup>
		    	<caption>담당자 선택</caption>
		    	<tr>
					<th>검색구분</th>
					<td>
						<select title="검색구분" class="normal w150" data-ng-model="param.condition" data-ng-init="param.condition=''">
							<option value="">선택하세요</option>
		            		<option value="member_id">아이디</option>
							<option value="member_nm">이름</option>
		          		</select> 
					</td>
				</tr>
				<tr>
					<th>검색어</th>
					<td>
						<input type="text" class="normal w150" data-ng-model="param.keyword"/>
					</td>
				</tr>
				<tr>
					<th colspan="2" style="text-align:center; padding-left:0px; padding-right:0px;">
						<%-- <a data-ng-click="board.go(1)"><img src="<c:url value="/images/super/contents/s_btn_search.gif"/>" alt="검색" /></a> --%>
						<a class="bt_big_bt5" data-ng-click="board.go(1)">검색</a>
					</th>
				</tr>
		    </table>
		</form>
		<table class="type1" style="margin-top:13px;" id = "boardList">
		  	<colgroup>
				<col width="8%">
		  		<col width="20%">
		  		<col width="*">
		  		<col width="20%">
			</colgroup>
			<thead>
				<tr>
					<th class="center"></th>
					<th class="center">아이디</th>
					<th class="center">그룹</th>
					<th class="center">성명</th>
				</tr>
			</thead>
			<tbody>
				<tr data-ng-if="board.list.length==0"><td colspan="4" class="center">결과가 없습니다.</td></tr>
				<tr data-ng-repeat="item in board.list">
					<td class="center" style="padding:8px;"><input type="checkbox" data-ng-model="item.chk"  data-ng-change="clickMember(item)"/></td>
					<td class="left" style="padding:8px;">{{item.member_id}}</td>
					<td class="center" style="padding:8px;">{{item.group_nm}}</td>
					<td class="center" style="padding:8px;">{{item.member_nm}}</td>
				</tr>
			</tbody>
		</table>
		<pagination total-page="board.totalPage" current-page="board.currentPage" on-select-page="board.go(page)" style="margin-top: 10px;"></pagination>
		</div>

		<div class="btn_bottom">
			<div class="r_btn">
				<input type="button" value="선택인원 일괄 지정" class="bt_big_bt4" data-ng-click="selecterMember()"/>
				<input type="button" value="취소" class="bt_big_bt3" data-ng-click="cancel()"/>
			</div>
		</div>
	</div>