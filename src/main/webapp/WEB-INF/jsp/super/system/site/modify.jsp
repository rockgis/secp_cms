<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
		<div class="contents" data-ng-cloak>
			<form id="wFrm" name="wFrm" method="post" novalidate="novalidate">
		    <table class="type1">
			    <colgroup>
			    	<col style="width:200px;" />
			    	<col width="*" />
			    </colgroup>
		    	<caption>공휴일 관리</caption>
		    	<tr>
					<th scope="row">사이트명</th>
					<td>
						<input type="text" class="normal w200" data-ng-model="form.title" required="required" />
					</td>
				</tr>
				<tr>
					<th scope="row">사이트URL</th>
					<td>
						<input type="text" class="normal w200" data-ng-model="form.sub_path" required="required" /> &nbsp;<b>/path</b> 같은 형식으로 입력해주세요.
					</td>
				</tr>
				<tr>
					<th scope="row">사이트 관리자</th>
					<td>
						<div class="layout_g2">
							<span style="display:inline-block; float:left; margin:4px 7px 0 0; font-size:12px;">해당 사이트의 담당자를 지정할 수 있습니다.</span>
						    <input type="button" value="담당자 선택" class="btalls" data-ng-click="openStaffSelect(form)">
						</div>
						<div class="layout_g1" ng-show="form.staff_list.length>0">
						    <span ui-sortable="staffSortable" data-ng-model="form.staff_list">
								<span data-ng-repeat="item in form.staff_list">{{item.group_nm}} {{item.member_nm}}
									<a data-ng-click="removeStaff($index)"><img src="${context_path }/images/container/btn_del2_03.png" class="btn"></a>
								</span>
							</span>
						</div>
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
