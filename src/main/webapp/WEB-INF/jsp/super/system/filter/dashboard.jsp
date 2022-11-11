<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/WEB-INF/tlds/DateUtil_fn.tld" prefix="dtf" %>
<div style="padding:20px; background:#fff;">
	<div class="conwrap_tap">
		<ul>
			<li class="on"><a my-href="/dashboard"><span>대시보드</span></a></li>
			<li><a my-href="/daylist"><span>월별 검출내역</span></a></li>
			<li><a my-href="/menulist"><span>메뉴별 검출내역</span></a></li>
			<li><a my-href="/setting"><span>필터설정</span></a></li>
	   	</ul>
	</div>
	<div class="contents" data-ng-cloak>
		
		<table class="filter" style="margin-top:0px;">
		    <colgroup>
		    	<col width="70%">
		    	<col width="30%">
		    </colgroup>		
		    <tbody>
				<tr data-ng-if="board.list.length != 0">
		        	<td colspan="2">
						<select title="사이트선택" class="normal w175" data-ng-model="param.site_id" data-ng-options="item.cms_menu_seq as item.title for item in main.site_list" ng-change="board.go()">
           				</select>
           				
		        		<h4 style="margin-top:10px;"><label class="chart-title">${dtf:getTime('M') }월 개인정보 의심 검출 내역</label></h4>
		        		<span class="date">${dtf:getTime('YYYY년 MM월') } 기준</span>
		        		<ul>
		        			<li>
			        			<p>{{chartData1.total}}개</p>
			        			<span>개인정보 의심</span>
			        		</li>
			        		<li>
			        			<canvas id="doughnut" class="chart chart-doughnut" chart-data="chartData1.data" chart-labels="chartData1.labels" chart-series="chartData1.series" chart-options="chartData1.options" width="400" height="200"></canvas>
			        		</li>
		        		</ul>
		        	</td>
				</tr>
				<tr>
					<td>
						<label class="chart-title"><h4>${dtf:getTime('YYYY') }년 월별 검출 내역</h4></label>
						<canvas id="bar" class="chart chart-bar" style="margin-top:30px;" chart-options="chartData2.options" chart-data="chartData2.data" chart-labels="chartData2.labels" chart-series="chartData2.series" height="100"></canvas>
					</td>
					<td class="v_top" style="position:relative;">
						<label class="chart-title"><h4>필터링 설정현황</h4></label>
						<div class="filter_condition">
							<p>{{chartData2.filterset.cnt1+chartData2.filterset.cnt2}}개</p>
							<span>개인정보 설정</span>
							<ul>
								<li>개별필터 : {{chartData2.filterset.cnt1}}개</li>
								<li>기본필터 : {{chartData2.filterset.cnt2}}개</li>
							</ul>
							<a href="/super/system/filter/index.do?cms_menu_seq=917#!/setting">필터링 설정</a>
						</div>
					</td>
				</tr>
	    	</tbody>
		</table>

	</div>
</div>