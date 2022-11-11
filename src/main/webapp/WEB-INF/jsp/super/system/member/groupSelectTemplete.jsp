<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<div ng-controller="groupSelectCtrl" title="그룹선택">
		<div class="nav nav_style_1" style="width:350px; height:250px;" scrollable="scrollOption">
			<div class="dept_container" >
			<ul class="list treeview2" id="select_tree">
				<li>
					그룹
				</li>
			</ul>
			</div>
		</div>
		<div class="btn_bottom">
			<div class="r_btn">
				<input type="button" value="취소" class="bt_big_bt3" data-ng-click="cancel()"/>
			</div>
		</div>
	</div>