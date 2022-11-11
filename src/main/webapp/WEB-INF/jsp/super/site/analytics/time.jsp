<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="contents_wrap" style="background:#fff;">
	<div class="conwrap_tap">
		<ul>
			<li><a my-href="/intro"><span>대시보드</span></a></li>
			<li><a my-href="/day"><span>일자별 통계</span></a></li>
			<li class="on"><a my-href="/time"><span>시간별 통계</span></a></li>
			<li><a my-href="/page"><span>페이지 분석</span></a></li>
	   	</ul>
	</div>
	<div class="contents" data-ng-cloak>
	 	
	    <form name="searchFrm" method="post" data-ng-submit="getPage()">
	    <table class="type1" style="margin-top:0;">
			<colgroup>
				<col style="width:200px;" />
				<col />
			</colgroup>
			<tr>
				<th scope="row">일자</th>
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
				<th scope="row" colspan="2" style="text-align:center; padding-left:0px; padding-right:0px;">
					<a class="bt_big_bt5" data-ng-click="getPage()">검색</a>
				</th>
			</tr>
		</table>
	    </form>

	  	<table class="statistics" style="margin-top:35px;">
		  	<colgroup>
		    	<col style="width:65%;" />
		    	<col style="width:35%;" />
		    </colgroup>
		    <tbody>
		      	<tr>
		        	<td>
		        		<canvas class="chart chart-line" chart-data="chart.data" chart-labels="chart.labels" chart-series="chart.series" chart-colours="chart.colors" height="100"></canvas>
		        	</td>
		        	<td><canvas class="chart chart-pie" chart-options="browser.options" chart-data="browser.data" chart-labels="browser.labels" height="130"></canvas></td>
		      	</tr>	
		      	<tr>
		      		<td>
		        		<div style="overflow-y:scroll; height:350px;">
							<table class="type1" style="margin-top:0px;">
								<colgroup>
									<col style="width:10%;" />
									<col />
									<col />
									<col />
								</colgroup>
								<tr>
									<th scope="col" class="center">일자</th>
									<th scope="col" class="center">방문자 수</th>
									<th scope="col" class="center">방문횟수</th>
									<th scope="col" class="center">페이지뷰</th>
								</tr>
								<tr data-ng-if="boardlist.length==0">
									<td colspan="4" class="center">결과가 없습니다.</td>
								</tr>
								<tr data-ng-repeat="item in boardlist">
									<td class="center">{{item.dis}}</td>
									<td class="center">{{item.visit_cnt}}</td>
									<td class="center">{{item.visitant_cnt}}</td>
									<td class="center">{{item.view_cnt}}</td>
								</tr>
							</table>
		        		</div>
		        	</td>
		        	<td><canvas class="chart chart-pie" chart-options="os.options" chart-data="os.data" chart-labels="os.labels" chart-series="os.series" height="138"></canvas></td>
		      	</tr>
		    </tbody>
	  	</table>
	  	<div class="btn_bottom">
	    	<div class="r_btn">
	    		<a style="display:inline-block; overflow:hidden; height:30px;" href="">
	    			<input type="button" value="" class="bt_big_bt1_2" data-ng-click="excel_down()"/>
	    			<input type="button" value="엑셀다운로드" class="bt_big_bt1" data-ng-click="excel_down()"/>
	    		</a>
	        </div>
	    </div>
	</div>
</div>