<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
		<div class="contents" data-ng-cloak>
			<form id="wFrm" name="wFrm" method="post" novalidate="novalidate">
		    <table class="type1" style="margin-top:0;">
			    <colgroup>
				    <col style="width:200px;" />
				    <col />
			    </colgroup>
			    <caption>프로그램 관리</caption>
		    	<tr>
					<th scope="row">생성</th>
					<td>
						{{form.reg_dt|myDate:'yyyy-MM-dd'}} {{form.reg_nm}}({{form.reg_id}})
					</td>
				</tr>
		    	<tr>
					<th scope="row">프로그램명</th>
					<td>
						<input type="text" class="normal w175" data-ng-model="form.program_nm"  required="required"/>
					</td>
				</tr>
				<tr>
					<th scope="row">URL</th>
					<td>
						<input type="text" class="normal" style="width:50%;" data-ng-model="form.url"  required="required"/>
					</td>
				</tr>
				<tr>
					<th scope="row">관리URL</th>
					<td>
						<input type="text" class="normal" style="width:50%;" data-ng-model="form.manage_url" />
					</td>
				</tr>
		    </table>
		    
		   	<table class="type1" style="margin-top:20px;">
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
				<tr data-ng-if="menuList.length==0">
					<td colspan="4" class="center">연결된 메뉴가 없습니다.</td>
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
					<input type="button" value="저장" class="bt_big_bt4" data-ng-click="save()"/>
					<input type="button" value="취소" class="bt_big_bt3" data-ng-click="list()"/>
		        </div>
		    </div>
		    
			</form>
		</div>
