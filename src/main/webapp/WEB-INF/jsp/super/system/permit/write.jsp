<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
		<div class="contents" data-ng-cloak>
			<form id="wFrm" name="wFrm" method="post" novalidate="novalidate">
		    <table class="type1" style="margin-top:0; margin-bottom:15px;">
			    <colgroup>
			    	<col width="200px" />
			    	<col width="*" />
			    </colgroup>
		    	<caption>권한 등록</caption>
		    	<tr>
					<th>사이트선택</th>
					<td>
						<select title="사이트선택" class="normal w175" data-ng-model="form.site_id" data-ng-options="item.cms_menu_seq as item.title for item in main.site_list" ng-change="menuList()">
           				</select>
					</td>
				</tr>
				<tr>
					<th>권한명</th>
					<td>
						<input type="text" class="normal w175" data-ng-model="form.title" required="required"/>
					</td>
				</tr>
		    </table>
		    
		    <div style="overflow-y: scroll; border:1px solid #ddd; height: 400px; padding: 15px;">
		    <table class="type1" style="margin-top:0;">
		    <colgroup>
	          <col width="*" />
	          <col width="7%" />
	          <col width="7%" />
	          <col width="7%" />
		    </colgroup>
		    	<thead>
				<tr>
					<th>메뉴</th>
					<th class="center"><p>추가</p><label><input type="checkbox" ng-model="all_chk1" ng-change="all_chk(1, all_chk1)"/><span class="all_chk">전체선택</span></label></th>
					<th class="center"><p>수정/삭제</p><label><input type="checkbox" ng-model="all_chk2" ng-change="all_chk(2, all_chk2)"/><span class="all_chk">전체선택</span></label></th>
					<th class="center"><p>조회</p><label><input type="checkbox" ng-model="all_chk3" ng-change="all_chk(3, all_chk3)"/><span class="all_chk">전체선택</span></label></th>
				</tr>
				</thead>
				<tbody>
					<tr data-ng-repeat="item in form.list">
						<td ng-style="depthStyle(item)">{{item.title}}</td>
						<td class="center" ng-if="!!item.menu_level"><input type="checkbox" ng-model="item.add_yn" ng-true-value="'Y'" ng-false-value="'N'"/></td>
						<td class="center" ng-if="!!item.menu_level"><input type="checkbox" ng-model="item.mod_yn" ng-true-value="'Y'" ng-false-value="'N'"/></td>
						<td class="center" ng-if="!!item.menu_level"><input type="checkbox" ng-model="item.view_yn" ng-true-value="'Y'" ng-false-value="'N'"/></td>
					</tr>
				</tbody>
		    </table>
		    </div>
		    
		    <div class="btn_bottom">
		    	<div class="r_btn">
					<input type="button" value="저장" class="bt_big_bt4" data-ng-click="save()"/>
					<input type="button" value="취소" class="bt_big_bt3" data-ng-click="list()"/>
		        </div>
		    </div>
		    
			</form>
		</div>
