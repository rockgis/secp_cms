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
		    	<caption>공휴일 관리</caption>
				<tr>
					<th scope="row">공휴일이름</th>
					<td>
						<input type="text" class="normal w175" data-ng-model="form.title" required="required"/>
					</td>
				</tr>
		    	<tr>
					<th scope="row">공휴일날짜</th>
					<td>
						<input type="text" class="normal w175" style="margin-right:3px;" data-ng-model="form.holiday" datetimepicker required/>
					</td>
				</tr>
				<tr>
					<th scope="row">음력</th>
					<td>
						<input type="text" class="normal w175" style="margin-right:3px;" data-ng-model="form.lunar_cal" datetimepicker/>
					</td>
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
