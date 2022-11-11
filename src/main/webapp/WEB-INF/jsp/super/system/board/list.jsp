<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	<div class="titlebar" data-ng-cloak>
		<h2>게시판 설정 및 관리</h2>
		<div>
			<span>시스템 관리</span>&gt; <span>시스템 설정 및 관리</span>&gt;
			<span class="bar_tx">게시판 설정 및 관리</span>
		</div>
	</div>
	<div class="contents_wrap" data-ng-init="board.go(1)" data-ng-cloak>
		<div class="contents">
			<form name="searchFrm" method="post" data-ng-submit="board.go(1)">
	        <input type="submit" style="display:none;"/>
			<table class="type1" style="margin-top:0;">
				<colgroup>
					<col style="width:200px;" />
					<col />
				</colgroup>
				<tr>
					<th scope="row">사용여부</th>
					<td>
						<ol class="select" style="padding:7px 0 6px 0;">
							<li class="first"><label><input type="radio" data-ng-model="param.use_yn" value=""> 전체</label></li>
							<li><label><input type="radio" data-ng-model="param.use_yn" value="Y"> 사용</label></li>
							<li><label><input type="radio" data-ng-model="param.use_yn" value="N"> 미사용</label></li>
						</ol>
					</td>
				</tr>
				<tr>
					<th scope="row">게시판타입</th>
					<td>
	            		<ol class="select">
			        		<li><label><input type="radio" data-ng-model="param.board_type" ng-value="" /> 전체</label></li>
			        		<li data-ng-repeat="item in boardType"><label><input type="radio" data-ng-model="param.board_type" ng-value="item.board_type" /> {{item.name}}</label></li>
			        	</ol>
					</td>
				</tr>
				<tr>
					<th scope="row">생성일</th>
					<td>
						<ol class="select" >
							<li><label><input type="radio" data-ng-model="param.date_select" value="N" data-ng-init="param.date_select = 'N'" /> 전체</label></li>
							<li><label><input type="radio" data-ng-model="param.date_select" value="Y" /> 기간선택</label></li>
						</ol>
						<div data-ng-if="param.date_select=='Y'" style="margin-top:4px;">
							<input type="text" class="normal w175" style="position:relative; z-index:100; margin-right:3px;" data-ng-model="param.start_dt" datetimepicker date_max_model="param.end_dt">
							<span>~</span> 
							<input type="text" class="normal w175" style="position:relative; z-index:100; margin-right:3px;" data-ng-model="param.end_dt" datetimepicker date_min_model="param.start_dt">
						</div>
					</td>
				</tr>
				<tr>
					<th scope="row">게시판명</th>
					<td>
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
			</form>
			
			<div style="overflow:hidden; margin-top:35px;">
		        <div class="left_box_cms">
		        	<span class="board_listing">TOTAL : <span><b>{{board.totalCount|number}}</b></span> 건 </span><span style="font-size:12px;">(<b>{{board.currentPage|number}}</b> / {{board.totalPage|number}} page)</span>
		        </div>
		        <div class="right_box_cms">
		          	<select class="normal w100" title="건별보기 선택" data-ng-model="param.rows" data-ng-init="param.rows='10'" data-ng-change="board.go(1)">
		            	<option value="10">10건씩보기</option>
		            	<option value="20">20건씩보기</option>
		            	<option value="50">50건씩보기</option>
		          	</select>
		        </div>
		    </div>
		    
			<!-- <form name="selectForm" onsubmit="return _select(this);"> -->
			<table class="type1" style="margin-top:10px;">
				<colgroup>
					<col style="width:60px;" />
				  	<col />
				  	<col style="width:120px;" />
				  	<col style="width:80px;" />
				  	<col style="width:110px;" />
				  	<col style="width:95px;" />
				  	<col style="width:120px;" />
				  	<col style="width:95px;" />
				  	<col style="width:95px;" />
				  	<col style="width:110px;" />
				  	<col style="width:200px;" />
				</colgroup>
				<thead>
					<tr>
						<th class="center">번호</th>
						<th class="center">게시판명</th>
						<th class="center">게시판타입</th>
						<th class="center">게시판번호</th>
	            		<th class="center">연결</th>
						<th class="center">에디터 사용</th>
						<th class="center">저작권보호 사용</th>
						<th class="center">해시태그 사용</th>
						<th class="center">사용여부</th>
						<th class="center">생성일</th>
						<th class="center">관리</th>
					</tr>
				</thead>
				<tbody id="listWrap">
					<tr data-ng-if="board.list.length==0"><td colspan="11" class="center">결과가 없습니다.</td></tr>
					<tr data-ng-repeat="item in board.list">
						<td class="center">{{(board.totalCount|num) + 1 - (item.rn|num)}}</td>
						<td class="member_nm left">{{item.board_nm}}</td>
						<td class="center" data-ng-repeat="types in boardType" data-ng-if="types.board_type == item.board_type">{{types.name}}({{types.board_type}})</td>
						<td class="center">{{item.board_seq}}</td> 
	            		<td class="center underline member_nm pointcolor"><a data-ng-click="openLinkList(item)">연결중({{item.user_page_cnt}})</a></td>
						<td class="center">{{item.editor_yn}}</td>
						<td class="center">{{item.cclnuri_yn}}</td>
						<td class="center">{{item.tag_yn}}</td>
						<td class="center">{{item.use_yn}}</td>
						<td class="center">{{item.reg_dt}}</td>
						<td class="center">
							<button data-my-href="/modify/{{item.board_seq}}" value="수정" class="bt_small modify">수정</button>
							<button data-ng-click="boardDel(item);" value="삭제" class="bt_small delete">삭제</button>
						</td>
					</tr>
				</tbody>
			</table>
			<pagination total-page="board.totalPage" current-page="board.currentPage" on-select-page="board.go(page)"></pagination>
			<div class="btn_bottom">
		      	<div class="r_btn">
			      	<input type="button" value="생성" class="bt_big_bt4" data-my-href="/write" />
			      	<input type="button" value="타입관리" class="bt_big_bt2" data-ng-click="boardCreate()" />
		      	</div>
		    </div>
			<!-- </form> -->
		</div>
	</div>