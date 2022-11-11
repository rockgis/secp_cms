<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<div ng-controller="linkListCtrl" title="메뉴 목록">
		<table class="type1">
		<colgroup>
		    <col style="width:50px;"/>
		    <col/>
		    <col style="width:100px;"/>
		    <col style="width:120px;"/>
		</colgroup>
		<tr>
			<th class="center">번호</th>
			<th class="center">연결메뉴</th>
			<th class="center">일자</th>
			<th class="center">페이지 이동</th>
		</tr>
		<tr data-ng-repeat="item in menuList">
      		<td class="center">{{$index + 1}}</td>
           	<td class="left">{{item.page_navi}}</td>
           	<td class="center">{{item.reg_dt}}</td>
           	<td class="center"><button value="페이지이동" ng-click="openLink(item.menu_url)" class="bt_small move">페이지 이동</button></td>
	    </tr>
		</table>
		
		<div class="btn_bottom">
			<div class="r_btn">
				<input type="button" value="닫기" class="bt_big_bt2" data-ng-click="close()"/>
			</div>
		</div>
	</div>