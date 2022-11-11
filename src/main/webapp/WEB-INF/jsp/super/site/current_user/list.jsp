<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<div class="contents" data-ng-cloak>
		<form name="searchFrm" method="post" data-ng-submit="board.go(1)">
			<table class="type1" style="margin-top:0;">
				<colgroup>
					<col style="width:200px;" />
					<col />
				</colgroup>
				<tr>
					<th scope="row">검색어</th>
					<td>
						<select title="검색조건 선택" class="normal w100" data-ng-model="param.condition" data-ng-init="param.condition='member_nm'">
			            	<option value="member_nm">이름</option>
			            	<option value="member_id">아이디</option>
			          	</select>
						<input type="text" class="normal w175" data-ng-model="param.keyword"/>
					</td>
				</tr>
				<tr>
					<th scope="row" colspan="2" style="text-align:center; padding-left:0px; padding-right:0px;">
						<a class="bt_big_bt5" data-ng-click="board.go(1)">검색</a>
					</th>
				</tr>
			</table>
			<div style="margin-top:35px;">
				<span class="bt_all">
					<span data-ng-class="{active : param.gubun == null || param.gubun == ''}"><input type="button" style="padding:8px 30px;" value="전체" data-ng-click="param.gubun='';board.go(1);"/></span>
					<span data-ng-class="{active : param.gubun == 'admin'}"><input type="button" style="padding:8px 30px;" value="관리자" data-ng-click="param.gubun='admin';board.go(1);"/></span>
					<span data-ng-class="{active : param.gubun == 'user'}"><input type="button" style="padding:8px 30px;" value="사용자" data-ng-click="param.gubun='user';board.go(1);"/></span>
				</span>
		    </div>
		</form>
		
		<div style="overflow:hidden; margin-top:35px;">
	        <div class="left_box_cms"> 
	          	<span class="board_listing">TOTAL : <span><b>{{board.totalCount|number}}</b></span> 건 </span><span style="font-size:12px;">(<b>{{board.currentPage|number}}</b> / {{board.totalPage|number}} page)</span>
	        </div>
	        <div class="right_box_cms">
				<select class="normal w100" data-ng-model="param.rows" data-ng-init="param.rows='10'" data-ng-change="board.go(1)">
		            <option value="10">10건씩보기</option>
		            <option value="20">20건씩보기</option>
		            <option value="30">30건씩보기</option>
		            <option value="50">50건씩보기</option>
		            <option value="100">100건씩보기</option>
	          	</select>
	        </div>
		</div>
		<table class="type1">
	    	<colgroup>
	          	<col style="width:60px;" />
	          	<col style="width:100px;" />
	          	<col style="width:150px;" />
	          	<col style="width:150px;" />
	          	<col />
	          	<col style="width:150px;" />
	        </colgroup>
	        <tr>
	            <th scope="col" class="center">번호</th>
	            <th scope="col" class="center">구분</th>
	            <th scope="col" class="center">아이디</th>
	            <th scope="col" class="center">이름</th>
	            <th scope="col" class="center">마지막페이지 이동시간</th>
	            <th scope="col" class="center">로그아웃</th>
	        </tr>
	        <tr data-ng-if="board.list.length==0">
	        	<td colspan="6" class="center">결과가 없습니다.</td>
	        </tr>
	        <tr data-ng-repeat="item in board.list">
	        	<td class="center">{{(board.totalCount|num) + 1 - (item.rn|num)}}</td>
	            <td class="center">{{item.gubun=='admin' ? '관리자' : '사용자'}}</td>
	            <td class="center member_nm pointcolor">{{item.member_id}}</td>
	            <td class="center">{{item.member_nm}}</td>
	            <td class="center">{{item.lastrequest|myDate:'yy년 MM월 dd일 HH시 mm분 ss초'}}</td>
	            <td class="center">
	            	<button class="bt_small logout" value="강제 로그아웃" data-ng-click="force_logout(item)">강제 로그아웃</button>
	            </td>
	        </tr>
	    </table>
	    <pagination total-page="board.totalPage" current-page="board.currentPage" on-select-page="board.go(page)"></pagination>
	
	</div>
