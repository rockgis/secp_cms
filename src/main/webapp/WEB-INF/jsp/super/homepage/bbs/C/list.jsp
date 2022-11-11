<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="/WEB-INF/tlds/StringUtil_fn.tld" prefix="suf" %>
<div class="contents_wrap">
	<div class="ct_wrap">
		<div class="conwrap_tap">
			<ul>
				<c:choose>
					<c:when test="${suf:inArray(fn:split('1,2', ','), sessionScope.cms_member.group_seq)}">
						<li id='contManagerTab'><a href="<c:url value="/super/homepage/modifyFrm.do"/>?cms_menu_seq={{param.cms_menu_seq}}&amp;parent_menu_seq={{param.parent_menu_seq }}&amp;permit={{param.permit}}"><span>메뉴관리</span></a></li>
					</c:when>
					<c:otherwise>
						<li id='contManagerTab' data-ng-if="param.get_my_permission_page === param.cms_menu_seq"><a href="<c:url value="/super/homepage/modifyFrm.do"/>?cms_menu_seq={{param.cms_menu_seq}}&amp;parent_menu_seq={{param.parent_menu_seq }}&amp;permit={{param.permit}}"><span>메뉴관리</span></a></li>
					</c:otherwise>
				</c:choose>
				<li class="on"><a href="${context_path }/super/homepage/bbs/index.do?cms_menu_seq={{param.cms_menu_seq}}&amp;parent_menu_seq={{param.parent_menu_seq}}&amp;permit={{param.permit}}" target="_self"><span>게시물관리</span></a></li>
			</ul>
		</div>
		<div class="contents">
	    	<form name="searchFrm" method="post" data-ng-submit="board.go(1)">
	    	<div>
				<div>
					<span class="bt_all">
						<!-- <span data-ng-if="param.del_yn == null || param.del_yn == 'N'"><input type="button" value="삭제 게시물 관리" class="btall" data-ng-click="param.del_yn = 'Y';board.go(1);"/></span>
						<span data-ng-if="param.del_yn == 'Y'"><input type="button" value="일반 게시물 관리" class="btall" data-ng-click="param.del_yn = 'N';board.go(1);"/></span> -->
						<span data-ng-class="{active : param.del_yn == null || param.del_yn == 'N'}"><input type="button" value="일반 게시물 관리" data-ng-click="param.del_yn = 'N';param.gubun = '';board.go(1);"/></span>
						<span data-ng-class="{active : param.del_yn == 'Y'}"><input type="button" value="삭제 게시물 관리" data-ng-click="param.del_yn = 'Y';board.go(1);"/></span>
						<span data-ng-class="{active : param.gubun == 'B'}"><input type="button" value="예약 게시물 관리" data-ng-click="param.gubun = 'B';param.del_yn = '';board.go(1);"/></span>
					</span>
			    </div>
			    
			    <div data-ng-if="param.gubun != 'B'">   
			    
			    <table class="type1">
					<colgroup>
						<col width="200px" />
						<col width="" />
					</colgroup>
					<tr>
						<th>검색구분</th>
						<td>
							<select data-ng-model="param.condition" id="condition" class="normal w175">
								<option value="TITLE">제목</option>
								<option value="REG_NM">작성자</option>
								<option value="COMMENT_NM">댓글작성자</option>
								<option value="CONTS">내용</option>
								<option value="TAGNAME">태그</option>
							</select>
						</td>
					</tr>
					<tr ng-if="param.cat_yn=='Y'">
						<th>카테고리</th>
						<td>
							<select title="질문유형" class="normal w175" data-ng-model="param.cat" data-ng-options="item.board_cat_seq as item.cat_nm for item in catlist" data-ng-if="param.cat_yn == 'Y'">
								<option value="">전체</option>
							</select>
						</td>
					</tr>
					<tr>
						<th>상태</th>
						<td>
							<select title="상태값" class="normal w175" data-ng-model="param.state" data-ng-options="item.board_state_seq as item.state_nm for item in statelist">
								<option value="">전체</option>
							</select>
						</td>
					</tr>
					<tr>
						<th>작성기간</th>
						<td>
							<input type="text" class="normal w175" style="position:relative; z-index:100; margin-right:3px;" data-ng-model="param.start_dt" datetimepicker date_max_model="param.end_dt">
							<span>~</span> 
							<input type="text" class="normal w175" style="position:relative; z-index:100; margin-right:3px;" data-ng-model="param.end_dt" datetimepicker date_min_model="param.start_dt">
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
							<%-- <a data-ng-click="board.go(1)"><img src="<c:url value="/images/super/contents/s_btn_search.gif"/>" alt="검색" /></a> --%>
							<a class="bt_big_bt5" data-ng-click="board.go(1)">검색</a>
						</th>
					</tr>
				</table>
				
				<div style="overflow:hidden; margin-top:35px;">
					<div class="left_box_cms">
						<span class="board_listing">TOTAL : <span><b>{{board.totalCount|number}}</b></span> 건 </span><span style="font-size:12px;">(<b>{{board.currentPage|number}}</b> / {{board.totalPage|number}} page)</span>
					</div>
			        <div class="right_box_cms">
			        	<select class="normal w100" title="건별보기 선택" data-ng-model="param.rows">
							<option ng-value="10" selected="selected">10건씩보기</option>
							<option ng-value="15">15건씩보기</option>
							<option ng-value="20">20건씩보기</option>
						</select>
					</div>
				</div>
				
				</div><!-- param.gubun != 'B' -->
				
			</div>
			</form>
			
			<div data-ng-if="param.gubun != 'B'">
			<!-- 게시물관리 -->
			
			<table class="type1" id="boardList">
				<colgroup>
					<col width="5%" />
					<col width="5%"/>
					<col width="10%" data-ng-if="param.cat_yn == 'Y'"/>
					<col width="*" />
					<col width="10%" />
					<col width="8%" />
					<col width="8%" />
					<col width="8%" data-ng-if="param.file_yn == 'Y'"/>
					<col width="6%" />
					<col width="6%" />
	        	</colgroup>
				<tr>
					<th class="center"><input type="checkbox" data-ng-model="board.chk_all" value="on" data-ng-change="chk_all_btn()"/></th>
					<th class="center">번호</th>
					<th class="center" data-ng-if="param.cat_yn == 'Y'">질문유형</th>
					<th class="center">제목</th>
					<th class="center">진행단계</th>
					<th class="center">작성일</th>
					<th class="center">작성자</th>
					<th class="center" data-ng-if="param.file_yn == 'Y'">첨부파일</th>
					<th class="center">조회수</th>
					<th class="center">신고수</th>
				</tr>
				<tr data-ng-repeat="item in board.notice_list">
					<td class="center"><input type="checkbox" value="{{item.article_seq}}"/></td>
					<td class="center">
						<label>
							<img src="/images/super/notice.png" alt="공지"/>
						</label>
					</td>
					<td class="center" data-ng-if="param.cat_yn == 'Y'">{{item.cat_nm}}</td>
					<td class="left member_nm"><a data-my-href="/modify/{{param.board_type}}/{{item.article_seq}}">{{item.title}}<label data-ng-if="item.comment_cnt > '0'"> ({{item.comment_cnt }})</label><label data-ng-if="item.public_yn=='N'" style="margin-left: 5px;"><img src="/images/board/style01_mp.gif" alt="비공개"></label></a></td>
					<td class="center">{{item.state_nm}}</td>
					<td class="center">{{item.reg_dt|myDate:'yyyy/MM/dd'}}</td>
					<td class="center">{{item.reg_nm}}</td>
					<td class="center" data-ng-if="param.file_yn == 'Y'">{{item.attach_cnt}}</td>
					<td class="center">{{item.view_cnt}}</td>
					<td class="center">{{item.report_cnt}}</td>
				</tr>
				<tr data-ng-if="board.list.length==0"><td colspan="{{(param.cat_yn == 'Y')?9:8}}" class="center">결과가 없습니다.</td></tr>
				<tr data-ng-repeat="item in board.list">
					<td class="center"><input type="checkbox" value="{{item.article_seq}}"/></td>
					<td class="center">
						<label>
							{{(board.totalCount|num) + 1 - (item.rn|num)}}
						</label>
					</td>
					<td class="center" data-ng-if="param.cat_yn == 'Y'">{{item.cat_nm}}</td>
					<td class="left member_nm"><a data-my-href="/modify/{{param.board_type}}/{{item.article_seq}}">{{item.title}}<label data-ng-if="item.comment_cnt > '0'"> ({{item.comment_cnt }})</label><label data-ng-if="item.public_yn=='N'" style="margin-left: 5px;"><img src="/images/board/style01_mp.gif" alt="비공개"></label></a></td>
					<td class="center">{{item.state_nm}}</td>
					<td class="center">{{item.reg_dt|myDate:'yyyy/MM/dd'}}</td>
					<td class="center">{{item.reg_nm}}</td>
					<td class="center" data-ng-if="param.file_yn == 'Y'">{{item.attach_cnt}}</td>
					<td class="center">{{item.view_cnt}}</td>
					<td class="center">{{item.report_cnt}}</td>
				</tr>
			</table>
			<pagination total-page="board.totalPage" current-page="board.currentPage" on-select-page="board.go(page)"></pagination>
			<div class="btn_bottom">
				<div class="r_btn" style="float:left;" data-ng-if="param.del_yn == 'N' || param.del_yn == null">
					<!-- <input type="button" value="등록" class="bt_big_bt4" data-my-href="/write/{{param.board_type}}"/> -->
					<input type="button" value="선택복사" class="bt_big_bt2" data-ng-click="copy();"/>
					<input type="button" value="선택이동" class="bt_big_bt2" data-ng-click="move();"/>
					<input type="button" value="선택삭제" class="bt_big_bt3" data-ng-click="deletes()"/>
	        	</div>
	        	<div class="r_btn" style="float:right;" data-ng-if="param.del_yn == 'N' || param.del_yn == null">
					<input type="button" value="등록" class="bt_big_bt4" data-my-href="/write/{{param.board_type}}"/>
	        	</div>
				<div class="r_btn" data-ng-if="param.del_yn == 'Y'">
					<input type="button" value="선택완전삭제" class="bt_big_bt3" data-ng-click="db_delete();"/>
					<input type="button" value="선택복구" class="bt_big_bt4" data-ng-click="restore()"/>
	        	</div>
			</div>
			
			</div><!-- param.gubun != 'B'  -->
			
			<div data-ng-if="param.gubun == 'B'">
			<!-- 예약 게시물 관리 -->

		    <table class="type1">
				<colgroup>
					<col width="200px" />
					<col width="" />
				</colgroup>
				<tr>
					<th>검색구분</th>
					<td>
						<select title="검색조건 선택" class="normal w175" data-ng-model="param.condition" data-ng-init="param.condition='title'">
			            	<option value="title">메뉴명</option>
			            	<option value="reg_nm">등록자</option>
			          	</select> 
					</td>
				</tr>
				<tr>
					<th>일자</th>
					<td>
						<select data-ng-model="param.date_type" class="normal w175" style="margin-right:5px;" ng-init="param.date_type='1'">
			            	<option value="1">업데이트예정일</option>
			            	<option value="2">등록일</option>
			          	</select> 
						<input type="text" class="normal w175" style="position:relative; z-index:100; margin-right:3px;" data-ng-model="param.start_dt" datetimepicker date_max_model="param.end_dt">
						<span>~</span> 
						<input type="text" class="normal w175" style="position:relative; z-index:100; margin-right:3px;" data-ng-model="param.end_dt" datetimepicker date_min_model="param.start_dt">
					</td>
				</tr>
				<tr>
					<th>상태</th>
					<td>
						<ol class="select">
							<li class="first"><label><input type="radio" data-ng-model="form.status_type" data-ng-init="form.status_type='1'" value="1"/> 전체</label></li>
							<li><label><input type="radio" data-ng-model="form.status_type" value="2" /> 성공</label></li>
							<li><label><input type="radio" data-ng-model="form.status_type" value="3" /> 실패</label></li>
							<li><label><input type="radio" data-ng-model="form.status_type" value="4" /> 취소</label></li>
							<li><label><input type="radio" data-ng-model="form.status_type" value="5" /> 예약</label></li>
						</ol>
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
		          	<select class="normal w100" data-ng-model="param.rows" data-ng-init="param.rows='10'">
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
		          	<col width="6%" />
		          	<col width="*" />
		          	<col width="10%" />
		          	<col width="10%" />
		          	<col width="8%" />
		          	<col width="8%" />
		          	<col width="8%" />
		          	<col width="8%" />
		        </colgroup>
		        <tr>
		            <th class="center">번호</th>
		            <th class="center">메뉴명</th>
		            <th class="center">등록자</th>
		            <th class="center">예약일</th>
		            <th class="center">등록일</th>
		            <th class="center">상태</th>
		            <th class="center">비고</th>
		            <th class="center">삭제</th>
		        </tr>
	          	<tr data-ng-if="board.list.length==0"><td colspan="8" class="center">결과가 없습니다.</td></tr>
	          	<tr data-ng-repeat="item in board.list">
	          		<td class="center">{{(board.totalCount|num) + 1 - (item.rn|num)}}</td>
		            <td class="left member_nm pointcolor">{{item.title}}</td>
		            <td class="center">{{item.reg_nm}}</td>
		            <td class="center">{{item.reserve_dt|myDate:'yyyy-MM-dd HH:mm'}}</td>
		            <td class="center">{{item.reg_dt|myDate:'yyyy-MM-dd'}}</td>
		            <td class="center">{{item.result}}</td>
		            <td class="center">
						<a class="btalls ng-binding" data-ng-click="blankUrl(item.menu_url)">페이지 바로가기</a>
					</td>
		            <td class="center">
						<a class="btalls ng-binding" data-ng-click="del(item)">삭제</a>
	            	</td>
	          	</tr>
	        </table>
	        
	        <pagination total-page="board.totalPage" current-page="board.currentPage" on-select-page="board.go(page)"></pagination>
        	
        	</div><!-- param.gubun == 'B' -->
			
		</div>
		
	</div>
		
	<div id="topBar">
    	<div class="topBar_inner">
			<bookmark userid="${sessionScope.cms_member.member_id }"></bookmark>
		</div>
		<span class="optBtn"><a href="javascript:void(0)"><img src="/images/cms/opt_close.gif" alt=""></a></span>
    </div>
	
</div>