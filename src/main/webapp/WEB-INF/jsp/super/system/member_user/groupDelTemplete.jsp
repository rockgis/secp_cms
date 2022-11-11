<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<div ng-controller="groupDelCtrl" title="그룹삭제">
		<p style="overflow:hidden; margin-top:10px;">
			<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>
			그룹을 삭제하면서 회원도 같이 삭제 하려면 '예'를<br/>
			그룹을 삭제하면서 회원을 다른 그룹으로 이동시키려면 '아니오'를 선택하시기 바랍니다.
		</p>
		
		<div>
			<div class="r_btn" style="position:absolute; bottom:15px; right:15px;">
				<span class="bt_all">
					<span><input type="button" value="예" class="btall" data-ng-click="yes()"/></span>
				</span> 
				<span class="bt_all">
					<span><input type="button" value="아니오" class="btall" data-ng-click="no()"/></span>
				</span> 
				<span class="bt_all">
					<span><input type="button" value="취소" class="btall" data-ng-click="cancel()"/></span>
				</span> 
			</div>
		</div>
	</div>