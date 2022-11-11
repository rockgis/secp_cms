<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<div class="contents" data-ng-cloak>
		<form name="searchFrm" method="post">
			<div class="solr_sch">
				<h6>통합검색의 정확도를 높이기 위해 검색 데이터를 수동으로 갱신할 수 있습니다.</h6>
				<p>데이터 갱신은 수십분의 시간이 소요되며 시스템이 느려질 수 있습니다.</p>
				<div>
					<span data-ng-if="form.status == 'P'">검색 데이터를 <b>갱신 중</b>입니다...</span><!-- 갱신 중 메시지 -->
					<span data-ng-if="form.status == 'F'"><b>{{form.minute | number:2}}</b>분 소요, <b>{{form.count}}</b>개의 검색 데이터가 갱신되었습니다.</span><!-- 갱신 결과 메시지 -->
					<button value="검색 데이터 갱신" class="bt_small refresh" data-ng-click="update_search()">검색 데이터 갱신</button>
				</div>
				<span data-ng-if="form.status == 'P'">마지막 갱신일 : 갱신 중...</span>
				<span data-ng-if="form.status == 'F'">마지막 갱신일 : <span ng-frettydate fretty-option="{dateFormat:'YYYY-MM-DD hh:mm:ss', autoUpdate:true, duration:10000}" pretty-val="form.last_update"></span></span>
			</div>
		</form>
		
	</div>
