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
				<th scope="row">검색어</th>
				<td>
					<select title="검색조건 선택" class="normal w100" data-ng-model="param.condition" data-ng-init="param.condition='title'">
			            <option value="title">호스트명</option>
			            <option value="host">host주소</option>
			            <option value="auth_id">관리아이디</option>
			        </select>
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
		  		<li><input type="button" value="전송관리" class="btall" data-my-href="/list"></li>
		  		<li><input type="button" value="그룹관리" class="btall" data-my-href="/target_list"></li>
		  		<li><input type="button" value="내용관리" class="btall" data-my-href="/form_list"></li>
		  		<li><input type="button" value="호스트관리" class="btall_on" data-my-href="/smtp_list"></li>
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
	          	<col />
	          	<col style="width:120px;" />
	          	<col style="width:140px;" />
	          	<col style="width:140px;" />
	          	<col style="width:90px;" />
	          	<col style="width:200px;" />
          	</colgroup>
          	<tr>
	            <th scope="col" class="center">번호</th>
	            <th scope="col" class="center">호스트 명칭</th>
	            <th scope="col" class="center">SMTP HOST</th>
	            <th scope="col" class="center">SMTP PORT</th>
	            <th scope="col" class="center">관리아이디</th>
	            <th scope="col" class="center">테스트</th>
	            <th scope="col" class="center">관리</th>
          	</tr>
          	<tr data-ng-if="board.list.length==0">
          		<td colspan="8" class="center">결과가 없습니다.</td>
          	</tr>
          	<tr data-ng-repeat="item in board.list">
	            <td class="center">{{(board.totalCount|num) + 1 - (item.rn|num)}}</td>
	            <td class="left member_nm pointcolor">{{item.title}}</td>
	            <td class="center">{{item.host}}</td>
	            <td class="center">{{item.port}}</td>
	            <td class="center">{{item.auth_id}}</td>
	            <td class="center">
	            	<input type="button" value="테스트" class="btalls" data-ng-click="test(item)">
	            </td>
	            <td class="center">
	            	<button value="수정" class="bt_small modify" data-my-href="/smtp_modify/{{item.seq}}">수정</button>
	            	<button value="삭제" class="bt_small delete" data-ng-click="del(item)">삭제</button>
	            </td>
          	</tr>
        </table>
	    <pagination total-page="board.totalPage" current-page="board.currentPage" on-select-page="board.go(page)"></pagination>
			
		<div class="btn_bottom">
	    	<div class="r_btn">
	        	<input type="button" value="등록" class="bt_big_bt4" data-my-href="/smtp_write"/>
	        </div>
	    </div>
	</div>
