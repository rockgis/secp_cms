<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
		
	<div class="member_top" id="listCtrlDiv"  ng-controller="listCtrl" >
		<form name="searchFrm"method="post" data-ng-submit="board.go(1)">
		<table class="type1" style="margin-top:0;">
			<colgroup>
				<col style="width:200px;" />
				<col />
			</colgroup>
			<tr>
				<th scope="row">그룹</th>
				<td>
		           	<select title="그룹 검색" class="normal w175" data-ng-model="param.group_seq" data-ng-options="item.group_seq as item.group_nm for item in main.dept">
		        		<option value="">전체</option>
		           	</select>
				</td>
			</tr>
			<!-- 
			<tr>
				<th scope="row">E-mail수신 여부</th>
				<td>
					<ol class="select">
						<li class="first"><label><input type="radio" data-ng-model="param.email_yn" value=""/> 전체</label></li>
						<li><label><input type="radio" data-ng-model="param.email_yn" value="Y"/> 수신</label></li>
						<li><label><input type="radio" data-ng-model="param.email_yn" value="N"/> 미수신</label></li>
					</ol>
				</td>
			</tr>
			<tr>
				<th scope="row">SMS수신 여부</th>
				<td>
					<ol class="select">
						<li class="first"><label><input type="radio" data-ng-model="param.sms_yn" value=""/> 전체</label></li>
						<li><label><input type="radio" data-ng-model="param.sms_yn" value="Y"/> 수신</label></li>
						<li><label><input type="radio" data-ng-model="param.sms_yn" value="N"/> 미수신</label></li>
					</ol>
				</td>
			</tr>
			 -->
			<tr>
				<th scope="row">계정정지</th>
				<td>
					<ol class="select">
						<li><label><input type="radio" data-ng-model="param.block_yn" value=""/> 전체</label></li>
						<li><label><input type="radio" data-ng-model="param.block_yn" value="Y" /> 잠김</label></li>
						<li><label><input type="radio" data-ng-model="param.block_yn" value="N" /> 해제</label></li>
					</ol>
				</td>
			</tr>
			<tr>
				<th scope="row">장기미사용자 여부</th>
				<td>
					<ol class="select">
						<li class="first"><label><input type="radio" data-ng-model="param.dormancy_yn" value=""/> 전체</label></li>
						<li><label><input type="radio" data-ng-model="param.dormancy_yn" value="Y"/> 휴면계정</label></li>
						<li><label><input type="radio" data-ng-model="param.dormancy_yn" value="N"/> 비휴면계정</label></li>
					</ol>
				</td>
			</tr>
			<tr>
				<th scope="row">검색어</th>
				<td>
					<select title="회원 검색조건 선택" class="normal w100" data-ng-model="param.condition">
			         	<option value="member_nm">이름</option>
			           	<option value="member_id">아이디</option>
			        </select> 
					<input type="text" class="normal w175"  data-ng-model="param.keyword"/>
				</td>
			</tr>
			<tr>
				<th scope="row" colspan="2" style="text-align:center; padding-left:0px; padding-right:0px;">
					<%-- <a data-ng-click="board.go(1)"><img src="<c:url value="/images/super/contents/s_btn_search.gif"/>" alt="검색" /></a> --%>
					<a class="bt_big_bt5" data-ng-click="board.go(1)">검색</a>
				</th>
			</tr>
		</table>
		
		<div style="overflow:hidden; margin-top:35px;">
			<div class="left_box_cms" style="margin-top:0;">
				<div class="word_box">
			      	<ul style="overflow:hidden;">
			      		<li><a ng-class="{on : param.shoseong==''}" data-ng-click="board.choseong('', $event)">전체</a></li>
			      		<li><a ng-class="{on : param.shoseong=='ㄱ'}" data-ng-click="board.choseong('ㄱ', $event)">ㄱ</a></li>
			      		<li><a ng-class="{on : param.shoseong=='ㄴ'}" data-ng-click="board.choseong('ㄴ', $event)">ㄴ</a></li>
			      		<li><a ng-class="{on : param.shoseong=='ㄷ'}" data-ng-click="board.choseong('ㄷ', $event)">ㄷ</a></li>
			      		<li><a ng-class="{on : param.shoseong=='ㄹ'}" data-ng-click="board.choseong('ㄹ', $event)">ㄹ</a></li>
			      		<li><a ng-class="{on : param.shoseong=='ㅁ'}" data-ng-click="board.choseong('ㅁ', $event)">ㅁ</a></li>
			      		<li><a ng-class="{on : param.shoseong=='ㅂ'}" data-ng-click="board.choseong('ㅂ', $event)">ㅂ</a></li>
			      		<li><a ng-class="{on : param.shoseong=='ㅅ'}" data-ng-click="board.choseong('ㅅ', $event)">ㅅ</a></li>
			      		<li><a ng-class="{on : param.shoseong=='ㅇ'}" data-ng-click="board.choseong('ㅇ', $event)">ㅇ</a></li>
			      		<li><a ng-class="{on : param.shoseong=='ㅈ'}" data-ng-click="board.choseong('ㅈ', $event)">ㅈ</a></li>
			      		<li><a ng-class="{on : param.shoseong=='ㅊ'}" data-ng-click="board.choseong('ㅊ', $event)">ㅊ</a></li>
			      		<li><a ng-class="{on : param.shoseong=='ㅋ'}" data-ng-click="board.choseong('ㅋ', $event)">ㅋ</a></li>
			      		<li><a ng-class="{on : param.shoseong=='ㅌ'}" data-ng-click="board.choseong('ㅌ', $event)">ㅌ</a></li>
			      		<li><a ng-class="{on : param.shoseong=='ㅍ'}" data-ng-click="board.choseong('ㅍ', $event)">ㅍ</a></li>
			      		<li><a ng-class="{on : param.shoseong=='ㅎ'}" data-ng-click="board.choseong('ㅎ', $event)">ㅎ</a></li>
			      		<li><a ng-class="{on : param.shoseong=='A'}" data-ng-click="board.choseong('A', $event)">A~Z</a></li>
			      		<li><a ng-class="{on : param.shoseong=='0'}" data-ng-click="board.choseong('0', $event)">0~9</a></li>
			      	</ul>
		      	</div>
			</div>
		    <div class="right_box_cms">
				<span class="board_listing">TOTAL : <span><b>{{board.totalCount|number}}</b></span> 명 </span><span style="margin-right:6px; font-size:12px;">(<b>{{board.currentPage|number}}</b> / {{board.totalPage|number}} page)</span>
		       	<select class="normal w100" data-ng-model="param.rows" data-ng-change="board.go(1)">
		            <option value="10">10건씩보기</option>
		            <option value="20">20건씩보기</option>
		            <option value="30">30건씩보기</option>
		            <option value="50">50건씩보기</option>
		            <option value="100">100건씩보기</option>
		        </select>
			</div>
		</div>
		</form>
	</div>
	
	<div class="group_intro">
		<h4>{{data.view.group_nm}}</h4>
		<ul>
			<li ng-if="param.group_seq>'2'">담당업무 : {{data.view.responsibilities}}</li>
			<li ng-if="param.group_seq=='1'">담당그룹 : 시스템 전체 설정을 할 수 있습니다.(모든 기능이 활성화 되어 있어 계정 발급시 유의하세요.)</li>
			<li ng-if="param.group_seq=='2'">담당그룹 : 시스템관리를 제외한 전체 설정을 할 수 있습니다.</li>
			<li ng-if="param.group_seq>'2'">담당그룹 : 지정받은 사이트의 메뉴관리만 가능합니다. <button value="정보수정" class="bt_small modify" data-ng-click="openGroupMod(data.view, 'p');">변경</button></li><!-- 슈퍼관리자가 아닌경우 가지고 있는 권한 표시 -->
			<div class="layout_g1" ng-show="data.staff_list.length>0">
			    <span ui-sortable="staffSortable" data-ng-model="data.staff_list">
					<span data-ng-repeat="item in data.staff_list">{{item.title}}</span>
				</span>
			</div>
		</ul>
	</div>
	
	<table id="board_div" class="type1">
		<colgroup>
			<col style="width:50px;" />
			<col style="width:130px;" />
			<%-- 
			<col style="width:100px;" />
			 --%>
			<col />
			<col style="width:150px;" />
			<col style="width:150px;" />
			<%-- <col width="20%" /> --%>
			<col style="width:150px;" />
			<col style="width:150px;" />
			<col style="width:200px;" />
		</colgroup>
		<thead>
			<tr>
				<th scope="col" class="center"><input type="checkbox" data-ng-model="board.chk_all" value="on" data-ng-change="chk_all_btn()"/></th>
				<th scope="col" class="center" data-ng-click="board.sort('member_nm', $event)"><div class="arrow_box">아이디<span class="up_arrow"></span><span class="down_arrow"></span></div></th>
				<!-- 
				<th class="center" data-ng-click="board.sort('group_nm', $event)"><div class="arrow_box">그룹<span class="up_arrow"></span><span class="down_arrow"></span></div></th>
				 -->
                <th scope="col" class="center" data-ng-click="board.sort('member_nm', $event)"><div class="arrow_box">이름<span class="up_arrow"></span><span class="down_arrow"></span></div></th>
				<th scope="col" class="center" data-ng-click="board.sort('cell', $event)"><div class="arrow_box">휴대폰<span class="up_arrow"></span><span class="down_arrow"></span></div></th>
				<!-- <th scope="col" class="center">비밀번호</th> -->
				<th scope="col" class="center">담당/권한</th>
				<th scope="col" class="center">장기미접속(휴면)</th>
				<th scope="col" class="center">계정정지</th>
				<th scope="col" class="center">관리</th>
			</tr>
		</thead>
		<tbody id="listWrap">
			<tr data-ng-if="board.list.length==0"><td colspan="8" class="center">결과가 없습니다.</td></tr>
			<tr data-ng-repeat="item in board.list">
				<td class="center"><input type="checkbox" value="{{item.member_id}}"/></td>
				<td class="center">{{item.member_id}}</td>
				<!-- 
				<td class="center">{{item.group_nm}}</td>
				 -->
				<td class="left member_nm" member_id="{{item.member_id}}"><a href="" style="cursor:default;">{{item.member_nm}}</a></td>
				<td class="center">{{item.cell}}</td>
				<!-- 
				<td class="center">
					<button value="초기화" class="bt_small refresh" data-ng-click="init_pw(item)">초기화</button>
					<button value="변경" class="bt_small modify" style="margin-left:3px;" data-ng-click="modify_pw(item)">변경</button>
				</td>
				 -->
				<td class="center">
					<div ng-if="item.group_seq>'2'"><button value="페이지담당설정" class="bt_small page" data-ng-click="openModMember(item, 'p')">페이지 담당설정</button></div>
					<div ng-if="item.group_seq>'2'" style="margin-top:4px;"><button value="페이지권한설정" class="bt_small page2" data-ng-click="openModMember(item, 'a')">페이지 권한설정</button></div>
					<div ng-if="item.group_seq <='2'" style="margin-top:4px;">-</div>
				</td>
				<td class="center">
					<span data-ng-if="item.dormancy_yn == 'Y'">
						{{item.last_login|myDate:('yyyy-MM-dd HH:mm:ss')}}<br />
						<button value="휴면해지" class="bt_small sleep" data-ng-click="memberWakeup(item)">휴면해지</button>
					</span>
				</td>
				<td class="center">
					<span data-ng-if="item.block_yn == 'Y'">
						{{item.last_login|myDate:('yyyy-MM-dd HH:mm:ss')}}<br />
						<button value="잠금해제" class="bt_small lock" data-ng-click="init_block(item)">잠금해제</button>
					</span>
				</td>
				<td class="center">
					<div>
						<button value="로그보기" class="bt_small log" data-ng-click="memberHistory(item)">로그보기</button>
					</div>
					<div style="margin-top:4px;">
						<button value="수정" class="bt_small modify" data-ng-click="openModMember(item)">수정</button>
						<button value="삭제" class="bt_small delete" data-ng-click="del(item)">삭제</button>
					</div>
				</td>
		</tbody>
	</table>
	
	<pagination total-page="board.totalPage" current-page="board.currentPage" on-select-page="board.go(page)"></pagination>
			
	<div class="btn_bottom" id="btn_bottom">
    	<div class="r_btn">
          <input type="button" value="생성" class="bt_big_bt4" data-ng-click="openAddMember()"/>
          <input type="button" value="정렬하기" class="bt_big_bt2" data-ng-click="openSortMember()"/>
          <input type="button" value="부서이동" class="bt_big_bt2" data-ng-click="openMoveMemberGroup()"/>
        </div>
    </div>