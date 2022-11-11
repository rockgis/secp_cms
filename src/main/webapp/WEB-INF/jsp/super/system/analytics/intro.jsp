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
					<select title="사이트선택" class="normal w175" style="float:right;" data-ng-model="param.site_id" data-ng-options="item.cms_menu_seq as item.title for item in main.site_list" ng-change="getData()">
						<option value="">전체</option>
				    </select>
					<ul style="margin:80px 0 50px 0;">
					    <li>
						    <p>{{data1.visitant_cnt}}명</p>
						    <span>방문자</span>
					    </li>
					    <li>
						    <p>{{data1.visit_cnt}}명</p>
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
							<col style="width:70px;" />
							<col />
							<col style="width:250px;" />
							<col style="width:200px;" />
							<col style="width:120px;" />
						</colgroup>
						<tr>
							<th scope="col" class="center">방문횟수</th>
							<th scope="col" class="center">타이틀</th>
							<th scope="col" class="center">URL</th>
							<th scope="col" class="center">비율</th>
							<th scope="col" class="center">페이지 이동</th>
						</tr>
						<tr data-ng-if="data2.length==0">
							<td colspan="5" class="center">결과가 없습니다.</td>
						</tr>
						<tr data-ng-repeat="item in data2">
							<td class="center">{{item.cnt}}</td>
							<td class="left member_nm pointcolor"><any ng-bind-html="item.title"></any>{{trustAsHtml(item.title)}}</td>
							<td class="left">{{item.request_uri}}</td>
							<td class="center"><span style="width:70%; display:block; float:left;"><span style="background-color:#4293e6; height: 20px; display: block;" ng-style="{width:item.per+'%'}"></span></span>{{item.per|number:2}}%</td>
							<td class="center"><button value="페이지이동" ng-click="openLink(item.request_uri)" class="bt_small move">페이지 이동</button></td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
	</div>
</div>