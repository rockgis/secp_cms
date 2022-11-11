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
			        <th>공지 <b class="essential">*</b></th>
			        <td>
			        	<ol class="select">
			        		<li><label><input type="radio" data-ng-model="form.notice_yn" value="N" /> 일반</label></li>
			        		<li><label><input type="radio" data-ng-model="form.notice_yn" value="Y" /> 공지</label></li>			        		
			        	</ol>
			        </td>
			    </tr>
	        	<tr data-ng-if="param.public_yn == 'N'">
			        <th>비밀글</th>
			        <td>
			        	<ol class="select">
			        		<li><label><input type="radio" data-ng-model="form.public_yn" value="Y" /> 공개</label></li>
			        		<li><label><input type="radio" data-ng-model="form.public_yn" value="N" /> 비공개</label></li>
			        		<li><label data-ng-if="form.public_yn=='N' && form.reg_id=='unknown'"><input type="text" class="normal" style="width:120px" data-ng-model="form.password" required/></label></li>
			        	</ol>
			        </td>
			    </tr>
			    <tr data-ng-if="param.cat_yn == 'Y'">
	          		<th>질문유형</th>
	          		<td>
	            		<select class="normal w175" data-ng-model="form.cat" data-ng-options="item.board_cat_seq as item.cat_nm for item in catlist" required>
	            		</select>
	          		</td>
	        	</tr>
	        	<tr>
	          		<th>상태</th>
	          		<td>
	            		<select class="normal w175" data-ng-model="form.state" data-ng-options="item.board_state_seq as item.state_nm for item in statelist" required>
	            		</select>
	          		</td>
	        	</tr>
	        	<tr>
	          		<th>질문내용 <b class="essential">*</b></th>
	          		<td>
						<textarea style="width:100%;" data-ng-model="form.conts" required global-editor ng-if="param.editor_yn=='Y'"></textarea>
						<textarea style="width:100%;" data-ng-model="form.conts" required ng-if="param.editor_yn!='Y'"></textarea>
	          		</td>
	        	</tr>
	        	<tr>
	          		<th>답변내용 <b class="essential">*</b></th>
	          		<td>
						<textarea style="width:100%;" data-ng-model="form.reply_conts" required global-editor></textarea>
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
	        	
		        <tr data-ng-if="param.cclnuri_yn == 'C' || param.cclnuri_yn == 'A' ">
					<th>CCL</th>
					<td>
						<ol class="select ccl_nuri">
							<li><label><input type="radio" data-ng-model="form.ccl_type" value="" ng-init="form.ccl_type=(form.ccl_type||'')"/><span alt="" style="display:block; padding:6px 33px; color:#fff; background:#abb1aa; border-radius:3px; border:solid 1px #999;">없 음</span></label></li>
							<li><label><input type="radio" data-ng-model="form.ccl_type" value="1" /><img src="/images/container/ccl_1.png" alt="" style="display:block;" /></label></li>
							<li><label><input type="radio" data-ng-model="form.ccl_type" value="2" /><img src="/images/container/ccl_2.png" alt="" style="display:block;" /></label></li>
							<li><label><input type="radio" data-ng-model="form.ccl_type" value="3" /><img src="/images/container/ccl_3.png" alt="" style="display:block;" /></label></li>
							<li><label><input type="radio" data-ng-model="form.ccl_type" value="4" /><img src="/images/container/ccl_4.png" alt="" style="display:block;" /></label></li>
							<li><label><input type="radio" data-ng-model="form.ccl_type" value="5" /><img src="/images/container/ccl_5.png" alt="" style="display:block;" /></label></li>
							<li><label><input type="radio" data-ng-model="form.ccl_type" value="6" /><img src="/images/container/ccl_6.png" alt="" style="display:block;" /></label></li>
						</ol>
						<div style="margin-top:5px; color:#ff7a1a; font-family:NanumBarunGothicB;">
							<div ng-show="form.ccl_type==''">라이선스를 적용하지 않습니다.</div>
							<div ng-show="form.ccl_type=='1'">저작자표시 4.0 국제</div>
							<div ng-show="form.ccl_type=='2'">저작자표시-변경금지 4.0 국제</div>
							<div ng-show="form.ccl_type=='3'">저작자표시-동일조건변경허락 4.0 국제</div>
							<div ng-show="form.ccl_type=='4'">저작자표시-비영리 4.0 국제</div>
							<div ng-show="form.ccl_type=='5'">저작자표시-비영리-변경금지 4.0 국제</div>
							<div ng-show="form.ccl_type=='6'">저작자표시-비영리-동일조건변경허락 4.0 국제</div>
						</div>
					</td>
				</tr>
				<tr data-ng-if="param.cclnuri_yn == 'P' || param.cclnuri_yn == 'A' ">
					<th>공공누리</th>
					<td>
						<ol class="select ccl_nuri">
							<li><label><input type="radio" data-ng-model="form.nuri_type" value="" ng-init="form.nuri_type=(form.nuri_type||'')"/><span alt="" style="display:block; padding:6px 33px; color:#fff; background:#abb1aa; border-radius:3px; border:solid 1px #999;">없 음</span></label></li>
							<li><label><input type="radio" data-ng-model="form.nuri_type" value="1" /><img src="/images/container/nuri_1.png" alt="" style="display:block;" /></label></li>
							<li><label><input type="radio" data-ng-model="form.nuri_type" value="2" /><img src="/images/container/nuri_2.png" alt="" style="display:block;" /></label></li>
							<li><label><input type="radio" data-ng-model="form.nuri_type" value="3" /><img src="/images/container/nuri_3.png" alt="" style="display:block;" /></label></li>
							<li><label><input type="radio" data-ng-model="form.nuri_type" value="4" /><img src="/images/container/nuri_4.png" alt="" style="display:block;" /></label></li>
						</ol>
						<div style="margin-top:5px; color:#ff7a1a; font-family:NanumBarunGothicB;">
							<div ng-show="form.nuri_type==''">라이선스를 적용하지 않습니다.</div>
							<div ng-show="form.nuri_type=='1'">출처표시 / 상업적, 비상업적 이용가능 / 변형 등 2차적 저작물 작성 가능</div>
							<div ng-show="form.nuri_type=='2'">출처표시 / 비상업적 이용만 가능 / 변형 등 2차적 저작물 작성 가능</div>
							<div ng-show="form.nuri_type=='3'">출처표시 / 상업적, 비상업적 이용가능 / 변형 등 2차적 저작물 작성금지</div>
							<div ng-show="form.nuri_type=='4'">출처표시 / 비상업적 이용만 가능 / 변형 등 2차적 저작물 작성 금지</div>
						</div>
					</td>
				</tr>
				<tr data-ng-if="param.tag_yn == 'Y'">
					<th>태그</th>
					<td>
						<input type="text" class="normal" style="width:100%;" ng-model="form.tag_names" tagnames/>
						<p style="margin-top:5px;color:#555; letter-spacing:-1px;">※ 태그 작성시 , 로 구분 해야 합니다.</p>
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
					<col width="8%" />
					<col width="13%" />
				</colgroup>
				<tr>
					<th class="center">신고내용</th>
					<th class="center">작성자</th>
					<th class="center">신고일자</th>
				</tr>
				<tr data-ng-repeat="item in form.reports">
					<td>{{item.reportconts}}</td>
					<td class="center">{{item.reg_nm}}</td>
					<td class="center">{{item.reg_dt}}${item.reg_dt}</td>
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