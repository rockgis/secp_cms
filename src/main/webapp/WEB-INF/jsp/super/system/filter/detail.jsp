<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="contents_wrap">
	<div class="conwrap_tap">
		<ul>
			<li><a my-href="/dashboard"><span>대시보드</span></a></li>
			<li><a my-href="/daylist"><span>월별 검출내역</span></a></li>
			<li class="on"><a my-href="/menulist"><span>메뉴별 검출내역</span></a></li>
			<li><a my-href="/setting"><span>필터설정</span></a></li>
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
				<th scope="row">일자</th>
				<td>
					<ol class="select" style="display:inline-block; float:left; padding:7px 0 6px 0;">
						<li class="first"><label><input type="radio" data-ng-model="param.date_duration" value=""/> 전체</label></li>
						<li><label><input type="radio" data-ng-model="param.date_duration" value="1"/> 1주일</label></li>
						<li><label><input type="radio" data-ng-model="param.date_duration" value="2" /> 15일</label></li>
						<li><label><input type="radio" data-ng-model="param.date_duration" value="3" /> 전월</label></li>
						<li><label><input type="radio" data-ng-model="param.date_duration" value="4" /> 당월</label></li>
					</ol>
					<input type="text" class="normal w175" style="position:relative; z-index:100; margin-right:3px;" data-ng-model="param.start_dt" datetimepicker date_max_model="param.end_dt">
					<span>~</span> 
					<input type="text" class="normal w175" style="position:relative; z-index:100; margin-right:3px;" data-ng-model="param.end_dt" datetimepicker date_min_model="param.start_dt">
				</td>
			</tr>
			<tr>
				<th scope="row" colspan="2" style="text-align:center; padding-left:0px; padding-right:0px;"><a class="bt_big_bt5" data-ng-click="board.go(1)">검색</a></th>
			</tr>
		</table>
		</form>
		
		<div style="overflow:hidden; margin-top:35px;">
			<div class="right_box_cms">
			  	<div class="r_btn">
		    		<a style="display:inline-block; overflow:hidden; height:30px;" href="">
			    		<input type="button" value="" class="bt_big_bt1_2" data-ng-click="excel_export()"/>
			    		<input type="button" value="엑셀다운로드" class="bt_big_bt1" data-ng-click="excel_export()"/>
			    	</a>
		        </div>
		  	</div>
		</div>
		
		<table class="type1">
			<colgroup>
				<col style="width:60px;" />
			  	<col />
			  	<col style="width:130px;" />
			  	<col style="width:160px;" />
			  	<col style="width:160px;" />
			  	<col style="width:120px;" />
			  	<col style="width:120px;" />
			  	<col style="width:120px;" />
			  	<col style="width:120px;" />
			  	<col style="width:140px;" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col" class="center">번호</th>
					<th scope="col" class="center">게시물제목</th>
					<th scope="col" class="center">주민번호</th>
					<th scope="col" class="center">이메일</th>
					<th scope="col" class="center">카드번호</th>
					<th scope="col" class="center">사업자번호</th>
					<th scope="col" class="center">법인번호</th>
					<th scope="col" class="center">휴대전화번호</th>
					<th scope="col" class="center">일반전화번호</th>
					<th scope="col" class="center">등록일</th>
				</tr>
			</thead>
			<tbody id="listWrap">
				<tr data-ng-if="board.list.length==0">
					<td colspan="10" class="center">결과가 없습니다.</td>
				</tr>
				<tr data-ng-repeat="item in board.list">
					<td class="center">{{(board.totalCount|num) + 1 - (item.rn|num)}}</td>
					<td class="left member_nm">{{item.title}}</td>
					<td class="center">{{item.jumin_conts}}</td>
					<td class="center">{{item.email_conts}}</td>
					<td class="center">{{item.card_conts}}</td>
					<td class="center">{{item.busino_conts}}</td>
					<td class="center">{{item.bubino_conts}}</td>
					<td class="center">{{item.cell_conts}}</td>
					<td class="center">{{item.tel_conts}}</td>
					<td class="center">{{item.reg_dt|myDate:'yyyy-MM-dd HH:mm'}}</td>
				</tr>
			</tbody>
		</table>
		<pagination total-page="board.totalPage" current-page="board.currentPage" on-select-page="board.go(page)"></pagination>
		
		<div class="btn_bottom">
	    	<div class="r_btn">
	    		<input type="button" value="목록" class="bt_big_bt2" data-ng-click="list()"/>
	        </div>
	    </div>
	</div>
</div>