<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="contents" data-ng-cloak>
	<div scrollable style="float:left;width:300px; height:570px;background:#f8f8f8;">
		<div id="filetree">
		</div>
	</div>
	<div style="float:left;margin-left:30px;width:800px; height:40px;background:#f8f8f8;">
		<div class="tfilelist">
			<table>
				<colgroup>
					<col width="*">
					<col width="10%">
					<col width="15%">
					<col width="25%">
				</colgroup>
				<thead>
					<tr>
						<th style="text-align:left;">이름</th>
						<th>크기</th>
						<th>종류</th>
						<th>수정한날짜</th>
					</tr>
				</thead>
			</table>
		</div>
	</div>
	
	<div scrollable style="float:left;margin-left:30px;width:800px; height:530px;">
		<div id="filelist">
			<table>
				<colgroup>
					<col width="*">
					<col width="10%">
					<col width="15%">
					<col width="25%">
				</colgroup>
				<tbody>
					<tr data-ng-repeat="item in file_list">
						<td>
							<a data-ng-if="item.use_child=='Y'" ng-click="getFileList(item.path)">
							<img src="{{item.icon}}" /> {{item.text}}
							</a>
							<a data-ng-if="item.use_child!='Y'" ng-click="openFileModify(item.path)">
							<img src="{{item.icon}}" /> {{item.text}}
							</a>
						</td>
						<td class="center">{{item.size}}</td>
						<td class="center">{{item.gubun}}</td>
						<td class="center">{{item.mod_dt}}</td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
	<div class="btn_bottom" style="float: left;width: 1130px;">
    	<div class="r_btn">
			<input type="button" value="파일추가" class="bt_big_bt4" ng-click="openUploadForm();">
        </div>
    </div>
</div>
