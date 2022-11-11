<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
		<div class="contents" data-ng-cloak>
			<form id="wFrm" name="wFrm" method="post" novalidate="novalidate">
		    <table class="type1" style="margin-top:0;">
			    <colgroup>
				    <col style="width:200px;" />
				    <col />
			    </colgroup>
		    	<caption>기본설정</caption>
		    	<tr>
					<th scope="row">홈페이지명</th>
					<td>
						<span style="display:block; margin:0 0 5px 0; font-size:12px;">홈페이지명은 브라우저에 표시되는 명칭 입니다.(홈페이지명의 경우 포털사이트에 검색조건으로 이용되므로 자주 변경시 사이트 검색이 되지 않을 수 있습니다.)</span>
						<input type="text" class="bold" style="width:50%;" data-ng-model="form.title"/>
					</td>
				</tr>
				
				<tr>
					<th scope="row">페이지 만족도 설정</th>
					<td>
						<span style="display:block; margin:0 0 5px 0; font-size:12px;">메뉴별 하단에 페이지 만족도 사용 여부를 설정 할 수 있습니다.</span>
						<ol class="select">
						<li class="first"><label><input type="radio" data-ng-model="form.satisfaction_yn" value="Y"/> 사용 </label></li>
						<li><label><input type="radio" data-ng-model="form.satisfaction_yn" value="N"/> 사용안함</label></li>
						</ol>
					</td>
				</tr>
				<tr>
					<th scope="row">담당자 안내 설정</th>
					<td>
						<span style="display:block; margin:0 0 5px 0; font-size:12px;">페이지 하단에 지정된 담당자 이름과 전화번호 노출 여부를 설정 할 수 있습니다.(사용안함시 메뉴에서 담당자를 지정하여도 페이지에 보여지지 않습니다.메뉴 권한은  유지됩니다.)</span>
						<ol class="select">
						<li class="first"><label><input type="radio" data-ng-model="form.manage_yn" value="Y"/> 사용 </label></li>
						<li><label><input type="radio" data-ng-model="form.manage_yn" value="N"/> 사용안함</label></li>
						</ol>
					</td>
				</tr>
				<tr>
					<th scope="row">레이어팝업 설정</th>
					<td>
						<span style="display:block; margin:0 0 5px 0; font-size:12px;">홈페이지 접속시 레이어팝업 타입을 설정할 수 있습니다.</span>
						<ol class="select">
						<li class="first"><label><input type="radio" data-ng-model="form.popup_type" value="Y"/> 개별팝업</label></li>
						<li><label><input type="radio" data-ng-model="form.popup_type" value="N"/> 슬라이드팝업</label></li>
						</ol>
					</td>
				</tr>
		    	<tr>
					<th scope="row">하단 정보 수정</th>
					<td>
						<textarea data-ng-model="form.footer_html" global-editor ng-height="'300px'"></textarea>
						<div>홈페이지 하단(FOOTER)의 정보를 변경할 수 있습니다.(사업자등록번호, 대표자이름, 링크변경등) </div>
					</td>
				</tr>
		    </table>
		    
		    <div class="btn_bottom">
		    	<div class="r_btn">
					<input type="button" value="저장" class="bt_big_bt4" data-ng-click="save()"/>
		        </div>
		    </div>
		    
			</form>
		</div>
