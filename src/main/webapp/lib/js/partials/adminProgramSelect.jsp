<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div data-ng-controller="programCtrl" data-ng-cloak class="contents" title="프로그램 선택">
	<div class="fn_wrap" style="overflow:hidden;">
		<form name="searchForm" id="searchForm" method="post" >
		<table class="type1">
		    <colgroup>
		    	<col width="100px" />
		    	<col width="*" />
		    </colgroup>
		    <caption></caption>
			<tr>
				<th>검색어</th>
				<td>
					<input type="text" class="normal" style="width:100%;" data-ng-model="keyword" />
				</td>
			</tr>
			<tr>
				<th colspan="2" style="text-align:center; padding-left:0px; padding-right:0px;">
					<%-- <a data-ng-click="board.go(1)"><img src="<c:url value="/images/super/contents/s_btn_search.gif"/>" alt="검색" /></a> --%>
					<a class="bt_big_bt5" data-ng-click="board.go(1)">검색</a>
				</th>
			</tr>
		</table>
		</form>
        </div>
		<table class="type1">
			<colgroup>
				<col width="*" />
			  	<col width="15%" />
			</colgroup>
			<thead>
				<tr>
					<th class="center">프로그램명</th>
					<th class="center">선택</th>
				</tr>
			</thead>
			<tbody id="boardWrap">
				<tr data-ng-repeat="item in programs|filter:keyword">
					<td>{{item.program_nm}} <span style="color:#3e70c9; font-size:12px; letter-spacing:0;">{{item.url}}</span></td>
					<td class="center">
						<input type="button" class="btalls" value="선택" data-ng-click="programSelect(item);" />
					</td>
				</tr>
			</tbody>
		</table>
	</div>
