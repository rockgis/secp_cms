<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<div ng-controller="etcCtrl" title="만족도 의견보기">
		<table class="type1">
          	<colgroup>
          		<col style="width:60px;" />
          		<col style="width:140px;" />
          		<col />
          	</colgroup>
          	<tr>
            	<th class="center">번호</th>
            	<th class="center">일자</th>
            	<th class="center">의견</th>
          	</tr>
          	<tr data-ng-if="etc.list.length==0"><td colspan="3" class="center">의견이 없습니다.</td></tr>
          	<tr data-ng-repeat="item in etc.list">
          		<td class="center">{{(etc.totalCount|num) + 1 - (item.rn|num)}}</td>
            	<td class="center">{{item.reg_dt|myDate:'yyyy-MM-dd HH:mm'}}</td>
            	<td class="left">{{item.etc}}</td>
          	</tr>
        </table>
        <pagination total-page="etc.totalPage" current-page="etc.currentPage" on-select-page="etc.go(page)"></pagination>
		<div class="btn_bottom">
	    	<div class="r_btn">
	          <input type="button" value="닫기" class="bt_big_bt4" data-ng-click="close()"/>
	        </div>
	    </div>
	</div>