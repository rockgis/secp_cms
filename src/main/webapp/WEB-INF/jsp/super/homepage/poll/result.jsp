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
	          <td>{{form.title}}</td>
	        </tr>
	        <tr>
	          <th>설문 내용</th>
	          <td ng-bind-html="bindHTML(form.content)"></td>
	        </tr>
	        <tr>
	          <th>기간<br/>(<font color="blue">{{form.stat}}</font>)</th>
	          <td>{{form.start_dt}} ~ {{form.end_dt}}</td>
	        </tr>
			<tr>
				<th>설문 참여 그룹</th>
				<td>
					<span style="display:block; padding:5px 0 0 0; margin:0px;">
						<span style="display:block;height:20px;" data-ng-repeat="item in form.groups">{{item.group_nm}}</span>
					</span>
				</td>
			</tr>
			<tr data-ng-repeat="item in form.question">
				<th data-ng-if="item.subject_yn == 'Y'" colspan="2">
					{{item.question}}
					<pre style="font-weight:normal;padding-left:20px;" data-ng-if="item.question_content != null && item.question_content != ''">{{item.question_content}}</pre>
				</th>
				<th data-ng-if="item.subject_yn == 'N'">
					{{item.cnt}}번 설문
				</th>
				<td data-ng-if="item.subject_yn == 'N'">
					<ul id="questionWrap" class="question">
						<li>
							<div class="q_wrap" style="border-top:solid 1px #ddd;">
								<p>질문</p>
								<div>{{item.question}}</div>
							</div>
							<div class="q_wrap">
								<p>내용</p>
								<div>{{item.question_content}}</div>
							</div>
						</li>
						<li data-ng-repeat="sub_item in item.answers" data-ng-if="item.subject_yn == 'N'">
							<div class="q_wrap">
								<p style="padding:0 10px 0 9px;">항목명</p>
								<div class="q_result">{{$index+1}}. {{sub_item.answer}}
									<span style="float:right; color:#ff7a1a;" data-ng-if="item.question_type != 'C'">(결과 : {{sub_item.cnt}} 표 / {{sub_item.percent}})</span>
									<span data-ng-if="(item.question_type == 'E' && sub_item.jump_chk == 'Y') || item.question_type == 'C'"><input type="button" value="결과확인" class="btalls" data-ng-click="result_textarea(sub_item);" /></span>
								</div>
							</div>
							
						</li>
					</ul>
				</td>
			</tr>		
	      </table>
		  <div class="btn_bottom">
	        <div class="r_btn">
	          <span class="bt_all"><span><input type="button" value="엑셀다운" class="btall" data-ng-click="excel_down(form)"/></span></span>
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
<script type="text/ng-template" id="resultDetail.html">
	<div class="subjective_question" data-ng-controller="resultDetailCtrl">
		<div class="sq_wrap" data-ng-repeat="item in model">
			<p>
				{{$index+1}}. {{item.reg_nm}}
			</p>
			<div ng-bind-html="answerText(item.answer);">
			</div>
		</div>
	</div>
</script>