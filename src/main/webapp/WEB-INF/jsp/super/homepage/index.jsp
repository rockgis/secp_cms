<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="/WEB-INF/tlds/DateUtil_fn.tld" prefix="dtf" %>
<%@ taglib uri="/WEB-INF/tlds/StringUtil_fn.tld" prefix="suf" %>
<c:set var="type_1_cnt" value="0" />
<c:set var="type_2_cnt" value="0" />
<c:set var="type_3_cnt" value="0" />
<c:set var="type_4_cnt" value="0" />
<c:set var="type_5_cnt" value="0" />
<c:forEach var="item" items="${data.menu_status}" step="6" varStatus="status">
<c:set var="type_1_cnt" value="${type_1_cnt + data.menu_status[status.index+1].level_cnt }" />
<c:set var="type_2_cnt" value="${type_2_cnt + data.menu_status[status.index+2].level_cnt }" />
<c:set var="type_3_cnt" value="${type_3_cnt + data.menu_status[status.index+3].level_cnt }" />
<c:set var="type_4_cnt" value="${type_4_cnt + data.menu_status[status.index+4].level_cnt }" />
<c:set var="type_5_cnt" value="${type_5_cnt + data.menu_status[status.index+5].level_cnt }" />
</c:forEach>
<!DOCTYPE html>
<html>
<head>
<title>메뉴관리</title>
<script type="text/javascript" src="${context_path }/lib/js/angular.min.js"></script>
<script type="text/javascript" src="${context_path }/lib/js/angular-route.min.js"></script>
<script type="text/javascript" src="${context_path }/lib/js/angular-sanitize.min.js"></script>
<script type="text/javascript" src="${context_path }/lib/js/filters/myFilter.js"></script>
<script type="text/javascript" src="${context_path }/lib/js/filters/ngRange.js"></script>
<script type="text/javascript" src="${context_path }/lib/js/services/myCommon.js"></script>
<script type="text/javascript" src="${context_path }/lib/js/services/dialog-service.js"></script>
<script type="text/javascript" src="${context_path }/lib/js/directives/myUtil.js"></script>
<script type="text/javascript" src="${context_path }/lib/js/directives/myPagination.js"></script>
<script type="text/javascript" src="${context_path }/lib/js/directives/sortable.js"></script>
<script type="text/javascript" src="${context_path }/lib/js/directives/myEditor.js"></script>
<script type="text/javascript" src="${context_path }/lib/js/html2canvas.js"></script>
<script type="text/javascript" src="${context_path }/lib/js/jquery.blockUI.js"></script>
<script type="text/javascript" src="/lib/chart/Chart.js"></script>
<script type="text/javascript" src="/lib/chart/angular-chart.js"></script>
<script type="text/javascript">
var app=angular.module("MyApp", ['dialogService', 'ngRoute', 'myUtil', 'myPagination', 'myCommon', 'ui.sortable', 'myFilter', 'myEditor', 'ngRange', 'ngSanitize', 'chart.js']);
app.run(function($rootScope, $timeout){
	$rootScope.param={
	};
});
app.controller("mainCtrl", function($scope, $timeout, $location, ajaxService, $filter) {
	$scope.browser = {
		options : {
			legend: {
				display: true,
				position: 'bottom'
			},
			scales: {
		    },
			maintainAspectRatio:false
		},
		labels : ["페이지", "게시판", "프로그램", "링크", "하위메뉴링크"],
		data : [${type_1_cnt}, ${type_2_cnt}, ${type_3_cnt}, ${type_4_cnt}, ${type_5_cnt}]
	};
});
</script>
</head>
<body>
<div class="titlebar">
	<h2>대시보드</h2>
	<div>
		&gt; <span>대시보드</span>
	</div>
