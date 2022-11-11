<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div style="padding:20px; background:#fff;">
	<div class="conwrap_tap">
		<ul>
			<li><a my-href="/dashboard"><span>대시보드</span></a></li>
			<li><a my-href="/daylist"><span>월별 검출내역</span></a></li>
			<li><a my-href="/menulist"><span>메뉴별 검출내역</span></a></li>
			<li class="on"><a my-href="/setting"><span>필터설정</span></a></li>
	   	</ul>
	</div>
	<div class="contents" data-ng-cloak>
		<form name="searchFrm" method="post" data-ng-submit="board.go(1)">
		<table class="type1" style="margin-top:0;">
			<colgroup>
				<col style="width:200px;" />
				<col />
			</colgroup>
			<tr>
				<th scope="row">사이트선택</th>
				<td>
					<select title="사이트선택" class="normal w175" data-ng-model="param.site_id" data-ng-options="item.cms_menu_seq as item.title for item in main.site_list">
          			</select>
				</td>
			<tr>
				<th scope="row">필터설정</th>
				<td>
					<ol class="select">
						<li class="first"><label><input type="radio" ng-model="param.filter_yn" value=""> 전체</label></li>
						<li><label><input type="radio" ng-model="param.filter_yn" value="Y"> 기본필터 사용</label></li>
						<li><label><input type="radio" ng-model="param.filter_yn" value="N"> 개별필터 사용</label></li>
					</ol>
				</td>
			</tr>			
			<tr>
				<th scope="row">메뉴명</th>
				<td>
					<!-- 
					<select class="normal w100" data-ng-model="param.condition">
						<option value="">전체</option>
						<option value="bbs">게시판</option>
						<option value="program">프로그램</option>
					</select>
					 -->
					<input type="text" class="normal w175" data-ng-model="param.keyword" />
				</td>
			</tr>
			<tr>
				<th scope="row" colspan="2" style="text-align:center; padding-left:0px; padding-right:0px;">
					<a class="bt_big_bt5" data-ng-click="board.go(1)">검색</a>
				</th>
			</tr>
		</table>
		</form>
		
		<div style="margin-top:15px;">
			<span class="bt_all">
				<span data-ng-class="{active : param.menu_type == '1'}"><input type="button" style="padding:8px 30px;" value="전체" data-ng-click="param.menu_type='1';board.go(1);"/></span>
				<span data-ng-class="{active : param.menu_type == '2'}"><input type="button" style="padding:8px 30px;" value="게시판" data-ng-click="param.menu_type='2';board.go(1);"/></span>
				<span data-ng-class="{active : param.menu_type == '3'}"><input type="button" style="padding:8px 30px;" value="프로그램" data-ng-click="param.menu_type='3';board.go(1);"/></span>
			</span>
	    </div>
	    
		<div style="overflow:hidden;">
			<div class="left_box_cms">
	        	<span class="board_listing">TOTAL : <span><b>{{board.totalCount|number}}</b></span> 건 </span><span style="font-size:12px;">(<b>{{board.currentPage|number}}</b> / {{board.totalPage|number}} page)</span>
	        </div>
			<div class="right_box_cms">
	          	<select class="normal w100" title="건별보기 선택" data-ng-model="param.rows" data-ng-init="param.rows='10'" data-ng-change="board.go(1)">
	            	<option value="10">10건씩보기</option>
	            	<option value="15">15건씩보기</option>
	            	<option value="20">20건씩보기</option>
	          	</select>
	        </div>
		</div>
		<form name="selectForm" onsubmit="return _select(this);">
		<table class="type1">
			<colgroup>
				<col style="width:60px;" />
			  	<col />
			  	<col style="width:400px;" />
			  	<col style="width:110px;" />
			  	<col style="width:110px;" />
			</colgroup>
			<thead>
				<tr>
					<th class="center">번호</th>
					<th class="center">메뉴명</th>
					<th class="center">사용필터</th>
					<th class="center">기본필터 사용</th>
					<th class="center">개별필터 설정</th>
				</tr>
			</thead>
			<tbody id="listWrap">
				<tr data-ng-if="board.list.length==0"><td colspan="5" class="center">결과가 없습니다.</td></tr>
				<tr data-ng-repeat="item in board.list">
					<td class="center">{{(board.totalCount|num) + 1 - (item.rn|num)}}</td>
					<td class="member_nm left">{{item.page_navi}}</td>
					<td class="center">
						<div class="filter_list">
							<span data-ng-if="item.jumin_yn=='Y'">주민번호</span> 
							<span data-ng-if="item.email_yn=='Y'">이메일</span>
							<span data-ng-if="item.card_yn=='Y'">카드번호</span>
							<span data-ng-if="item.busino_yn=='Y'">사업자번호</span>
							<span data-ng-if="item.bubino_yn=='Y'">법인번호</span>
							<span data-ng-if="item.tel_yn=='Y'">일반전화번호</span>
							<span data-ng-if="item.cell_yn=='Y'">휴대전화</span>
						</div>
					</td>
					<td class="center" data-ng-class="{checked: item.filter_status}" data-ng-click="setMenuFilter(item)" ios-switch></td>
					<td class="center">
						<button data-ng-show="!item.filter_status" data-ng-click="eachPersonalFilter(item);" value="개별설정" class="bt_small modify">변경</button>
					</td>
				</tr>
			</tbody>
		</table>
		<pagination total-page="board.totalPage" current-page="board.currentPage" on-select-page="board.go(page)"></pagination>
		</form>
		
		<h4 style="margin-top:35px;">기본필터 설정</h4>
		<table class="type1">
			<colgroup>
				<col style="width:200px;" />
				<col />
			</colgroup>
			<tr>
				<th scope="row">필터 설정</th>
				<td style="overflow:hidden;">
					<ol class="select" style="float:left; margin-top:2px;">
						<li class="first"><label><input type="checkbox" data-ng-model="form.jumin_yn" ng-true-value="'Y'" ng-false-value="'N'"/> 주민번호</label></li>
						<li><label><input type="checkbox" data-ng-model="form.email_yn" ng-true-value="'Y'" ng-false-value="'N'"/> 이메일</label></li>
						<li><label><input type="checkbox" data-ng-model="form.card_yn" ng-true-value="'Y'" ng-false-value="'N'"/> 카드번호</label></li>
						<li><label><input type="checkbox" data-ng-model="form.busino_yn" ng-true-value="'Y'" ng-false-value="'N'"/> 사업자번호</label></li>
						<li><label><input type="checkbox" data-ng-model="form.bubino_yn" ng-true-value="'Y'" ng-false-value="'N'"/> 법인번호</label></li>
						<li><label><input type="checkbox" data-ng-model="form.tel_yn" ng-true-value="'Y'" ng-false-value="'N'"/> 전화번호</label></li>
						<li><label><input type="checkbox" data-ng-model="form.cell_yn" ng-true-value="'Y'" ng-false-value="'N'"/> 휴대전화</label></li>
					</ol>
					<input type="button" data-ng-click="setDefaultFilter();" value="적용" class="btalls" style="float:left;" />
				</td>
			</tr>
			<tr>
				<th scope="row">비속어필터 설정</th>
				<td>
					<textarea style="width:50%; height:60px;" data-ng-model="form.forbidden_word"></textarea>
				</td>
			</tr>
		</table>

	</div>
</div>
