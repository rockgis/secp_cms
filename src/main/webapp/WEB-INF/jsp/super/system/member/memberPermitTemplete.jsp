<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<div ng-controller="memberPermitCtrl" title="개인권한변경" >
		
		<div class="popup_tit">
			<p>
				<span class="pop_stat" ng-if="form.md=='2'">기본</span><b ng-bind="model.member_nm"></b>(<span ng-bind="model.member_id"></span>)님
				<div class="popup_navi" >
					소속그룹 : <b ng-bind="model.group_nm"></b>
				</div>
			</p>
			<select title="사이트선택" class="normal w175" data-ng-model="form.site_id" data-ng-options="item.cms_menu_seq as item.title for item in site_list" ng-change="changeSite()">
	        </select>
        </div>
		<div style="width:100%; height:460px; border-top:solid 1px #ddd; border-bottom:solid 1px #ddd;" scrollable="scrollOption">
		    <table class="type1" style="margin-top:0px;">
			    <colgroup>
		        	<col width="*" />
		          	<col width="11%" />
		          	<col width="11%" />
		          	<col width="11%" />
			    </colgroup>
		    	<thead>
				<tr>
					<th style="border-right:solid 1px #ddd;">메뉴명</th>
					<th style="border-right:solid 1px #ddd;" class="center"><p>추가</p><label><input type="checkbox" ng-model="all_chk1" ng-change="all_chk(1, all_chk1)"/><span class="all_chk">전체선택</span></label></th>
					<th style="border-right:solid 1px #ddd;" class="center"><p>수정</p><label><input type="checkbox" ng-model="all_chk2" ng-change="all_chk(2, all_chk2)"/><span class="all_chk">전체선택</span></label></th>
					<th class="center"><p>조회</p><label><input type="checkbox" ng-model="all_chk3" ng-change="all_chk(3, all_chk3)"/><span class="all_chk">전체선택</span></label></th>
				</tr>
				</thead>
				<tbody>
					<tr data-ng-repeat="item in form.list">
						<td style="border-right:solid 1px #ddd;" ng-style="depthStyle(item)">{{item.title}}</td>
						<td style="border-right:solid 1px #ddd;" class="center"><input type="checkbox" ng-model="item.add_yn" ng-true-value="'Y'" ng-false-value="'N'"/></td>
						<td style="border-right:solid 1px #ddd;" class="center"><input type="checkbox" ng-model="item.mod_yn" ng-true-value="'Y'" ng-false-value="'N'"/></td>
						<td class="center"><input type="checkbox" ng-model="item.view_yn" ng-true-value="'Y'" ng-false-value="'N'"/></td>
					</tr>
				</tbody>
		    </table>
		</div>
			
		<div class="btn_bottom">
			<div class="r_btn">
				<input type="button" value="저장" class="bt_big_bt4" data-ng-click="save()"/>
			</div>
		</div>
	</div>