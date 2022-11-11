<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
		<div class="contents" data-ng-init="board.go(1)" data-ng-cloak>
			<form name="searchFrm" method="post" data-ng-submit="board.go(1)">
	     	<table class="type1" style="margin-top:0;">
				<colgroup>
					<col style="width:200px;" />
					<col />
				</colgroup>
				<tr>
					<th scope="row">일자</th>
					<td>
						<input type="text" class="normal w175" style="position:relative; z-index:100; margin-right:3px;" data-ng-model="param.start_dt" datetimepicker date_max_model="param.end_dt">
						<span>~</span> 
						<input type="text" class="normal w175" style="position:relative; z-index:100; margin-right:3px;" data-ng-model="param.end_dt" datetimepicker date_min_model="param.start_dt">
					</td>
				</tr>
				<tr>
					<th scope="row">검색어</th>
					<td>
						<select title="회원 검색조건 선택" class="normal w100" data-ng-model="param.condition" data-ng-init="param.condition='ip'">
				        	<option value="ip">IP</option>
				            <option value="title">사용처</option>
				        </select> 
						<input type="text" class="normal w175" data-ng-model="param.keyword"/>
					</td>
				</tr>
				<tr>
					<th scope="row" colspan="2" style="text-align:center; padding-left:0px; padding-right:0px;">
						<%-- <a data-ng-click="board.go(1)"><img src="<c:url value="/images/super/contents/s_btn_search.gif"/>" alt="검색" /></a> --%>
						<a class="bt_big_bt5" data-ng-click="board.go(1)">검색</a>
					</th>
				</tr>
			</table>
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
		    </form>
		    
			<table class="type1">
	          	<colgroup>
	          		<col style="width:60px;" />
	          		<col style="width:150px;" />
		          	<col />
		          	<col style="width:110px;" />
		          	<col style="width:110px;" />
		          	<col style="width:200px;" />
	          	</colgroup>
	          	<tr>
		            <th scope="col" class="center">번호</th>
		            <th scope="col" class="center">IP</th>
		            <th scope="col" class="center">사용처</th>
		            <th scope="col" class="center">등록자</th>
		            <th scope="col" class="center">등록일자</th>
		            <th scope="col" class="center">관리</th>
	          	</tr>
	          	<tr data-ng-if="board.list.length==0"><td colspan="6" class="center">결과가 없습니다.</td></tr>
	          	<tr data-ng-repeat="item in board.list">
	          		<td class="center">{{(board.totalCount|num) + 1 - (item.rn|num)}}</td>
		            <td class="center member_nm">{{item.ip}}</td>
		            <td class="left">{{item.title}}</td>
		            <td class="center">{{item.reg_nm}}</td>
		            <td class="center">{{item.reg_dt|myDate:'yyyy-MM-dd'}}</td>
		            <td class="center">
		            	<button value="수정" class="bt_small modify" data-my-href="/modify/{{item.seq}}">수정</button>
		            	<button value="삭제" class="bt_small delete" data-ng-click="del(item)">삭제</button>
		            </td>
	          	</tr>
	        </table>
	        
	        <pagination total-page="board.totalPage" current-page="board.currentPage" on-select-page="board.go(page)"></pagination>
			
			<div class="btn_bottom">
		    	<div class="r_btn">
					<input type="button" value="등록" class="bt_big_bt4" data-my-href="/write"/>
		        </div>
		    </div>
		</div>
