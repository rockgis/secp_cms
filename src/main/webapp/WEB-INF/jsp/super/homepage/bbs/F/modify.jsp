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
    	<input type="hidden" data-ng-model="form.width" name="width" value="{{form.width}}"/>
    	<input type="hidden" data-ng-model="form.height" name="height" value="{{form.height}}"/>
	    <table class="type1" style="margin-top:0;">
		    <colgroup>
	        	<col width="200px" />
	        	<col width="*" />
	        </colgroup>
        	<!-- <tr data-ng-repeat="cols in custom" data-ng-if="cols.column_name != 'reg_dt' && cols.column_name != 'ip' && cols.column_name != 'view_cnt' && cols.column_name != 'reg_id' && cols.column_name != 'thumb' && cols.column_name != 'rn'"> -->
	        <tr data-ng-repeat="cols in custom" >
				<!-- <th data-ng-if="cols.column_name != 'notice_yn' && cols.column_name != 'cat_nm'">{{cols.element}}</th> -->
				<!-- <th data-ng-if="cols.column_name == 'cat_nm' && catlist.length > 0">{{cols.element}}</th> -->
				<th data-ng-if="cols.column_name != 'thumb'">{{cols.element}}</th>
				
				<td data-ng-if="cols.column_name == 'title'">
					<input type="text" class="normal" style="width:100%" data-ng-model="form.title" required data-ng-if="cols.column_name == 'title'"/>
					<!-- <span data-ng-repeat="sub_cols in custom" data-ng-if="sub_cols.column_name == 'notice_yn'"><input type="radio" data-ng-model="form.notice_yn" value="N"/>일반 / <input type="radio" data-ng-model="form.notice_yn" value="Y"/>공지</span> -->
				</td>
				<td data-ng-if="cols.column_name == 'notice_yn'">
					<ol class="select">
		        		<li><label><input type="radio" data-ng-model="form.notice_yn" value="N"/> 일반</label></li>
		        		<li><label><input type="radio" data-ng-model="form.notice_yn" value="Y"/> 공지</label></li>			        		
		        		<li><label data-ng-if="form.public_yn=='N' && form.reg_id=='unknown'"><input type="text" class="normal" style="width:120px" data-ng-model="form.password" required/></label></li>
		        	</ol>
				</td>
				<td data-ng-if="cols.column_name == 'public_yn'">
					<ol class="select">
		        		<li><label><input type="radio" data-ng-model="form.public_yn" value="Y"/> 공개</label></li>
		        		<li><label><input type="radio" data-ng-model="form.public_yn" value="N"/> 비공개</label></li>			        		
		        		<li><label data-ng-if="form.public_yn=='N' && form.reg_id=='unknown'"><input type="text" class="normal" style="width:120px" data-ng-model="form.password" required/></label></li>
		        	</ol>
				</td>
				
				<td data-ng-if="cols.column_name == 'sdate'"><input type="text" class="normal w175" data-ng-model="form.sdate" datetimepicker required/></td>
	
				<td data-ng-if="cols.column_name == 'edate'"><input type="text" class="normal w175" data-ng-model="form.edate" datetimepicker required/></td>
				
				<td data-ng-if="cols.column_name == 'password'"><input type="password" class="normal w175" data-ng-model="form.password" autocomplete="off"/></td>
				
				<td data-ng-if="cols.column_name == 'cat_nm' && catlist.length > 0">
					<select class="normal w175" data-ng-model="form.cat" data-ng-options="item.board_cat_seq as item.cat_nm for item in catlist" required></select>
				</td>
				
				<td data-ng-if="cols.column_name == 'tel'">
					<select class="normal" style="width:60px;" data-ng-model="form.tel1" data-ng-options="item.code as item.code for item in tellist" required></select> - <input type="text" class="normal w100" data-ng-model="form.tel2" data-ng-maxlength="4" maxlength="4" required/> - <input type="text" class="normal w100" data-ng-model="form.tel3" data-ng-maxlength="4" maxlength="4" required/>
				</td>
				
				<td data-ng-if="cols.column_name == 'cell'">
					<select class="normal" style="width:60px;" data-ng-model="form.cell1" data-ng-options="item.code as item.code for item in celllist" required></select> - <input type="text" class="normal w100" style="width:35px;" data-ng-model="form.cell2" data-ng-maxlength="4" maxlength="4" required/> - <input type="text" class="normal w100" style="width:35px;" data-ng-model="form.cell3" data-ng-maxlength="4" maxlength="4" required/>
				</td>
				
				<td data-ng-if="cols.column_name == 'email'">
					<input type="text" class="normal w100" data-ng-model="form.email1" required/> @ <input type="text" class="normal w100" data-ng-model="form.email2" data-ng-change="form.email2_select = form.email2" required/> <select class="normal w100" data-ng-model="form.email2_select" data-ng-options="item.code as item.code_nm for item in emaillist" data-ng-change="form.email2 = form.email2_select"><option value="">직접입력</option></select>
				</td>
	            
				<td data-ng-if="cols.column_name == 'conts'">
					<textarea style="width:100%;" data-ng-model="form.conts" required global-editor></textarea>
					<!--<textarea style="width:100%;" data-ng-model="form.conts" required ng-if="param.editor_yn!='Y'"></textarea>-->
				</td>
	          
				
				
				<!-- 위에서 개별처리된 항목들 
					title, conts, cat_nm, sdate, edate, notice_yn, public_yn, tell, cell, email, password, thumb
				-->
				<td data-ng-if="cols.column_name != 'title' && cols.column_name != 'conts' && cols.column_name != 'cat_nm' && cols.column_name != 'sdate' && cols.column_name != 'edate' && cols.column_name != 'notice_yn' && cols.column_name != 'public_yn' && cols.column_name != 'tel' && cols.column_name != 'cell' && cols.column_name != 'email' && cols.column_name != 'password' && cols.column_name != 'thumb'">
					<input type="text" class="normal w175 readonly" data-ng-model="form[cols.column_name]" data-ng-disabled="cols.col_edit == 'N'"/>
				</td>
	          
			</tr>
	        
	        <tr data-ng-if="form.thumb_yn == 'Y'">
	        	<th>썸네일이미지 </th>
		        <td>
		        	<span>※ 썸네일 이미지는 리스트페이지에 보여지는 이미지를 등록 할 수 있습니다.<br>(썸네일 이미지를 등록하지 않으면 내용에 등록된 첫번째 이미지가 자동으로 보여집니다.)</span>
					<input type="file" name="thumbfile" id="thumbfile" onchange="angular.element(this).scope().uploadThumbFile()"/>
		        		<div  class="tddiv" id="attach_div" data-ng-if="form.thumb != null"><img ng-src="{{form.thumb}}" style="width:{{form.width}}px;height:{{form.height}}px;"/>  <a data-ng-click="form.thumb = null"><img src="<c:url value="/images/super/contents/s_btn_1.gif"/>" alt="삭제" style="vertical-align:bottom;"/></a></div>
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