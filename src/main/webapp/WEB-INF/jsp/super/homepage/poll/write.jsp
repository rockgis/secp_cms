<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="contents_wrap">
	<div class="ct_wrap">
		<div class="conwrap_tap">
			<ul>
				<li id='contManagerTab' ng-if="param.permit=='Y'"><a href="<c:url value="/super/homepage/modifyFrm.do"/>?cms_menu_seq={{param.cms_menu_seq}}&amp;parent_menu_seq={{param.parent_menu_seq }}&amp;permit={{param.permit}}"><span>메뉴관리</span></a></li>
				<li class="on"><a href="javascript:;"><span>프로그램관리</span></a></li>
			</ul>
		</div>
	    <div class="contents">
	    <form id="wFrm" name="frm" method="post" novalidate="novalidate" enctype="multipart/form-data">
	      	<table class="type1" style="margin-top:0;">
	        	<colgroup>
	          		<col width="200px" />
	          		<col width="*" />
	        	</colgroup>
	        	<tr>
	          		<th>설문 제목</th>
	          		<td><input type="text" class="normal" style="width:100%" data-ng-model="form.title" required/></td>
	        	</tr>
		        <tr>
		          	<th>설문 내용</th>
		          	<td>
						<textarea style="width:100%;" id="conts" data-ng-model="form.content" required global-editor></textarea>
		          	</td>
		        </tr>
		        <tr>
		          	<th>기간</th>
		          	<td>
		          		<input type="text" class="normal w175" style="position:relative; z-index:100; margin-right:3px;" data-ng-model="form.start_dt" datetimepicker required/>
		          		<span>~</span> 
		          		<input type="text" class="normal w175" style="position:relative; z-index:100; margin-right:3px;" data-ng-model="form.end_dt" datetimepicker required/>
		          	</td>
		        </tr>
		        <tr>
				  	<th>중복설문여부</th>
				  	<td>
						<ol class="select" style="line-height:25px;">
							<li class="first"><label><input type="radio" data-ng-model="form.dup_yn" value="Y" data-ng-init="form.dup_yn = 'N'"/> 사용</label></li>
							<li><label><input type="radio" data-ng-model="form.dup_yn" value="N" /> 사용안함</label></li>
						</ol>
				  	</td>
				</tr>
		        <tr>
				  	<th>사용여부</th>
				  	<td>
						<ol class="select" style="line-height:25px;">
							<li class="first"><label><input type="radio" data-ng-model="form.use_yn" value="Y" data-ng-init="form.use_yn = 'Y'"/> 사용</label></li>
							<li><label><input type="radio" data-ng-model="form.use_yn" value="N" /> 사용안함</label></li>
						</ol>
				  	</td>
				</tr>
				<tr>
					<th>설문 참여 권한</th>
					<td>
						<span style="display:inline-block; float:left; margin:4px 7px 0 0; font-size:12px;">해당 메뉴의 등록수정권한 지정 선택입니다.</span>
						<input type="button" value="그룹 선택" class="btalls" data-ng-click="openGroupSelect()">
						<span style="display:block;height:20px;" data-ng-repeat="item in form.groups">{{item.group_nm}}
							<a data-ng-click="removeGroup($index)"><img src="<c:url value="/images/container/btn_del.png"/>" class="btn"></a>
						</span>
					</td>
				</tr>
				<tr>
					<th>개인정보 포함여부</th>
					<td>
						<ol class="select" style="line-height:25px;">
							<li class="first"><label><input type="radio" data-ng-model="form.lot_yn" value="Y" data-ng-init="form.lot_yn = 'N'"/> 사용</label></li>
							<li><label><input type="radio" data-ng-model="form.lot_yn" value="N" /> 사용안함</label></li>
							<li><span style="color:#ff7a1a;">설문조사 완료 후 추첨을 통한 이벤트 진행시 사용</span></li>
						</ol>
					</td>
				</tr>
				<tr>
					<th>설문관리</th>
					<td>
						<input type="button" value="설문추가" class="btalls" data-ng-click="addQuestion('N')" />
						<input type="button" value="소제목 추가" class="btalls" data-ng-click="addQuestion('Y')" />
					</td>
				</tr>
				<tr data-ng-repeat="item in form.question">
					<th>
						<div data-ng-if="item.subject_yn == 'N'">
							{{item.cnt}}번 설문
							<span style="margin-left:3px;"><input type="button" value="설문삭제" class="btalls" data-ng-click="removeQuestion($index, 'N');" /></span><br/>
							<input type="checkbox" data-ng-model="item.required_yn"  data-ng-true-value="'Y'" data-ng-false-value="'N'"/> 필수여부
						</div>
						<div data-ng-if="item.subject_yn == 'Y'">
							소제목<span style="margin-left:3px;"><input type="button" value="소제목삭제" class="btalls" data-ng-click="removeQuestion($index, 'Y');" /></span>
						</div>
					</th>
					<td>
						<ul id="questionWrap" class="question">
							<li data-ng-if="item.subject_yn == 'Y'">
								<div class="q_wrap" style="border-top:solid 1px #ddd;">
									<p style="padding:0 10px 0 9px;">소제목</p>
									<div>
										<input type="text" class="normal" data-ng-model="item.question" style="width:100%;" required>
									</div>
								</div>
								<div class="q_wrap">
									<p>내용</p>
									<div>
										<textarea rows="" cols="" data-ng-model="item.question_content" style="width:100%; height:100px;"></textarea>
									</div>
								</div>
							</li>
							<li data-ng-if="item.subject_yn == 'N'">
								<div class="q_wrap" style="border-top:solid 1px #ddd;">
									<p>질문</p>
									<div>
										<select class="normal w100" style="margin-bottom:10px;" data-ng-model="item.question_type" data-ng-change="changeType($index);">						
											<option value="A">단일선택</option>
											<option value="B">중복선택</option>
											<option value="C">주관식</option>
											<option value="D">비활성화형</option>
											<option value="E">혼합형</option>
										</select>
										<span data-ng-if="item.question_type == 'B'">선택 가능 개수 : <input type="text" class="normal" data-ng-model="item.required_count" style="width:50px;" required> 개</span>
										<select data-ng-if="item.question_type == 'B'" class="normal w100" style="margin-bottom:10px;" data-ng-model="item.required_count_controll">						
											<option value="U">이상 선택</option>
											<option value="D">이하 선택</option>
											<option value="E">동일 선택</option>
										</select>
										<span data-ng-if="item.question_type == 'B'" style="color:#ff7a1a;">선택 개수에 0 입력시 이상, 이하, 동일 제한이 없습니다. ( 해당 기능은 필수 문항일때만 적용됩니다.)</span>
										<br />
										<input type="text" class="normal" data-ng-model="item.question" style="width:100%;" required><br />
									</div>
								</div>
								<div class="q_wrap">
									<p>내용</p>
									<div>
										<span data-ng-if="item.question_type != 'C'" style="display:block; margin-bottom:10px;"><input type="button" value="선택 항목 추가" class="btalls" data-ng-click="addAnswer(item);" /></span>
										<textarea rows="" cols="" data-ng-model="item.question_content" style="width:100%; height:100px;"></textarea>
									</div>
								</div>
							</li>
							<li data-ng-if="item.subject_yn == 'N'" data-ng-repeat="sub_item in item.answers">
								<div class="q_wrap" data-ng-if="item.question_type=='A' || item.question_type=='B'" >
									<p style="padding:0 10px 0 9px;">항목명</p>
									<div>
										<input type="text" data-ng-model="sub_item.answer" class="normal" style="width:50%;" required/>
										<span data-ng-if="$index > 0" style="margin-left:3px;"><input type="button" value="항목 삭제" class="btalls" data-ng-click="removeAnswer(item,$index)"/></span>
									</div>
								</div>
								<div class="q_wrap" data-ng-if="item.question_type=='C'" >
									<p style="padding:0 10px 0 9px;">항목명</p>
									<div>
										<input type="text" data-ng-model="sub_item.answer" class="normal" readonly="readonly" style="width:50%;" />
										<!-- <input type="checkbox" data-ng-model="sub_item.null_chk"  data-ng-true-value="'Y'" data-ng-false-value="N"/> 필수입력사항 --> 
									</div>
								</div>
								<div class="q_wrap" data-ng-if="item.question_type=='D' || item.question_type=='E'" >
									<p style="padding:0 10px 0 9px;">항목명</p>
									<div>
										<input type="text" data-ng-model="sub_item.answer" class="normal" style="width:50%;" required/>
										<input type="checkbox" data-ng-model="sub_item.jump_chk" data-ng-true-value="'Y'" data-ng-false-value="'N'"/>
										<span data-ng-if="item.question_type=='D'">다음 문항 비활성화</span>
										<span data-ng-if="item.question_type=='E'">항목 선택시 주관식</span>
										<span data-ng-if="$index > 0" style="margin-left:3px;"><input type="button" value="항목 삭제" class="btalls" data-ng-click="removeAnswer(item,$index)"/></span>
									</div>
								</div>
							</li>
						</ul>
					</td>
				</tr>		
	      	</table>
			<div class="btn_bottom">
	        	<div class="r_btn">
	          		<input type="button" value="등록" class="bt_big_bt4" data-ng-click="save()"/>
	         		<input type="button" value="목록" class="bt_big_bt2" data-ng-click="list()"/>
	        	</div>
	    	</div>
		</form>
	    </div>
	</div>
		
	<div id="topBar">
    	<div class="topBar_inner">
			<bookmark userid="${sessionScope.cms_member.member_id }"></bookmark>
		</div>
		<span class="optBtn"><a href="javascript:void(0)"><img src="/images/cms/opt_close.gif" alt=""></a></span>
    </div>
</div>
  
<script type="text/ng-template" id="groupSelectTemplete.html">
	<div ng-controller="groupSelectCtrl" title="그룹선택">
		<div class="nav nav_style_1" scrollable="scrollOption">
			<div class="dept_container" >
			<ul class="list treeview2">
				<li>
					<span>그룹</span>
				</li>
			</ul>
			</div>
		</div>
	</div>
</script>