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
		    	<caption>공휴일 관리</caption>
		    	<tr>
					<th scope="row">사이트명</th>
					<td>
						<input type="text" class="normal w200" data-ng-model="form.title" required="required" /><span style="margin-left:6px;">사이트명은 브라우저에 노출되는 명칭이며, 추후 사이트관리에서 변경 가능합니다.</span>
					</td>
				</tr>
				<tr>
					<th scope="row">사이트URL</th>
					<td>
						<input type="text" class="normal w200" data-ng-model="form.sub_path" required="required" /><span style="margin-left:6px;">"/사이트주소" (사이트주소는 영문이어야 합니다.)</span>
					</td>
				</tr>
				<tr>
					<th scope="row">자동파일생성</th>
					<td>
						<ol class="select">
							<li class="first"><label><input type="radio" data-ng-model="form.create_file_yn" value="Y"/> 파일생성 </label></li>
							<li><label><input type="radio" data-ng-model="form.create_file_yn" value="N"/> 생성안함</label></li>
						</ol>
					</td>
				</tr>
				<tr>
					<th scope="row">사이트 관리자</th>
					<td>
						<div class="layout_g2">
							<span style="display:inline-block; float:left; margin:4px 7px 0 0; font-size:12px;">관리자를 지정하여  해당 사이트의 모든 권한을 지정할 수 있습니다.</span>
						    <input type="button" value="담당자 선택" class="btalls" data-ng-click="openStaffSelect(form)">
						</div>
						<div class="layout_g1" ng-show="form.staff_list.length>0">
						    <span ui-sortable="staffSortable" data-ng-model="form.staff_list">
								<span data-ng-repeat="item in form.staff_list">{{item.group_nm}} {{item.member_nm}}
									<a data-ng-click="removeStaff($index)"><img src="${context_path }/images/container/btn_del2_03.png" class="btn"></a>
								</span>
							</span>
						</div>
					</td>
				</tr>
		    </table>
		    
		    <div class="btn_bottom">
		    	<div class="r_btn">
					<input type="button" value="저장" class="bt_big_bt4" data-ng-click="save()"/>
					<input type="button" value="취소" class="bt_big_bt3" data-ng-click="list()"/>
		        </div>
		    </div>
		    <div class="cms_notice">
		    	<h5>※ <b>주의!</b> 사이트 추가는 개발PC에서(개발도구 이클립스등)만 시도해야 합니다.</h5>
		    	<ul>
		    		<li>
			    		<p>1. <b>mc.properties</b> 파일을 열어 자신의 프로젝트 절대경로를 mc_srcpath 키, 값을 추가해준 후 이클립스 내 프로젝트 실행 합니다.</p>
			    		<span>예) mc_srcpath=D:/project/cms/workspace/egov_cms_gs/src</span>
		    		</li>
		    		<li>
		    			<p>2. 관리자 > 시스템관리 > 사이트 추가관리 페이지 이동</p>
		    		</li>
		    		<li>
		    			<p>3. 사이트명, 사이트URL을 입력후 등록합니다.</p>
		    			<span>사이트경로는 <b>소문자</b>로 입력해야 합니다.</span>
						<span>사이트URL을 입력시 '/eng' 와 같이 입력했을시, http://도메인명/eng 형태로 호출해야 합니다.</span>
						<span>작성하는 URL명으로 폴더가 자동으로 생성되므로 <b>중복되지 않는 경로명을 사용</b>해야합니다.</span>
						<span>(/main/webapp/WEB-INF/jsp/, /main/webapp/, /main/java/com/mc/web/page/ 아래에 등록한 경로명으로 폴더구조가 자동 생성)</span>
		    		</li>
		    		<li>
		    			<p>4. 등록이 완료되면 이클립스 내 프로젝트를 새로고침 후 Web Application Serve(was)를 재가동 합니다.</p>
		    		</li>
		    		<li>
		    			<p>5. http://127.0.0.1/eng에 접속하여 새로운 템플릿이 생성된 것을 확인 합니다.</p>
		    		</li>
		    		<li>
		    			<p>6. 생성된 파일목록을 확인 후 템플릿이나 디자인을 변경해서 사용 할 수 있습니다.</p>
		    		</li>
		    	</ul>		    
			</form>
		</div>
