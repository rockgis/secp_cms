<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
		<div class="contents">
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
							<option value="">전체</option>
           				</select>
					</td>
				</tr>
				<%-- 
				<tr>
					<th scope="row">검색구분</th>
					<td>
						<select title="검색조건 선택" class="normal w175" data-ng-model="param.condition" data-ng-init="param.condition='title'">
				            <option value="title">메뉴명</option>
				        </select>
					</td>
				</tr>
				--%>
				<tr>
					<th scope="row">조사기간</th>
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
					<th scope="row">메뉴명</th>
					<td>
						<input type="text" class="normal w175" data-ng-model="param.keyword"/>
					</td>
				</tr>
				<tr>
					<th scope="row" colspan="2" style="text-align:center; padding-left:0px; padding-right:0px;">
						<a class="bt_big_bt5" data-ng-click="board.go(1)">검색</a>
					</th>
				</tr>
			</table>
			
			<div style="overflow:hidden; margin-top:35px;">
		        <div class="left_box_cms"> 
		          	<span class="board_listing">TOTAL : <span><b>{{board.totalCount|number}}</b></span> 건 </span><span style="font-size:12px;">(<b>{{board.currentPage|number}}</b> / {{board.totalPage|number}} page)</span>
		        </div>
		        <div class="right_box_cms">
		        	<select class="normal w100" data-ng-model="param.rows" data-ng-change="board.go(1)">
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
	          		<col />
	          		<col style="width:95px;" />
	          		<col style="width:95px;" />
	          		<col style="width:95px;" />
	          		<col style="width:95px;" />
	          		<col style="width:95px;" />
	          		<col style="width:95px;" />
	          		<col style="width:95px;" />
	          		<col style="width:120px;" />
	          	</colgroup>
	          	<tr>
	            	<th scope="col" class="center">번호</th>
	            	<th scope="col" class="center">메뉴명</th>
	            	<th scope="col" class="center">매우만족</th>
	            	<th scope="col" class="center">만족</th>
	            	<th scope="col" class="center">보통</th>
	            	<th scope="col" class="center">불만족</th>
	            	<th scope="col" class="center">매우불만족</th>
	            	<th scope="col" class="center">기타의견</th>
	            	<th scope="col" class="center" style="border-left:3px double #ddd;">합계</th>
	            	<th scope="col" class="center">상세보기</th>
	          	</tr>
	          	<tr data-ng-if="board.list.length==0"><td colspan="11" class="center">결과가 없습니다.</td></tr>
	          	<tr data-ng-repeat="item in board.list">
	          		<td class="center">{{(board.totalCount|num) + 1 - (item.rn|num)}}</td>
	            	<td class="left member_nm">{{item.title}}</td>
	            	<td class="center">{{item.sum_score5}}</td>
	            	<td class="center">{{item.sum_score4}}</td>
	            	<td class="center">{{item.sum_score3}}</td>
	            	<td class="center">{{item.sum_score2}}</td>
	            	<td class="center">{{item.sum_score1}}</td>
	            	<td class="center"><a class="btalls" data-ng-click="openEtc(item)">{{item.sum_score0}} 건</a></td>
	            	<td class="center" style="border-left:3px double #ddd;">{{item.total_count}}</td>
	            	<td class="center">
	            		<button class="bt_small view" data-ng-click="openResult(item)">상세보기</button>
	            	</td>
	          	</tr>
	        </table>
	        <pagination total-page="board.totalPage" current-page="board.currentPage" on-select-page="board.go(page)"></pagination>
	        <div class="btn_bottom">
		    	<div class="r_btn">
		    		<a style="display:inline-block; overflow:hidden; height:30px;" href="">
						<input type="button" value="" class="bt_big_bt1_2" data-ng-click="excel_down()"/>
						<input type="button" value="엑셀다운로드" class="bt_big_bt1" data-ng-click="excel_down()"/>
					</a>
		        </div>
		    </div>
		</div>
