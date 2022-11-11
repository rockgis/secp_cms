<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
		<div class="contents" data-ng-cloak>
			<form id="wFrm" name="wFrm" method="post" novalidate="novalidate">
			<h4 style="color:#333; font-size:15px; font-weight:500;">일반회원 보안</h4>
		    <table class="type1">
		    	<caption>일반회원 보안</caption>
			    <colgroup>
				    <col style="width:220px;" />
				    <col />
			    </colgroup>
		    	<tr>
					<th scope="row">일반회원 로그아웃시간 설정</th>
					<td>
						<div style="overflow:hidden;"> 
							<ol class="select" style="display:inline-block; float:left; padding:7px 0 6px 0;">
								<li><label><input type="radio" data-ng-model="form.logout_time_yn" value="N" /> 미사용</label></li>
								<li class="first"><label><input type="radio" data-ng-model="form.logout_time_yn" value="Y"/> 사용</label></li>
							</ol>
							<span style="display:inline-block; float:left;" data-ng-if="form.logout_time_yn=='Y'"><input type="number" class="normal w75" data-ng-model="form.logout_time" min="1" required /> 분</span>
						</div>
					</td>
				</tr>
		    	<tr>
					<th scope="row">일반회원 비밀번호변경주기 설정</th>
					<td style="overflow:hidden;">
						<ol class="select" class="select" style="display:inline-block; float:left; padding:7px 0 6px 0;">
							<li><label><input type="radio" data-ng-model="form.pw_change_yn" value="N" /> 미사용</label></li>
							<li class="first"><label><input type="radio" data-ng-model="form.pw_change_yn" value="Y"/> 사용</label></li>
						</ol>
						<span style="display:inline-block; float:left;" data-ng-if="form.pw_change_yn=='Y'"><input type="number" class="normal w75" data-ng-model="form.pw_change_cycle" min="1" required/> 일</span>
					</td>
				</tr>
		    	<tr>
					<th scope="row">일반회원 장기 미접속 설정</th>
					<td style="overflow:hidden;">
						<ol class="select" style="display:inline-block; float:left; padding:7px 0 6px 0;">
							<li><label><input type="radio" data-ng-model="form.dormancy_yn" value="N" /> 미사용</label></li>
							<li class="first"><label><input type="radio" data-ng-model="form.dormancy_yn" value="Y"/> 사용</label></li>
						</ol>
						<span style="display:inline-block; float:left;" data-ng-if="form.dormancy_yn=='Y'"><input type="number" class="normal w75" data-ng-model="form.dormancy_day" min="1" required/> 일</span>
					</td>
				</tr>
		    </table>
		    <p style="margin:5px;">※ 사용자페이지에 적용되는 보안 설정 입니다.</p>
		    <h4 style="margin-top:35px; color:#333; font-size:15px; font-weight:500;">관리자 보안</h4>
		    <table class="type1">
		    	<caption></caption>
		    	<colgroup>
				    <col style="width:220px;" />
				    <col />
			    </colgroup>
		    	<tr>
					<th scope="row">관리자 로그아웃시간 설정</th>
					<td>
						<div style="overflow:hidden;">
							<ol class="select" style="display:inline-block; float:left; padding:7px 0 6px 0;">
								<li><label><input type="radio" data-ng-model="form.adm_logout_time_yn" value="N" /> 미사용</label></li>
								<li class="first"><label><input type="radio" data-ng-model="form.adm_logout_time_yn" value="Y"/> 사용</label></li>
							</ol>
							<span style="display:inline-block; float:left;" data-ng-if="form.adm_logout_time_yn=='Y'"><input type="number" class="normal w75" data-ng-model="form.adm_logout_time" min="1" required/> 분</span>
						</div>
					</td>
				</tr>
		    	<tr>
					<th scope="row">관리자 비밀번호변경주기 설정</th>
					<td style="overflow:hidden;">
						<ol class="select" class="select" style="display:inline-block; float:left; padding:7px 0 6px 0;">
							<li><label><input type="radio" data-ng-model="form.adm_pw_change_yn" value="N" /> 미사용</label></li>
							<li class="first"><label><input type="radio" data-ng-model="form.adm_pw_change_yn" value="Y"/> 사용</label></li>
						</ol>
						<span style="display:inline-block; float:left;" data-ng-if="form.adm_pw_change_yn=='Y'"><input type="number" class="normal w75" data-ng-model="form.adm_pw_change_cycle" min="1" required/> 일</span>
					</td>
				</tr>
		    	<tr>
					<th scope="row">관리자 장기 미접속 설정</th>
					<td style="overflow:hidden;">
						<ol class="select" style="display:inline-block; float:left; padding:7px 0 6px 0;">
							<li><label><input type="radio" data-ng-model="form.adm_dormancy_yn" value="N" /> 미사용</label></li>
							<li class="first"><label><input type="radio" data-ng-model="form.adm_dormancy_yn" value="Y"/> 사용</label></li>
						</ol>
						<span style="display:inline-block; float:left;" data-ng-if="form.adm_dormancy_yn=='Y'"><input type="number" class="normal w75" data-ng-model="form.adm_dormancy_day" min="1" required/> 일</span>
					</td>
				</tr>
			</table>
		    <p style="margin:5px;">※ 관리자페이지 접속시 적용되는 보안 설정 입니다.</p>
		    
		    <div class="btn_bottom">
		    	<div class="r_btn">
					<input type="button" value="저장" class="bt_big_bt4" data-ng-click="save()"/>
		        </div>
		    </div>
		    
			</form>
		</div>
