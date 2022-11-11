<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec"  uri="http://www.springframework.org/security/tags" %>
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
	    <form id="wFrm" name="frm" method="post" novalidate="novalidate" enctype="multipart/form-data">
<sec:csrfInput />
			<p><b class="essential">*</b> 표시는 필수 입력 입니다.</p>
	      	<table class="type1" style="margin-top:0;">
	        	<colgroup>
	          		<col width="200px" />
	          		<col width="*" />
	        	</colgroup>
	        	<tr>
	          		<th>작성자</th>
	          		<td>{{form.reg_nm }}</td>
	        	</tr>
	        	<tr>
	          		<th>제목 <b class="essential">*</b></th>
	          		<td><input type="text" class="normal" style="width:100%" data-ng-model="form.title" required/></td>
	        	</tr>
	        	<tr>
			        <th>공지</th>
			        <td>
			        	<ol class="select">
			        		<li><label><input type="radio" data-ng-model="form.notice_yn" value="N" /> 일반</label></li>
			        		<li><label><input type="radio" data-ng-model="form.notice_yn" value="Y" /> 공지</label></li>			        		
			        	</ol>
			        </td>
			    </tr>
	        	<tr data-ng-if="param.cat_yn == 'Y'">
	          		<th>카테고리</th>
	          		<td>
	            		<select class="normal w125" data-ng-model="form.cat" data-ng-options="item.board_cat_seq as item.cat_nm for item in catlist" required>
	            		</select>
	          		</td>
	        	</tr>
	        	<tr>
	          		<th>내용 <b class="essential">*</b></th>
	          		<td>
						<textarea style="width:100%;" data-ng-model="form.conts" required global-editor></textarea>
						<!-- <textarea style="width:100%;" data-ng-model="form.conts" required ng-if="param.editor_yn!='Y'"></textarea> -->
	          		</td>
	        	</tr>
	        	<tr data-ng-if="param.file_yn == 'Y'">
	          		<th rowspan="2">첨부파일 </th>
	          		<td><input type="file" name="file" id="file" onchange="angular.element(this).scope().uploadFile()"/></td>
	        	</tr>
	        	<tr data-ng-if="param.file_yn == 'Y'"> 
	          		<td class="tddiv" id="attach_div">
		          		<div data-ng-repeat="item in form.files">
		          			<p style="margin-top: 3px;"><a data-ng-href="<c:url value="/download.do"/>?uuid={{item.uuid}}">{{item.attach_nm}}</a> <a data-ng-click="removeFile($index)"><img src="<c:url value="/images/super/contents/s_btn_1.gif"/>" alt="삭제" /></a></p>
		          		</div>
		      		</td>
	        	</tr>
	      	</table>
		  	<div class="btn_bottom">
		        <div class="r_btn" data-ng-if="param.del_yn == 'N'">
	          		<input type="button" value="수정" class="bt_big_bt4" data-ng-click="save()"/>
	          		<input type="button" value="삭제" class="bt_big_bt3" data-ng-click="del()"/>
		        	<input type="button" value="복사" class="bt_big_bt2" data-ng-click="copyView(form.article_seq)"/>
	          		<input type="button" value="목록" class="bt_big_bt2" data-ng-click="list()"/>
	        	</div>
	        	<div class="r_btn" data-ng-if="param.del_yn == 'Y'">
	          		<input type="button" value="완전삭제" class="bt_big_bt3" data-ng-click="db_delete_one(form.article_seq)"/>
	          		<input type="button" value="복원" class="bt_big_bt4" data-ng-click="restore_one(form.article_seq)"/>
	          		<input type="button" value="목록" class="bt_big_bt2" data-ng-click="list()"/>
	        	</div>
	      	</div>
		</form> 
		
		<comments data-ng-if="param.comment_yn=='Y'" cms_menu_seq="form.cms_menu_seq" article_seq="form.article_seq"/>
		<div style="margin-top:40px;">
			<p class="siren">신고내역</p>
			<table class="type1">
				<caption></caption>
				<colgroup>
					<col width="*" />
					<col width="12%" />
				</colgroup>
				<tr>
					<th class="center">신고내용</th>
					<th class="center">신고일자</th>
				</tr>
				<tr>
					<td>ㄱㄷㅇ</td>
					<td class="center">2017-05-18</td>
				</tr>
			</table>
		
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