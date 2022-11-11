<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="contents_wrap" style="background:#fff;">
	<div class="conwrap_tap">
		<ul>
		<li><a my-href="/intro"><span>대시보드</span></a></li>
		<li><a my-href="/day"><span>일자별 통계</span></a></li>
		<li><a my-href="/time"><span>시간별 통계</span></a></li>
		<li class="on"><a my-href="/page"><span>페이지 분석</span></a></li>
	   	</ul>
	</div>
	<div class="contents" data-ng-cloak>
   		<form name="searchFrm" method="post" data-ng-submit="board.go(1)">
    	<input type="submit" style="display:none;"/>
   		<table class="type1" style="margin-top:0;">
			<colgroup>
				<col style="width:200px;" />
				<col />
			</colgroup>
			<tr>
				<th scope="row">사이트선택</th>
				<td>
					<select title="사이트선택" class="normal w175" data-ng-model="param.site_id" data-ng-options="item.cms_menu_seq as item.title for item in main.site_list">
						<option value="">전체</option>
				    </select>
				</td>
			</tr>
			<tr>
				<th scope="row">일자</th>
				<td>
					<ol class="select" style="display:inline-block; float:left; padding:7px 0 6px 0;">
						<li class="first"><label><input type="radio" data-ng-model="param.date_duration" value="1"/> 1주일</label></li>
						<li><label><input type="radio" data-ng-model="param.date_duration" value="2"  /> 15일</label></li>
						<li><label><input type="radio" data-ng-model="param.date_duration" value="3" /> 전월</label></li>
						<li><label><input type="radio" data-ng-model="param.date_duration" value="4" /> 당월</label></li>
					</ol>
					<input type="text" class="normal w175" style="position:relative; z-index:100; margin-right:3px;" data-ng-model="param.start_dt" datetimepicker date_max_model="param.end_dt">
					<span>~</span> 
					<input type="text" class="normal w175" style="position:relative; z-index:100; margin-right:3px;" data-ng-model="param.end_dt" datetimepicker date_min_model="param.start_dt">
				</td>
			</tr>
			<tr>
				<th scope="row">검색어</th>
				<td>
					<select title="검색조건 선택" class="normal w100" data-ng-model="param.condition">
					  	<option value="title">타이틀</option>
					  	<option value="request_uri">URL</option>
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
		</form>
		
		<div style="overflow:hidden; margin-top:35px;">
	        <div class="left_box_cms"> 
	          	<span class="board_listing">TOTAL : <span><b>{{board.totalCount|number}}</b></span> 건 </span><span style="font-size:12px;">(<b>{{board.currentPage|number}}</b> / {{board.totalPage|number}} page)</span>
	        </div>
	        <div class="right_box_cms">
	          	<select title="건별보기 선택" class="normal w100" data-ng-model="param.rows" data-ng-init="param.rows='10'" data-ng-change="board.go(1)">
	            	<option value="10">10건씩보기</option>
	            	<option value="30">30건씩보기</option>
	            	<option value="50">50건씩보기</option>
	          	</select> 
	        </div>
        </div>
        
		<table class="type1">
			<colgroup>
				<col style="width:60px;" />
				<col />
				<col style="width:380px;" />
				<col style="width:120px;" />
				<col style="width:300px;" />
				<col style="width:120px;" />
			</colgroup>
			<tr>
				<th scope="col" class="center">번호</th>
				<th scope="col" class="center" data-ng-click="board.sort('title', $event)"><div class="arrow_box">타이틀<span class="up_arrow"></span><span class="down_arrow"></span></div></th>
				<th scope="col" class="center" data-ng-click="board.sort('request_uri', $event)"><div class="arrow_box">URL<span class="up_arrow"></span><span class="down_arrow"></span></div></th>
				<th scope="col" class="center" data-ng-click="board.sort('cnt', $event)"><div class="arrow_box">방문횟수<span class="up_arrow"></span><span class="down_arrow"></span></div></th>
				<th scope="col" class="center">비율</th>
				<th scope="col" class="center">페이지 이동</th>
			</tr>
			<tr data-ng-if="board.list.length==0">
				<td colspan="5" class="center">결과가 없습니다.</td>
			</tr>
			<tr data-ng-repeat="item in board.list">
				<td class="center">{{(board.totalCount|num) + 1 - (item.rn|num)}}</td>
				<td class="left member_nm pointcolor"><any ng-bind-html="item.title"></any>{{trustAsHtml(item.title)}}</td>
				<td class="left">{{item.request_uri}}</td>
				<td class="center">{{item.cnt}}</td>
				<td class="center"><span style="width:70%; display:block; float:left;"><span style="background-color:#4293e6; height: 20px; display: block;" ng-style="{width:item.per+'%'}"></span></span>{{item.per|number:2}}%</td>
				<td class="center"><button value="페이지이동" ng-click="openLink(item.request_uri)" class="bt_small move">페이지 이동</button></td>
			</tr>
		</table>
		<pagination total-page="board.totalPage" current-page="board.currentPage" on-select-page="board.go(page)"></pagination>
	</div>
</div>