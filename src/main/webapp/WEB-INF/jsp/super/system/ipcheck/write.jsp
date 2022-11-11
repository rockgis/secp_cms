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
			    <caption>접근권한IP관리</caption>
		    	<tr>
					<th scope="row">IP번호</th>
					<td>
						<span style="display:block; margin:0 0 5px 0; font-size:12px;">0.0.0.0이나 0.0.0.* 처럼 대역으로 지정 가능 합니다.</span>
						<input type="text" class="normal w175" data-ng-model="form.ip" required="required" data-ng-pattern="/([0-9]{1,3})\.([0-9]{1,3})\.([0-9]{1,3}|\*)\.([0-9]{1,3}|\*)/"/>
					</td>
				</tr>
				<tr>
					<th scope="row">사용자 및 사용처</th>
					<td>
						<span style="display:block; margin:0 0 5px 0; font-size:12px;">IP를 사용하는 담당자 성함이나 업체명을 작성하세요.</span>
						<input type="text" class="normal w175" data-ng-model="form.title" required="required"/>
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
