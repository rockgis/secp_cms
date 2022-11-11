<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="contents_wrap">
	<div class="ct_wrap">
		<div class="conwrap_tap">
			<ul>
				<li id='contManagerTab' ng-if="param.permit=='Y'"><a href="<c:url value="/super/homepage/modifyFrm.do"/>?cms_menu_seq={{param.cms_menu_seq}}&amp;parent_menu_seq={{param.parent_menu_seq }}&amp;permit={{param.permit}}"><span>메뉴관리</span></a></li>
				<li class="on"><a href="${context_path }{{MANAGE_URL}}?cms_menu_seq={{param.cms_menu_seq}}&amp;parent_menu_seq={{param.parent_menu_seq}}&amp;permit={{param.permit}}" target="_self"><span>프로그램관리</span></a></li>
			</ul>
		</div>
		<div class="contents">
			<form name="searchFrm" method="post" data-ng-submit="board.go(1)">
				<table class="type1" style="margin-top:0;">
					<colgroup>
						<col width="200px" />
						<col width="" />
					</colgroup>
					<tr>
						<th>검색구분</th>
						<td>
							<select data-ng-model="param.condition" id="condition" class="normal w175">
								<option value="A.REG_DT">갱신일</option>
							</select>
						</td>
					</tr>
					<tr>
						<th>검색어</th>
						<td>
							<input type="text" class="normal w175" data-ng-model="param.keyword"/>
						</td>
					</tr>
					<tr>
						<th colspan="2" style="text-align:center; padding-left:0px; padding-right:0px;">
							<a class="bt_big_bt5" data-ng-click="board.go(1)">검색</a>
						</th>
					</tr>
				</table>
				<div style="overflow:hidden; margin-top:35px;">
					<div class="left_box_cms">
						<span class="board_listing">TOTAL : <span><b>{{board.totalCount|number}}</b></span> 건 </span><span style="font-size:12px;">(<b>{{board.currentPage|number}}</b> / {{board.totalPage|number}} page)</span>
					</div>
					<div class="right_box_cms">
						<select class="normal w100" title="건별보기 선택" data-ng-model="param.rows" data-ng-change="board.go(1)" data-ng-init="param.rows = '10'">
							<option value="10">10건씩보기</option>
							<option value="15">15건씩보기</option>
							<option value="20">20건씩보기</option>
						</select> 
					</div>
				</div>
			</form>
			<table class="type1" id="boardList">
				<colgroup>
					<col width="5%"/>
					<col width="*"/>
					<col width="20%" />
					<col width="20%" />
	        	</colgroup>
				<tr>
					<th class="center">번호</th>
					<th class="center">갱신일</th>
					<th class="center">등록자</th>
					<th class="center">관리</th>
				</tr>
				<tr data-ng-if="board.list.length==0"><td colspan="4" class="center">결과가 없습니다.</td></tr>
				<tr data-ng-repeat="item in board.list">
					<td class="center">{{(board.totalCount|num) + 1 - (item.rn|num)}}</td>
					<td class="left"><a data-my-href="/modify/{{item.seq}}">{{item.reg_dt|myDate:'yyyy/MM/dd'}}</a></td>
					<td class="center">{{item.reg_nm}}</td>
					<td class="center">
		          		<button value="수정" class="bt_small modify" data-my-href="/modify/{{item.seq}}">수정</button>
		          		<button value="삭제" class="bt_small delete" data-ng-click="del(item)" >삭제</button>
					</td>
				</tr>
			</table>
			<pagination total-page="board.totalPage" current-page="board.currentPage" on-select-page="board.go(page)"></pagination>
			<div class="btn_bottom">
				<div class="r_btn">
					<input type="button" value="등록" class="bt_big_bt4" data-my-href="/write"/>
	        	</div>
			</div>
		</div>
	</div>
		
	<div id="topBar">
    	<div class="topBar_inner">
			<bookmark userid="${sessionScope.cms_member.member_id }"></bookmark>
		</div>
		<span class="optBtn"><a href="javascript:void(0)"><img src="/images/cms/opt_close.gif" alt=""></a></span>
    </div>
</div>
