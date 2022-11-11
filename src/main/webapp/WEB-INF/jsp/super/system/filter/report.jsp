<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div style="padding:20px; background:#fff;">
	<div class="conwrap_tap">
		<ul>
			<li><a my-href="/setting"><span>필터설정</span></a></li>
			<li class="on"><a my-href="/report"><span>보고서</span></a></li>
	   	</ul>
	</div>
	<div class="contents" data-ng-cloak>
		
		<table class="type1" style="margin-top:0;">
			<colgroup>
				<col width="200px" />
				<col width="*" />
			</colgroup>
			<tr>
				<th>일자검색</th>
				<td>
					<ol class="select" style="display:inline-block; float:left; padding:7px 0 6px 0;">
						<li class="first"><label><input type="radio" data-ng-model="param.date_duration" value="1"/> 1주일</label></li>
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
				<th colspan="2" style="text-align:center; padding-left:0px; padding-right:0px;"><a class="bt_big_bt5" data-ng-click="board.go(1)">검색</a></th>
			</tr>
		</table>
		
		<table class="statistics" style="margin-top:35px;">
		    <colgroup>
		    	<col width="70%">
		    	<col width="30%">
		    </colgroup>		
		    <tbody>
				<tr data-ng-if="board.list.length != 0">
		        	<td><canvas id="line" class="chart chart-bar" chart-data="chartData1.data" chart-labels="chartData1.labels" chart-series="chartData1.series" chart-legend="true" height="80"></canvas></td>
					<td><canvas id="pie" class="chart chart-pie" chart-data="chartData2.data" chart-labels="chartData2.labels" chart-series="chartData2.series" chart-legend="true" height="200"></canvas></td> 		        	
				</tr>
	    	</tbody>
		</table>
		
		<div style="overflow:hidden; margin-top:35px;">
	    	<div class="left_box_cms">
	    		<span class="board_listing">TOTAL : <span><b>{{board.totalCount|number}}</b></span> 건 </span><span style="font-size:12px;">({{board.currentPage|number}} / {{board.totalPage|number}} page)</span>
	        </div>
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
				<col width="6%" />
			  	<col width="*" />
			  	<col width="8%" />
			  	<col width="8%" />
			  	<col width="8%" />
			  	<col width="8%" />
			  	<col width="8%" />
			  	<col width="8%" />
			  	<col width="8%" />
			  	<col width="8%" />
			  	<col width="8%" />
			</colgroup>  
		 
			<thead>
				<tr>
					<th class="center">번호</th>
					<th class="center">메뉴명</th>
					<th class="center">전체</th>
					<th class="center">주민번호</th>
					<th class="center">이메일</th>
					<th class="center">카드번호</th>
					<th class="center">사업자번호</th>
					<th class="center">법인번호</th>
					<th class="center">휴대전화번호</th>
					<th class="center">일반전화번호</th>
					<th class="center">상세보기</th>
				</tr>
			</thead>
			<tbody id="listWrap">
				<tr data-ng-if="board.list.length==0"><td colspan="11" class="center">결과가 없습니다.</td></tr>
				<tr data-ng-repeat="item in board.list">
					<td class="center">{{(board.totalCount|num) + 1 - (item.rn|num)}}</td>
					<td class="left member_nm pointcolor">{{item.menu_nm}}</td>
					<td class="center">{{item.total}} 건</td>
					<td class="center">{{item.jumin_total}} 건</td>
					<td class="center">{{item.email_total}} 건</td>
					<td class="center">{{item.card_total}} 건</td>
					<td class="center">{{item.busino_total}} 건</td>
					<td class="center">{{item.bubino_total}} 건</td>
					<td class="center">{{item.cell_total}} 건</td>
					<td class="center">{{item.tel_total}} 건</td>
					<td class="center"><input type="button" data-my-href="/detail/{{item.cms_menu_seq}}" value="상세보기" class="bt_small_bt1"/></td>
				</tr>
			</tbody>
		</table>
		<pagination total-page="board.totalPage" current-page="board.currentPage" on-select-page="board.go(page)"></pagination>

	</div>
</div>