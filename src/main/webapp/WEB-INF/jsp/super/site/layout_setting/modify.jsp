<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
		<div class="contents" data-ng-cloak>
			<form id="wFrm" name="wFrm" method="post" novalidate="novalidate">
		    <table class="type1" style="margin-top:0;">
			    <colgroup>
				    <col width="200px" />
				    <col width="*" />
			    </colgroup>
		    	<caption>레이아웃구성</caption>
		    	<tr>
					<th>콤포넌트 추가</th>
					<td>
					  	<input type="button" value="추가" class="btalls" data-ng-click="openComponent();">
					</td>
				</tr>
		    	<tr>
					<th>레이아웃설정</th>
					<td>
					  <div shapeshift ng-model="form.items"></div>
					</td>
				</tr>
		    </table>
		    
		    <div class="btn_bottom">
		    	<div class="r_btn">
					<input type="button" value="저장" class="bt_big_bt4" data-ng-click="save()"/>
		        </div>
		    </div>
		    
			</form>
		</div>
