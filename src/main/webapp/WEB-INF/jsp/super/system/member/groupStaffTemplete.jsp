<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<div ng-controller="groupStaffCtrl" title="담당자지정" >
		
		<div class="popup_tit">
			<p>
				<div class="popup_navi" >
					소속그룹 : <b ng-bind="model.group_nm"></b>
				</div>
			</p>
			<select title="사이트선택" class="normal w175" style="top:10px;" data-ng-model="form.site_id" data-ng-options="item.cms_menu_seq as item.title for item in site_list" ng-change="changeSite()">
	        </select>
        </div>
		<div class="popup_contents">
			<div style="height:250px;" scrollable="scrollOption">
			   <div class="staffDiv" >
					<ul class="list treeview treeview3">
						<li class="expandable">
							<span>메뉴</span>
						</li>
					</ul>
			   </div>
			</div> 
		</div>
		<div class="chk_list">
			<div>
				<span ng-repeat="item in form.select_list" style="cursor:pointer;" data-ng-click="selectMenu(item)">{{item.title}}</span>
			</div> 
		</div>
		<div class="btn_bottom">
			<div class="r_btn">
				<input type="button" value="확인" class="bt_big_bt4" data-ng-click="save()"/>
			</div>
		</div>
	</div>