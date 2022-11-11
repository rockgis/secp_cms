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
						<select data-ng-model="param.date_type" class="normal w175" style="margin-right:5px;" ng-init="param.date_type='1'">
			            	<option value="1">업데이트예정일</option>
			            	<option value="2">등록일</option>
			          	</select> 
						<input type="text" class="normal w175" style="position:relative; z-index:100; margin-right:3px;" data-ng-model="param.start_dt" datetimepicker date_max_model="param.end_dt">
						<span>~</span> 
						<input type="text" class="normal w175" style="position:relative; z-index:100; margin-right:3px;" data-ng-model="param.end_dt" datetimepicker date_min_model="param.start_dt">
					</td>
				</tr>
				<tr>
					<th scope="row">상태</th>
					<td>
						<ol class="select">
							<li class="first"><label><input type="radio" data-ng-model="param.status" value=""/> 전체</label></li>
							<li><label><input type="radio" data-ng-model="param.status" value="S" /> 성공</label></li>
							<li><label><input type="radio" data-ng-model="param.status" value="F" /> 실패</label></li>
							<li><label><input type="radio" data-ng-model="param.status" value="C" /> 취소</label></li>
							<li><label><input type="radio" data-ng-model="param.status" value="W" /> 대기</label></li>
						</ol>
					</td>
				</tr>
				<tr>
					<th scope="row">검색어</th>
					<td>
						<select title="검색조건 선택" class="normal w100" data-ng-model="param.condition" data-ng-init="param.condition='title'">
			            	<option value="title">메뉴명</option>
			            	<option value="reg_nm">등록자</option>
			          	</select> 
						<input type="text" class="normal w175" data-ng-model="param.keyword"/>
					</td>
				</tr>
				<tr>
					<th colspan="2" style="text-align:center; padding-left:0px; padding-right:0px;">
						<a class="bt_big_bt5" data-ng-click="board.go(1)">검색</a>
					</th>
				</tr>
			</table>
		
			<div style="margin-top:35px;">
				<span class="bt_all">
					<span data-ng-class="{active : param.gubun == null || param.gubun == ''}"><input type="button" style="padding:8px 30px;" value="전체" data-ng-click="param.gubun='';board.go(1);"/></span>
					<span data-ng-class="{active : param.gubun == 'M'}"><input type="button" style="padding:8px 30px;" value="페이지" data-ng-click="param.gubun='M';board.go(1);"/></span>
					<span data-ng-class="{active : param.gubun == 'B'}"><input type="button" style="padding:8px 30px;" value="게시물" data-ng-click="param.gubun='B';board.go(1);"/></span>
				</span>
		    </div>
		    
			<div style="overflow:hidden;">
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
		          	<col style="width:60px;">
		          	<col style="width:150px;">
		          	<col style="width:110px;">
		          	<col>
		          	<col style="width:150px;">
		          	<col style="width:130px;">
		          	<col style="width:110px;">
		          	<col style="width:90px;">
		          	<col style="width:130px;">
		          	<col style="width:110px;">
		        </colgroup>
		        <tr>
		            <th scope="col" class="center">번호</th>
		            <th scope="col" class="center">사이트구분</th>
		            <th scope="col" class="center">페이지구분</th>
		            <th scope="col" class="center">메뉴명</th>
		            <th scope="col" class="center">등록자</th>
		            <th scope="col" class="center">예약일</th>
		            <th scope="col" class="center">등록일</th>
		            <th scope="col" class="center">상태</th>
		            <th scope="col" class="center">비고</th>
		            <th scope="col" class="center">삭제</th>
		        </tr>
	          	<tr data-ng-if="board.list.length==0"><td colspan="10" class="center">결과가 없습니다.</td></tr>
	          	<tr data-ng-repeat="item in board.list">
	          		<td class="center">{{(board.totalCount|num) + 1 - (item.rn|num)}}</td>
	          		<td class="center">{{item.title.split(">")[0]}}</td><!-- 사이트가 여려개일 경우 해당 사이트 리스트만 보이며 해당 td비노출 -->
	          		<td class="center">{{item.gubun=='M'?'페이지':'게시물'}}</td>
		            <td class="left member_nm">{{item.title}}</td>
		            <td class="center">{{item.reg_nm}}({{item.reg_id}})</td>
		            <td class="center">{{item.reserve_dt|myDate:'yyyy-MM-dd HH:mm'}}</td>
		            <td class="center">{{item.reg_dt|myDate:'yyyy-MM-dd'}}</td>
		            <td class="center rsv_status_{{item.status}}">{{item.result}}</td>
		            <td class="center">
		            	<button class="bt_small move" value="페이지 바로가기" ng-click="blankUrl(item.menu_url)">페이지 바로가기</button>
		            </td>
		            <td class="center">
	            		<button value="삭제" class="bt_small delete" data-ng-click="del(item)">삭제</button>
	            	</td>
	          	</tr>
	        </table>
	        
	        <pagination total-page="board.totalPage" current-page="board.currentPage" on-select-page="board.go(page)"></pagination>
			
		</div>
