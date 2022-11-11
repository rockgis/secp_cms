<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<div class="contents" data-ng-init="board.go(1)" data-ng-cloak>
		<form name="searchFrm" method="post" data-ng-submit="board.go(1)">
		<table class="type1" style="margin-top:0;">
			<colgroup>
				<col style="width:200px;" />
				<col />
			</colgroup>
			<tr>
				<th scope="row">제목검색</th>
				<td>
					<input type="text" class="normal w175" data-ng-model="param.keyword"/>
				</td>
			</tr>
			<tr>
				<th scope="row" colspan="2" style="text-align:center; padding-left:0px; padding-right:0px;">
					<%-- <a data-ng-click="board.go(1)"><img src="<c:url value="/images/super/contents/s_btn_search.gif"/>" alt="검색" /></a> --%>
					<a class="bt_big_bt5" data-ng-click="board.go(1)">검색</a>
				</th>
			</tr>
		</table>
		</form>
		
		<div class="cms_tab" style="margin-top:35px; margin-bottom:0; height:33px;">
		  	<ul>
		  		<li><input type="button" value="전송관리" class="btall_on" data-my-href="/list"></li>
		  		<li><input type="button" value="그룹관리" class="btall" data-my-href="/target_list"></li>
		  		<li><input type="button" value="내용관리" class="btall" data-my-href="/form_list"></li>
		  		<li><input type="button" value="호스트관리" class="btall" data-my-href="/smtp_list"></li>
		  	</ul>
        </div>
	
		<div style="overflow:hidden;">
	      	<div class="left_box_cms">
	      		<span class="board_listing">TOTAL : <span><b>{{board.totalCount|number}}</b></span> 건 </span><span style="font-size:12px;">(<b>{{board.currentPage|number}}</b> / {{board.totalPage|number}} page)</span>
	        </div>
	        <div class="right_box_cms">
	          	<select class="normal w100" data-ng-model="param.rows" data-ng-init="param.rows='10'" data-ng-change="board.go(1)">
		            <option value="10">10건씩보기</option>
		            <option value="20">20건씩보기</option>
		            <option value="30">30건씩보기</option>
		            <option value="50">50건씩보기</option>
		            <option value="100">100건씩보기</option>
	          	</select>
	        </div>
		</div>
		<table class="type1">
          	<colgroup>
	          	<col style="width:60px;" />
	          	<col style="width:90px;" />
	          	<col />
	          	<col style="width:60px;" />
	          	<col style="width:250px;" />
	          	<col style="width:150px;" />
	          	<col style="width:120px;" />
	          	<col style="width:200px;" />
	          	<col style="width:200px;" />
          	</colgroup>
          	<tr>
	            <th scope="col" class="center">번호</th>
	            <th scope="col" class="center">구분</th>
	            <th scope="col" class="center">제목</th>
	            <th scope="col" class="center">수신자</th>
	            <th scope="col" class="center">발송자</th>
	            <th scope="col" class="center">등록폼</th>
	            <th scope="col" class="center">상태</th>
	            <th scope="col" class="center">상세보기</th>
	            <th scope="col" class="center">관리</th>
          	</tr>
          	<tr data-ng-if="board.list.length==0"><td colspan="9" class="center">결과가 없습니다.</td></tr>
          	<tr data-ng-repeat="item in board.list">
	            <td class="center">{{(board.totalCount|num) + 1 - (item.rn|num)}}</td>
	            <td class="center">{{item.target_nm}}</td>
	            <td class="left member_nm">{{item.title}}</td>
	            <td class="center">{{item.target_cnt}} 명</td>
	            <td class="center">{{item.sender_nm}}({{item.sender_mail}})</td>
	            <td class="center">{{item.form_title}}</td>
	            <td class="center">
		            <div ng-switch on="item.status">		           		
		            	<div ng-switch-when="N"><button value="발송하기" class="bt_small mail" data-ng-click="send_mail(item)">발송하기</div>
		            	<div ng-switch-when="S" style="color:#4ea9f6; font-weight:600;">발신성공</div>
		            	<div ng-switch-when="P">발신대기</div>
		            	<div ng-switch-when="F" style="color:#e86561; font-weight:600;">실패</div>
		            </div>
	            </td>
	            <td class="center">
	            	<button value="상세보기" class="bt_small view" data-ng-click="open_mail_queue(item)">보기</button>
		            <button value="그룹갱신" class="bt_small modify" data-ng-click="update_mail_queue(item)" ng-if="item.status=='N'">그룹갱신</button>
	            </td>
	            <td class="center">
		            <span ng-switch on="item.status">
		            	<button value="수정" class="bt_small modify" ng-switch-when="N" data-my-href="/modify/{{item.seq}}">수정</button>
	            	</span>
	            	<button value="삭제" class="bt_small delete" data-ng-click="del(item)">삭제</button>
	            </td>
          	</tr>
        </table>
        <pagination total-page="board.totalPage" current-page="board.currentPage" on-select-page="board.go(page)"></pagination>
		
		<div class="btn_bottom">
	    	<div class="r_btn">
				<input type="button" value="메일 작성하기" class="bt_big_bt4" data-my-href="/write"/>
	        </div>
	    </div>
	</div>
