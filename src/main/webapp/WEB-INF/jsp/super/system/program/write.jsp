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
			    <caption>프로그램 관리</caption>
		    	<tr>
					<th scope="row">프로그램명</th>
					<td>
						<input type="text" class="normal w175" data-ng-model="form.program_nm" required="required"/>
					</td>
				</tr>
				<tr>
					<th scope="row">자동파일생성<br />폴더명</th>
					<td>
						<ol class="select">
							<li class="first"><label><input type="radio" data-ng-model="form.create_file_yn" value="Y"/> 파일생성 </label></li>
							<li><label><input type="radio" data-ng-model="form.create_file_yn" value="N"/> 생성안함</label></li>
						</ol>
						<input type="text" class="normal" style="margin-top:4px; width:50%;" data-ng-model="form.folder" ng-disabled="form.create_file_yn=='N'"/>
					</td>
				</tr>
				<tr>
					<th scope="row">URL</th>
					<td>
						<input type="text" class="normal" style="width:50%;" data-ng-model="form.url"  required="required"/>
					</td>
				</tr>
				<tr>
					<th scope="row">관리URL</th>
					<td>
						<input type="text" class="normal" style="width:50%;" data-ng-model="form.manage_url" />
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
		    	<h5>※ 저장 시 자동으로 java파일 및 jsp가 생성됩니다. 단, 수정ㆍ삭제 시는 소스를 직접 수정해야 합니다.</h5>
		    	<ul>
		    		<li>
		    			<h6>1. 생성폴더명</h6>
		    			<p>사용할 Java package명은 반드시 <b>소문자</b>로 입력해야 하고 <b>띄어쓰기나 특수문자가 들어가선 안됩니다.</b></p>
		    			<span>작성 예) diary(o), D@iary(x), /diary(x)</span>
		    			<span>폴더명을 diary로 정했으면 URL에 사용하는 메인 경로도 diary로 맞춰주는 것이 관리하기에 좋습니다.</span>
		    		</li>
		    		<li>
		    			<h6>2. URL명</h6>
		    			<p>사용자 화면에서 사용할 URL명은 반드시 <b>소문자</b>로 입력해야 하고 <b>띄어쓰기나 특수문자가 들어가선 안됩니다.</b></p>
		    			<span>작성 예) /diary/intro.do(o), /Diary/intro.do(x), diary/intro.do(x)</span>
		    		</li>
		    		<li>
		    			<h6>3. 관리URL</h6>
		    			<p>별도의 관리자 페이지가 필요할 경우 선택적으로 입력합니다.</p>
		    			<p>입력시 /super/homepage/<b>diary</b>/index.do 와 같이 입력하면 자동으로 개발할 수 있는 기본 관리페이지를 생성합니다.</p>
		    			<span>작성 예)</span>
		    			<span>/super/homepage/<b>diary</b>/index.do(o)</span>
		    			<span>/super/homepage/<b>manage/diary</b>/index.do(x)</span>
		    			<span>/super/homepage/diary/<b>list</b>.do(x)</span>
		    		</li>
		    	</ul>
		    </div>
			</form>
		</div>