</div>
<div data-ng-controller="mainCtrl" class="contents_wrap" style="margin-bottom:60px;" data-ng-cloak>
	<div class="ct_wrap" style="padding:0; border:none; background:none;">
	    <div class="contents" style="top:0; padding:0; border:none; background:none; min-height:0;">
	    	<div class="dash_top">
		    	<div class="current_state dash_left">
		    		<h3 class="dash_title">메뉴현황</h3>
		    		<ul>
		    			<c:forEach var="item" items="${data.menu_status}" step="6" varStatus="status">
		    			<li>
		    				<div class="cs_wrap">
		    					<div class="cs_depth">
		    						<p>${item.menu_level }뎁스</p><span>${item.level_cnt }</span>
		    					</div>
		    					<div class="cs_text">
		    						<span class="cs_l">사용 : ${item.use_cnt }</span>
		    						<span class="cs_r">미사용 : ${item.level_cnt - item.use_cnt }</span>
		    					</div>
		    					<div class="cs_status">
		    						<p>페이지<span>${data.menu_status[status.index+1].level_cnt }</span></p>
		    						<p>게시판<span>${data.menu_status[status.index+2].level_cnt }</span></p>
		    						<p>프로그램<span>${data.menu_status[status.index+3].level_cnt }</span></p>
		    						<p>링크<span>${data.menu_status[status.index+4].level_cnt }</span></p>
		    						<p>하위메뉴링크<span>${data.menu_status[status.index+5].level_cnt }</span></p>
		    					</div>
		    				</div>	    				
		    			</li>
		    			</c:forEach>
		    		</ul>
		    	</div>
		    	<div class="graph dash_right">
		    		<div style="width:200px; height:260px; display:inline-block">
						<canvas class="chart chart-pie" chart-options="browser.options" chart-data="browser.data" chart-labels="browser.labels" width="232" height="300"></canvas>
					</div>
		    	</div>
	    	</div>
	    	<div class="dash_bottom">
	    		<div class="dash_left">
	    			<h3 class="dash_title">최신게시글(${fn:length(data.latest_article) })</h3>
	    			<div style="padding:0 20px 25px 20px;">
		    			<table class="dash">
		    				<caption></caption>
		    				<colgroup>
		    					<col width="15%" />
		    					<col width="*" />
		    					<col width="15%" />
		    					<col width="15%" />
		    				</colgroup>
		    				<thead>
		    					<tr>
		    						<th class="center">게시판명</th>
		    						<th class="center">제목</th>
		    						<th class="center">등록일</th>
		    						<th class="center">등록자</th>
		    					</tr>
		    				</thead>
		    				<tbody>
		    					<c:if test="${empty data.latest_article }">
		    						<tr><td colspan="4" class="center">결과가 없습니다.</td></tr>
		    					</c:if>
		    					<c:forEach items="${data.latest_article }" var="item" varStatus = "status">
		    						<tr>
			    						<td class="center">${suf:clearXSS(item.board_nm, '')}</td>
			    						<%-- <td class="left pointcolor"><a href="/super/homepage/bbs/index.do?cms_menu_seq=${item.cms_menu_seq }&amp;parent_menu_seq=${item.parent_menu_seq }&amp;permit=${param.permit }#!/modify/${item.board_type }/${item.article_seq }">${item.title }</a></td> --%>
			    						<td class="left pointcolor"><a href="/super/homepage/bbs/index.do?cms_menu_seq=${item.cms_menu_seq }&amp;parent_menu_seq=${item.parent_menu_seq }&amp;permit=Y#!/modify/${item.board_type }/${item.article_seq }">${suf:clearXSS(item.title, '')}</a></td>
			    						<td class="center">${item.reg_dt }</td>
			    						<td class="center">${item.reg_nm }</td>
			    					</tr>	
		    					</c:forEach>
		    					
		    				</tbody>
		    			</table>
	    			</div>
	    		</div>
	    		<div class="dash_right">
	    			<div class="dash_r1" style="margin-bottom:20px;">
	    				<h3 class="dash_title">인기페이지</h3>
	    				<div style="padding:0 20px 20px 20px;">
		    				<table class="dash">
			    				<caption></caption>
			    				<colgroup>
			    					<col width="15%" />
			    					<col width="30%" />
			    					<col width="*" />
			    				</colgroup>
			    				<thead>
			    					<tr>
			    						<th class="center">순위</th>
			    						<th class="center">메뉴명</th>
			    						<th class="center">제목</th>
			    					</tr>
			    				</thead>
			    				<tbody>
			    					<c:if test="${empty data.popular_article }">
			    						<tr><td colspan="3" class="center">결과가 없습니다.</td></tr>
			    					</c:if>
			    					<c:forEach items="${data.popular_article }" var="item" varStatus = "status">
			    						<tr>
				    						<td class="center">${item.rn}</td>
				    						<td class="center">${suf:clearXSS(item.board_nm, '')}</td>
				    						<td class="left pointcolor"><a href="/super/homepage/bbs/index.do?cms_menu_seq=${item.cms_menu_seq }&amp;parent_menu_seq=${item.parent_menu_seq }&amp;permit=Y#!/modify/${item.board_type }/${item.article_seq }">${suf:clearXSS(item.title, '')}</a></td>
				    					</tr>	
			    					</c:forEach>
			    				</tbody>
			    			</table>
		    			</div>
	    			</div>
	    			<div class="dash_r2">
	    				<h3 class="dash_title">방문횟수</h3>
	    				<ul class="user_statistics">
	    					<li>
	    						<div class="us_1">
	    							<p class="us_stats">${data.today_cnt }</p>
	    							<p class="us_today">오늘</p>
	    							<span>${dtf:getTime('yyyy-MM-dd') }</span>
	    						</div>
	    					</li>
	    					<li>
	    						<div class="us_2">
	    							<p>어제<span>${data.yesterday_cnt }</span></p>
	    							<p>이번주<span>${data.week_cnt }</span></p>
	    							<p>전체<span>${suf:setComma(data.total_cnt) }</span></p>
	    						</div>
	    					</li>
	    				</ul>
	    			</div>
				</div>
	    	</div>
	    </div>
		<%-- <div id="topBar"><bookmark userid="${sessionScope.cms_member.member_id }"></bookmark></div> --%>
		<div id="topBar">
		   	<div class="topBar_inner">
				<bookmark userid="${sessionScope.cms_member.member_id }"></bookmark>
			</div>
			<span class="optBtn"><a href="javascript:void(0)"><img src="/images/cms/opt_close.gif" alt=""></a></span>
		</div>
	</div>
</div>
</body>
</html>