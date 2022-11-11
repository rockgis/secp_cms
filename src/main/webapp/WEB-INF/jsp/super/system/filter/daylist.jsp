<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/WEB-INF/tlds/DateUtil_fn.tld" prefix="dtf" %>
<div style="padding:20px; background:#fff;">
	<div class="conwrap_tap">
		<ul>
			<li><a my-href="/dashboard"><span>대시보드</span></a></li>
			<li class="on"><a my-href="/daylist"><span>월별 검출내역</span></a></li>
			<li><a my-href="/menulist"><span>메뉴별 검출내역</span></a></li>
			<li><a my-href="/setting"><span>필터설정</span></a></li>
	   	</ul>
	</div>
	<div class="contents" data-ng-cloak>
		
		<table class="statistics filter" style="margin-top:0px;">
		    <colgroup>
		    	<col width="100%">
		    </colgroup>		
		    <tbody>
				<tr>
		        	<td>
						<select title="사이트선택" class="normal w175" data-ng-model="param.site_id" data-ng-options="item.cms_menu_seq as item.title for item in main.site_list">
           				</select>
		        		<label class="chart-title">{{param.year}}년 {{param.month}}월 별 검출 내역</label>
		        		<div style="margin:30px 0 20px 0;">
		        			<select class="normal" title="년" data-ng-model="param.year" data-ng-options="item as item for item in [1950, 2050]|range:4"></select>
							<span style="margin-right:10px;">년</span> 
							<select class="normal" title="월" data-ng-model="param.month" data-ng-options="item as item for item in [1, 12]|range:2"></select>
							<span>월</span>
							<a ng-click="changeDate()" class="sch_btn">검색</a>
		        		</div>
						<canvas id="bar" class="chart chart-bar" chart-options="chartData.options" chart-data="chartData.data" chart-labels="chartData.labels" chart-series="chartData.series" height="100"></canvas>
		        	</td>
				</tr>
	    	</tbody>
		</table>


	</div>
</div>