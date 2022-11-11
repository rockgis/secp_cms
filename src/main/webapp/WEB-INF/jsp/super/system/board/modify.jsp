<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	<div class="titlebar" data-ng-cloak>
		<h2>게시판 설정 및 관리</h2>
		<div>
			<span>시스템 관리</span>&gt; <span>시스템 설정 및 관리</span>&gt;
			<span class="bar_tx">게시판 설정 및 관리</span>
		</div>
	</div>
	<div class="contents_wrap">
		<div class="contents">
			<form id="wFrm" name="frm" method="post" novalidate="novalidate">
			<table class="type1" style="margin-top:0;">
				<caption>게시판을 수정하는 페이지입니다. 게시판명, 게시판타입, 글목록개수 설정, SNS 댓글사용, 글등록버튼사용, 글자수제한, 비밀글 사용, 저작권보호 사용, 해시태그 사용, 파일등록, 통합검색여부, 사용여부, 카테고리 사용의 옵션을 제공합니다.</caption>
				<colgroup>
				    <col style="width:200px;" />
				    <col />
				</colgroup>
				<tr>
					<th scope="row">게시판번호</th>
					<td>{{form.board_seq}}</td>
				</tr>
				<tr>
					<th scope="row">게시판명</th>
					<td><input type="text" class="normal w175" data-ng-model="form.board_nm" required/></td>
				</tr>
				<tr>
					<th scope="row">게시판타입</th>
					<td>
						<select class="normal w175" data-ng-model="form.board_type" data-ng-options="item.board_type as item.name for item in boardType" data-ng-change="stateAdd();">
						</select>
						<span style="margin-left:5px;"> 게시판 타입이 변경되면 연결된 메뉴에 게시판을 다시 선택해야 적용됩니다.</span>
					</td>
				</tr>
				<tr data-ng-if="form.board_type == 'B'">
			        <th scope="row">갤러리 타입</th>
			        <td>
				        <ol class="select">
					        <li class="first"><label><input type="radio" data-ng-model="form.thumb_type" value="T"/> 타일</label></li>
					        <li><label><input type="radio" data-ng-model="form.thumb_type" value="L"/> 리스트</label></li>
				        </ol>
			        </td>
			    </tr>
			    <tr>
			    	<th scope="row" rowspan="2">글목록개수 설정</th>
			    	<td>
				        <input type="text" class="normal w200" data-ng-model="form.rows_text" style="width:100%;" required placeholder="10,30,50,100" ng-blur="rows_array()"/>
				        <span style="margin-left:5px;">한 페이지에 보여줄 선택목록을 등록할 수 있습니다.(페이지 수 쉼표로 구분)</span>
			    	</td>
			    </tr>
			    <tr>
			    	<td>
				        <select class="normal w100" data-ng-model="form.list_row" data-ng-options="item as item for item in rowlist">
				        </select>
				        <span style="margin-left:5px;">초기에 보이는 목록 수를 지정할 수 있습니다.</span>
			    	</td>
			    </tr>
			    <tr>
			        <th scope="row">댓글사용</th>
			        <td style="overflow:hidden;">
				        <ol class="select" style="float:left; margin:6px 0;">
					        <li><label><input type="radio" data-ng-model="form.comment_yn" value="N" data-ng-disabled="form.board_type == 'E'"/> 사용안함</label></li>
					        <li class="first"><label><input type="radio" data-ng-model="form.comment_yn" value="Y" data-ng-disabled="form.board_type == 'E'"/> 사용</label></li>
				        </ol>
				        <div style="float:left;" data-ng-show="form.comment_yn=='Y'">
				        	<select class="normal" data-ng-model="form.comment_target" style="display:none;">
					        	<option value="U">회원</option>
					        	<option value="N">비회원</option>
					        </select>
					        <span style="margin-left:5px;">회원만 댓글을 이용할 수 있습니다.</span>
				        </div>
			        </td>
			    </tr>
			    <tr>
			        <th scope="row">글등록버튼사용</th>
			        <td style="overflow:hidden;">
				        <ol class="select" style="float:left; margin:6px 0;">
					        <li><label><input type="radio" data-ng-model="form.insert_yn" value="N" data-ng-disabled="form.board_type == 'E'"/> 사용안함</label></li>
					        <li class="first"><label><input type="radio" data-ng-model="form.insert_yn" value="Y" data-ng-disabled="form.board_type == 'E'"/> 사용</label></li>
				        </ol>
				        <div style="float:left;" data-ng-show="form.insert_yn=='Y'">
					        <span style="margin-right:5px;">에디터 사용 여부</span>
					        <select class="normal" name="" id="" data-ng-model="form.editor_yn" >
					        	<option value="Y">사용</option>
					        	<option value="N">미사용</option>
					        </select>				        
					    </div>
			        </td>
			    </tr>
			    <!-- 
			    <tr>
			    	<th scope="row">글자수제한</th>
			    	<td>
			    		<ol class="select" style="float:left; margin:6px 0;">
					        <li><label><input type="radio" data-ng-model="form.limit_yn" value="N" /> 사용안함</label></li>
					        <li class="first"><label><input type="radio" data-ng-model="form.limit_yn" value="Y" /> 사용</label></li>
				        </ol>
				        <div style="float:left;" data-ng-show="form.limit_yn=='Y'">
					        <input type="text" class="normal" style="width:50px !important;" /> 자
					    </div>
			    	</td>
			    </tr>
			     -->
			    <tr>
			        <th scope="row">비밀글 사용</th>
			        <td>
				        <ol class="select" >
					        <li><label><input type="radio" data-ng-model="form.public_yn" value="Y" data-ng-disabled="form.board_type == 'E'"/> 사용안함</label></li>
					        <li class="first"><label><input type="radio" data-ng-model="form.public_yn" value="N" data-ng-disabled="form.board_type == 'E'"/> 공개/비공개 사용</label></li>
					        <li class="first"><label><input type="radio" data-ng-model="form.public_yn" value="X" data-ng-disabled="form.board_type == 'E'"/> 비공개만 사용</label></li>
				        </ol>
			        </td>
			    </tr>
			    <tr>
			        <th scope="row">저작권보호 사용<br/>(CCL/공공누리)</th>
			        <td>
				        <ol class="select">
					        <li><label><input type="radio" data-ng-model="form.cclnuri_yn" value="N" data-ng-disabled="form.board_type == 'E'"/> 사용안함</label></li>
					        <li><label><input type="radio" data-ng-model="form.cclnuri_yn" value="C" data-ng-disabled="form.board_type == 'E'"/> CCL</label></li>
					        <li><label><input type="radio" data-ng-model="form.cclnuri_yn" value="P" data-ng-disabled="form.board_type == 'E'"/> 공공누리</label></li>
					        <li class="first"><label><input type="radio" data-ng-model="form.cclnuri_yn" value="A" data-ng-disabled="form.board_type == 'E'"/> 모두 사용</label></li>
				        </ol>
			        </td>
			    </tr>
			    <tr>
			        <th scope="row">해시태그 사용</th>
			        <td>
				        <ol class="select">
					        <li><label><input type="radio" data-ng-model="form.tag_yn" value="N" data-ng-disabled="form.board_type == 'E'"/> 사용안함</label></li>
					        <li class="first"><label><input type="radio" data-ng-model="form.tag_yn" value="Y" data-ng-disabled="form.board_type == 'E'"/> 사용</label></li>
				        </ol>
			        </td>
			    </tr>
			    
			    <tr id="agreeTr" style="display:none;">
			    	<th scope="row">사용자 등록허용</th>
			    	<td>
			    		<ol class="select">
				        	<li style="text-align:center;"><label><img style="display:block; margin:0 auto 5px auto;" src="/images/super/regi_permit_n.gif" /><input type="radio" data-ng-model="form.agree_yn" value="N" data-ng-change="useAgree();"/> 사용안함</label></li>
				        	<li style="text-align:center;"><label><img style="display:block; margin:0 auto 5px auto;" src="/images/super/regi_permit_y.gif" /><input type="radio" data-ng-model="form.agree_yn" value="Y" data-ng-change="useAgree();"/> 사용</label></li>
				        	<li style="margin:26px 0"><span style="display:inline-block; float:left; margin:4px 7px 0 0; font-size:12px;">(※ 사용자에게 개인정보를 수집하거나, 기타 약관에 대한 이해가 필요할 시 사용할 수 있습니다.)</span></li>
				        </ol>
				        <div class="regi_permit" data-ng-show="form.agree_yn=='Y'">
				        	<p class="rp_add"><span>최대 3개까지 추가 할 수 있습니다.</span><input type="button" class="btalls" data-ng-click="addAgree();" value="추가" /></p>
				        	
				        	<div class="rp_wrap" data-ng-repeat="item in form.user_agree">
				        		<p class="rp_number">{{item.agree_order}}<input type="button" class="btalls" style="display:block; margin:0 auto;" data-ng-click="removeAgree($index);" value="삭제" /></p>
				        		<div style="display:table-cell; padding:10px;">
				        			<input type="text" class="normal" name="user_agree_tit" data-ng-model="item.agree_tit" style="display:block; width:100%; margin-bottom:10px;" required />
				        			<textarea name="" id="" name="user_agree_cont" data-ng-model="item.agree_cont" style="overflow-y:scroll; width:100%; height:100px;" required global-editor></textarea>
				        			<div style="overflow:hidden; margin-top:5px;">
					        			<p style="float:left;">개인정보 수집 및 이용목적, 보유 및 이용기간 동의 여부</p>
					        			<ol class="select" style="float:left; margin-left:10px;">
					        				<li><label for=""><input type="radio" data-ng-model="item.agree_check" value="Y"/> 필수</label></li>
					        				<li><label for=""><input type="radio" data-ng-model="item.agree_check" value="N"/> 선택</label></li>
					        			</ol>
				        			</div>
				        		</div>
				        	</div>
				        </div>
			    	</td>
			    </tr>
				<tr>
					<th scope="row" rowspan="2">파일등록</th>
					<td style="overflow:hidden;">
						<ol class="select" style="float:left; margin:6px 0;">
							<li><label><input type="radio" data-ng-model="form.file_yn" value="N"/> 사용안함</label></li>
							<li class="first"><label><input type="radio" data-ng-model="form.file_yn" value="Y"/> 사용</label></li>
						</ol>
						<div style="float:left;">
							<label>
								<select class="normal" style="" data-ng-model="form.limit_file_size">
			                     	<option ng-repeat="item in [1, 100]|range:3" ng-value="($index + 1)">{{$index + 1}}M</option>
			                  	</select>
								<span> 파일업로드 용량제한</span>
							</label>
						</div>
					</td>
				</tr>
			    <tr>
			        <td>
				        <ol class="select">
					        <li class="first" style="line-height:24px;"><label><input type="radio" data-ng-model="form.file_limit" value="N" /> 무제한</label></li>
					        <li style="line-height:24px;"><label><input type="radio" data-ng-model="form.file_limit" value="1" data-ng-disabled="form.board_type == 'B'"/> 1</label></li>
					        <li style="line-height:24px;"><label><input type="radio" data-ng-model="form.file_limit" value="2" data-ng-disabled="form.board_type == 'B'"/> 2</label></li>
					        <li style="line-height:24px;"><label><input type="radio" data-ng-model="form.file_limit" value="3" data-ng-disabled="form.board_type == 'B'"/> 3</label></li>
					        <li style="line-height:24px;"><label><input type="radio" data-ng-model="form.file_limit" value="4" data-ng-disabled="form.board_type == 'B'"/> 4</label></li>
					        <li style="line-height:24px;"><label><input type="radio" data-ng-model="form.file_limit" value="5" data-ng-disabled="form.board_type == 'B'"/> 5</label></li>
				        </ol>
			        </td>
			    </tr>
		    
				<tr>
					<th scope="row">통합검색여부</th>
					<td>
						<ol class="select">
							<li><label><input type="radio" data-ng-model="form.search_yn" value="N"/> 사용안함</label></li>
							<li class="first"><label><input type="radio" data-ng-model="form.search_yn" value="Y" /> 사용</label></li>
						</ol>
					</td>
				</tr>
				<tr>
					<th scope="row">사용여부</th>
					<td>
						<ol class="select">
							<li><label><input type="radio" data-ng-model="form.use_yn" value="N"/> 사용안함</label></li>
							<li class="first"><label><input type="radio" data-ng-model="form.use_yn" value="Y" /> 사용</label></li>
						</ol>
					</td>
				</tr>
				<tr>
					<th scope="row">카테고리 사용</th>
					<td>
						<ol class="select">
							<li><label><input type="radio" data-ng-model="form.cat_yn" value="N" data-ng-change="catAdd();"/> 사용안함</label></li>
							<li class="first"><label><input type="radio" data-ng-model="form.cat_yn" value="Y"  data-ng-change="catAdd();"/> 사용</label></li>
						</ol>
					</td>
				</tr>
				<tr id="catTr" style="display:none;">
					<th scope="row">카테고리</th>
					<td id = "catTd">
						<input type="button" value="카테고리추가" data-ng-click="addCat();" class="btalls"/>
						<table class="type1">
							<colgroup>
							  	<col />
							  	<col style="width:110px;" />
						  	</colgroup>
							<thead>
								<tr>
									<th scope="col" class="center">카테고리명</th>
									<th scope="col" class="center">관리</th>
								</tr>
							</thead>
							<tbody id="catWrap">
								<tr data-ng-repeat="item in form.cat_size">
									<td class="member_nm left" style="padding-left:12px;">
										<input type="text" class="normal w200" data-ng-model="form.cat_nm[$index].cat_nm"/>
									</td>
									<td class="center">
										<input type="button" class="btalls" data-ng-click="removeCat($index);" value="삭제"/>
									</td>
								</tr>
							</tbody>  
						</table>
					</td>
				</tr>
				<tr id="stateTr" style="display:none;">
					<th scope="row">상태값</th>
					<td id="stateTd">
						<input type="button" value="상태추가" data-ng-click="addState();" class="btalls"/>
						<table class="type1">
						  	<colgroup>
							  	<col />
							  	<col style="width:110px;" />
						  	</colgroup>
							<thead>
								<tr>
									<th scope="col" class="center">상태명</th>
									<th scope="col" class="center">관리</th>
								</tr>
							</thead>
							<tbody id="stateWrap">
								<tr data-ng-repeat="item in form.state_size">
									<td class="member_nm left" style="padding-left:12px;">
										<input type="text" class="normal" style="width:228px;" data-ng-model="form.state_nm[$index].state_nm"/>
									</td>
									<td class="center">
										<input type="button" data-ng-click="removeState($index);" class="btalls" value="삭제"/>
									</td>
								</tr>
							</tbody>  
						</table>
					</td>
				</tr>
			
				<tr id="customTr" style="display:none;">
					<th scope="row">커스텀 항목</th>
					<td id="customTd">
						<b style="color:red;">사용된 컬럼을 재사용시 오류가 발생할 수 있습니다.</b> <input type="button" value="항목추가" data-ng-click="addElement();" class="btalls"/>
						<br/>
						<div id="tables">
							<table data-ng-repeat="item in form.custom" class="type1" style="margin-bottom:10px;" data-index="{{item.order_num}}">
								<colgroup>
									<col style="width:10%;" />
									<col />
									<col style="width:15%;" />
									<col style="width:15%;" />
									<col style="width:15%;" />
									<col style="width:15%;" />
									<col style="width:15%;" />
								</colgroup>
								<!-- 
								<tr>
									<th class="center" rowspan="5" style="border-right:solid 1px #ddd;">{{$index+1}}번 항목<br/>
										<input type="button" data-ng-click="removeElement($index);" value="삭제" class="btalls"/>
									</th>
									<th class="center" style="border-right:solid 1px #ddd;">항목명 / 컬럼</th>
									<td colspan="8">
										<input type="text" class="normal w75" data-ng-model="item.element" required/> / 
										<select title="컬럼선택" class="normal w100" data-ng-model="item.column_name" data-ng-options="item.col_code as item.col_kor for item in column_list" required>
											<option value="">전체</option>
										</select>
										<span data-ng-if="item.column_name != ''" data-ng-repeat="cols in column_list|filter:{col_code:item.column_name}" style="color:blue;">{{cols.col_helper}}</span>
									</td>
								</tr>
								 -->
								<tr>
									<th class="center" rowspan="6" style="border-right:solid 1px #ddd;">{{$index+1}}번 항목<br/>
										<input type="button" data-ng-click="removeElement($index);" value="삭제" class="btalls"/>
									</th>								
									<th scope="col" class="center" rowspan="2" style="border-right:solid 1px #ddd;">타이틀</th>
									<th scope="col" class="center">필수항목</th>
									<th scope="col" class="center">항목명</th>
									<th scope="col" class="center">컬럼</th>
									<th scope="col" class="center" colspan="2">컬럼설명</th>
								</tr>
								<tr>
									<td class="center"><input type="checkbox" data-ng-model="item.require_yn" data-ng-true-value="'Y'" data-ng-false-value="'N'"/></td>
									<td class="center"><input type="text" class="normal w150" data-ng-model="item.element" required/></td>
									<td class="center">
										<select title="컬럼선택" class="normal w125" data-ng-model="item.column_name" data-ng-options="item.col_code as item.col_kor for item in column_list" required>
											<option value="">전체</option>
										</select>
									</td>
									<td class="center" colspan="2"><span data-ng-if="item.column_name != null" data-ng-repeat="cols in column_list|filter:{col_code:item.column_name}" style="color:blue;">{{cols.col_helper}}</span></td>
								</tr>
								<tr>
									<th scope="col" class="center" rowspan="2" style="border-right:solid 1px #ddd;">사용자</th>
									<th scope="col" class="center">리스트(보임/숨김)</th>
									<th scope="col" class="center">리스트 사이즈(%,px)</th>
									<th scope="col" class="center">뷰(보임/숨김)</th>
									<th scope="col" class="center">쓰기(보임/숨김)</th>
									<th scope="col" class="center">수정(보임/숨김)</th>
								</tr>
								<tr>
									<td class="center"><input type="checkbox" data-ng-model="item.user_list_element" data-ng-true-value="'Y'" data-ng-false-value="'N'"/></td>
									<td class="center"><input type="text" class="normal w150" data-ng-model="item.user_list_col" data-ng-readonly="item.user_list_element == 'N'" value="{{item.user_list_element == 'N' ? '0%' : item.user_list_col}}"/></td>
									<td class="center"><input type="checkbox" data-ng-model="item.user_view_element" data-ng-true-value="'Y'" data-ng-false-value="'N'"/></td>
									<td class="center"><input type="checkbox" data-ng-model="item.user_insert_element" data-ng-true-value="'Y'" data-ng-false-value="'N'"/></td>
									<td class="center"><input type="checkbox" data-ng-model="item.user_modify_element" data-ng-true-value="'Y'" data-ng-false-value="'N'"/></td>
								</tr>
								<tr>
									<th scope="col" class="center" rowspan="2" style="border-right:solid 1px #ddd;">관리자</th>
									<th scope="col" class="center">리스트(보임/숨김)</th>
									<th scope="col" class="center">리스트 사이즈(%,px)</th>
									<th scope="col" class="center">뷰(보임/숨김)</th>
									<th scope="col" class="center">쓰기(보임/숨김)</th>
									<th scope="col" class="center">수정(보임/숨김)</th>
								</tr>
								<tr>
									<td class="center"><input type="checkbox" data-ng-model="item.admin_list_element" data-ng-true-value="'Y'" data-ng-false-value="'N'"/></td>
									<td class="center"><input type="text" class="normal w150" data-ng-model="item.admin_list_col" data-ng-readonly="item.admin_list_element == 'N'" value="{{item.admin_list_element == 'N' ? '0%' : item.admin_list_col}}"/></td>
									<td class="center"> </td>
									<td class="center"><input type="checkbox" data-ng-model="item.admin_insert_element" data-ng-true-value="'Y'" data-ng-false-value="'N'"/></td>
									<td class="center"><input type="checkbox" data-ng-model="item.admin_modify_element" data-ng-true-value="'Y'" data-ng-false-value="'N'"/></td>
								</tr>
							</table>
						</div>
					</td>
				</tr>	
			</table>
			
			<table class="type1" style="margin-top:20px;">
				<colgroup>
				    <col style="width:50px;"/>
				    <col/>
				    <col style="width:100px;"/>
				    <col style="width:120px;"/>
				</colgroup>
				<tbody>
					<tr>
						<th scope="col" class="center">번호</th>
						<th scope="col" class="center">연결메뉴</th>
						<th scope="col" class="center">일자</th>
						<th scope="col" class="center">이동</th>
					</tr>
					<tr data-ng-if="menuList.length==0">
						<td colspan="4" class="center">연결된 메뉴가 없습니다.</td>
					</tr>
					<tr data-ng-repeat="item in menuList">
	      				<td class="center">{{$index + 1}}</td>
						<td class="left">{{item.page_navi}}</td>
						<td class="center">{{item.reg_dt}}</td>
						<td class="center"><button value="페이지이동" ng-click="openLink(item.menu_url)" class="bt_small move">페이지 이동</button></td>
					</tr>
				</tbody>
			</table>
			
			<div class="btn_bottom">
				<div class="right_btn">
					<input type="button" value="저장" data-ng-click="save();" class="bt_big_bt4"/>
					<input type="button" value="목록" data-ng-click="list();" class="bt_big_bt2"/>
				</div>
			</div>
			</form>
		</div>
	</div>