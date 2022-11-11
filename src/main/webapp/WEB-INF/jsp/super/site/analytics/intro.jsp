<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="contents_wrap" style="background:#fff;">
	<div class="conwrap_tap">
		<ul>
			<li class="on"><a my-href="/intro"><span>대시보드</span></a></li>
			<li><a my-href="/day"><span>일자별 통계</span></a></li>
			<li><a my-href="/time"><span>시간별 통계</span></a></li>
			<li><a my-href="/page"><span>페이지 분석</span></a></li>
	   	</ul>
	</div>
	<div class="contents" data-ng-cloak>
		<div style="overflow:hidden;">
			<h4 style="float:left; font-size:15px;">실시간 방문자 통계</h4>
			<p style="float:right;">{{param.start_dt|myDate:'yyyy년 MM월 dd일' }}</p>
		</div>
		<table class="statistics" style="margin-top:30px;">
			<caption></caption>
			<colgroup>
				<col style="width:30%;" />
				<col />
			</colgroup>
			<tr>
				<td class="v_top">
					<label for=""><h4>방문통계</h4></label>
					<ul style="margin:80px 0 50px 0;">
					    <li>
						    <p>{{data1.visit_cnt}}명</p>
						    <span>방문자</span>
					    </li>
					    <li>
						    <p>{{data1.visitant_cnt}}명</p>
						    <span>방문횟수</span>
					    </li>
					    <li>
						    <p>{{data1.view_cnt}}명</p>
						    <span>페이지뷰</span>
					    </li>
				    </ul>
				</td>
				<td class="v_top">
					<label for=""><h4>최다 페이지 뷰</h4></label>
					<table class="type1 most_viewed">
						<colgroup>
							<col style="width:10%;" />
							<col />
							<col style="width:25%;" />
							<col style="width:20%;" />
						</colgroup>
						<tr>
							<th scope="col" class="center">방문횟수</th>
							<th scope="col" class="center">타이틀</th>
							<th scope="col" class="center">URL</th>
							<th scope="col" class="center">비율</th>
						</tr>
						<tr data-ng-if="data2.length==0">
							<td colspan="4" class="center">결과가 없습니다.</td>
						</tr>
						<tr data-ng-repeat="item in data2">
							<td class="center">{{item.cnt}}</td>
							<td class="left member_nm pointcolor"><any ng-bind-html="item.title"></any>{{trustAsHtml(item.title)}}<a href="{{item.request_uri}}" target="_blank" title="새창열림"><img src="/images/common/new_window.png" style="margin-left:5px;" /></a></td>
							<td class="left">{{item.request_uri}}</td>
							<td class="center"><span style="width:75%; display:block; float:left;"><span style="background-color:#4293e6; height: 20px; display: block;" ng-style="{width:item.per+'%'}"></span></span>{{item.per|number:2}}%</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
	</div>
</div>