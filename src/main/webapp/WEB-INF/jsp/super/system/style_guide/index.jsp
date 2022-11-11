<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>CMS 스타일 가이드</title>
<script type="text/javascript" src="<c:url value="/lib/js/angular.min.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/angular-route.min.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/filters/myFilter.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/filters/ngRange.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/services/myCommon.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/services/dialog-service.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/directives/myUtil.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/directives/myPagination.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/route/routeResolver.js"/>"></script>
<script type="text/javascript" src="<c:url value="/lib/js/directives/myEditor.js"/>"></script>
<script type="text/javascript">
var app = angular.module("MyApp", ['routeResolverServices', 'dialogService', 'ngRoute', 'myUtil', 'myPagination', 'myCommon', 'myFilter', 'ngRange', 'myEditor']);
</script>
</head>
<body>
	<div class="titlebar">
		<h2>CMS 스타일 가이드</h2>
		<div>
			<span>시스템 관리</span>&gt; <span>시스템 설정 및 관리</span>&gt;
			<span class="bar_tx">CMS 스타일 가이드</span>
		</div>
	</div>
	<div style="padding:5px 5px 60px 5px;">
		
		<div style="padding:12px;">
			<div class="definition">
				<h3>색상</h3>
			</div>
			<div class="example">
				<div>
					<p>테이블 색상</p>
					<div class="color" style="background:#ddd;">
						<div>#dddddd</div>
					</div>
					<div class="color" style="background:#f3f3f3;">
						<div>#f3f3f3</div>
					</div>
					<div class="color" style="background:#e3e5e6;">
						<div>#e3e5e6</div>
					</div>
				</div>
				<div>
					<p>기본 색상</p>
					<div class="color" style="background:#658ede;">
						<div>#658ede</div>
					</div>
					<div class="color" style="background:#3e70c9;">
						<div>#3e70c9</div>
					</div>
					<div class="color" style="background:#dd4b39;">
						<div>#dd4b39</div>
					</div>
					<div class="color" style="background:#43b968;">
						<div>#43b968</div>
					</div>
					<div class="color" style="background:#f6db80;">
						<div>#f6db80</div>
					</div>
				</div>
				<div>
					<p>아이콘 색상</p>
					<div class="color" style="background:#4ea9f6;">
						<div>#4ea9f6</div>
					</div>
					<div class="color" style="background:#35c3b9;">
						<div>#35c3b9</div>
					</div>
					<div class="color" style="background:#e86561;">
						<div>#e86561</div>
					</div>
				</div>
				<div style="margin-bottom:0;">
					<p>테이블 버튼 색상</p>
					<div class="color" style="background:#ff7a1a;">
						<div>#ff7a1a</div>
					</div>
					<div class="color" style="background:#20b9ae;">
						<div>#20b9ae</div>
					</div>
				</div>
			</div>
		</div>
		
		<!-- button -->
		<div style="padding:12px;">
			<div class="definition">
				<h3>버튼</h3>
				<p>input type="button" 에 사용합니다.</p>
				<p>클래스에 들어가는 숫자로 스타일을 조정하며 'bt2'는 중립적, 'bt3'은 부정적, 'bt4'는 긍정적인 효과를 나타냅니다.</p>
			</div>
			<div class="example">
				<input type="button" class="bt_big_bt2" value="목록" />
				<input type="button" class="bt_big_bt3" value="삭제" />
				<input type="button" class="bt_big_bt4" value="수정" />
			</div>
			<div class="explanation">
				<div class="colorscripter-code" style="color:#010101; font-family:Consolas, 'Liberation Mono', Menlo, Courier, monospace !important; position:relative !important; overflow:auto"><table class="colorscripter-code-table" style="margin:0; padding:0; border:none; background-color:#fafafa; border-radius:4px;" cellspacing="0" cellpadding="0"><tr><td style="padding:6px 0"><div style="margin:0; padding:0; color:#010101; font-family:Consolas, 'Liberation Mono', Menlo, Courier, monospace !important; line-height:130%"><div style="padding:0 6px; white-space:pre; line-height:130%"><span style="color:#010101">&lt;</span><span style="color:#066de2">input</span>&nbsp;<span style="color:#0a9989">type</span>=<span style="color:#df5000">"button"</span><span style="color:#0a9989"></span>&nbsp;<span style="color:#0a9989">class</span>=<span style="color:#df5000">"bt_big_bt2"</span><span style="color:#0a9989"></span>&nbsp;<span style="color:#0a9989">value</span>=<span style="color:#df5000">"목록"</span><span style="color:#0a9989"></span>&nbsp;<span style="color:#0a9989">/</span><span style="color:#010101">&gt;</span></div><div style="padding:0 6px; white-space:pre; line-height:130%"><span style="color:#010101">&lt;</span><span style="color:#066de2">input</span>&nbsp;<span style="color:#0a9989">type</span>=<span style="color:#df5000">"button"</span><span style="color:#0a9989"></span>&nbsp;<span style="color:#0a9989">class</span>=<span style="color:#df5000">"bt_big_bt3"</span><span style="color:#0a9989"></span>&nbsp;<span style="color:#0a9989">value</span>=<span style="color:#df5000">"삭제"</span><span style="color:#0a9989"></span>&nbsp;<span style="color:#0a9989">/</span><span style="color:#010101">&gt;</span></div><div style="padding:0 6px; white-space:pre; line-height:130%"><span style="color:#010101">&lt;</span><span style="color:#066de2">input</span>&nbsp;<span style="color:#0a9989">type</span>=<span style="color:#df5000">"button"</span><span style="color:#0a9989"></span>&nbsp;<span style="color:#0a9989">class</span>=<span style="color:#df5000">"bt_big_bt4"</span><span style="color:#0a9989"></span>&nbsp;<span style="color:#0a9989">value</span>=<span style="color:#df5000">"수정"</span><span style="color:#0a9989"></span>&nbsp;<span style="color:#0a9989">/</span><span style="color:#010101">&gt;</span></div></div></td></tr></table></div>
			</div>
		</div>
		
		<!-- input text -->
		<div style="padding:12px;">
			<div class="definition">
				<h3>input [텍스트]</h3>
				<p>input type="text" 로 사용합니다.</p>
				<p>'bold'와 'normal' 클래스로 글자의 굵기를 조절할 수 있습니다.</p>
			</div>
			<div class="example">
				<input type="text" class="bold w200" style="display:block; margin-bottom:10px;" placeholder="bold" />
				<input type="text" class="normal w200" placeholder="normal" />
			</div>
			<div class="explanation">
				<div class="colorscripter-code" style="color:#010101; font-family:Consolas, 'Liberation Mono', Menlo, Courier, monospace !important; position:relative !important; overflow:auto"><table class="colorscripter-code-table" style="margin:0; padding:0; border:none; background-color:#fafafa; border-radius:4px;" cellspacing="0" cellpadding="0"><tr><td style="padding:6px 0"><div style="margin:0; padding:0; color:#010101; font-family:Consolas, 'Liberation Mono', Menlo, Courier, monospace !important; line-height:130%"><div style="padding:0 6px; white-space:pre; line-height:130%"><span style="color:#010101">&lt;</span><span style="color:#066de2">input</span>&nbsp;<span style="color:#0a9989">type</span>=<span style="color:#df5000">"text"</span><span style="color:#0a9989"></span>&nbsp;<span style="color:#0a9989">class</span>=<span style="color:#df5000">"bold"</span><span style="color:#0a9989"></span>&nbsp;<span style="color:#0a9989">/</span><span style="color:#010101">&gt;</span></div><div style="padding:0 6px; white-space:pre; line-height:130%"><span style="color:#010101">&lt;</span><span style="color:#066de2">input</span>&nbsp;<span style="color:#0a9989">type</span>=<span style="color:#df5000">"text"</span><span style="color:#0a9989"></span>&nbsp;<span style="color:#0a9989">class</span>=<span style="color:#df5000">"normal"</span><span style="color:#0a9989"></span>&nbsp;<span style="color:#0a9989">/</span><span style="color:#010101">&gt;</span></div></div></td></tr></table></div>
			</div>
		</div>
		
		<!-- input calendar -->
		<div style="padding:12px;">
			<div class="definition">
				<h3>input [달력]</h3>
				<p>input type="text" 로 사용합니다.</p>
				<p>'ng-model="임의의 값"' 과 'datetimepicker' 를 같이 넣으면 달력 기능이 생성됩니다.</p>
			</div>
			<div class="example">
				<input type="text" class="normal w175" ng-model="aaa" datetimepicker />
			</div>
			<div class="explanation">
				<div class="colorscripter-code" style="color:#010101; font-family:Consolas, 'Liberation Mono', Menlo, Courier, monospace !important; position:relative !important; overflow:auto"><table class="colorscripter-code-table" style="margin:0; padding:0; border:none; background-color:#fafafa; border-radius:4px;" cellspacing="0" cellpadding="0"><tr><td style="padding:6px 0"><div style="margin:0; padding:0; color:#010101; font-family:Consolas, 'Liberation Mono', Menlo, Courier, monospace !important; line-height:130%"><div style="padding:0 6px; white-space:pre; line-height:130%"><span style="color:#010101">&lt;</span><span style="color:#066de2">input</span>&nbsp;<span style="color:#0a9989">type</span>=<span style="color:#df5000">"text"</span><span style="color:#0a9989"></span>&nbsp;<span style="color:#0a9989">class</span>=<span style="color:#df5000">"normal"</span><span style="color:#0a9989"></span>&nbsp;<span style="color:#0a9989">ng-model</span>=<span style="color:#df5000">"aaa"</span><span style="color:#0a9989"></span>&nbsp;<span style="color:#0a9989">datetimepicker</span>&nbsp;<span style="color:#0a9989">/</span><span style="color:#010101">&gt;</span></div></div></td></tr></table></div>
			</div>
		</div>
		
		<!-- input radio -->
		<div style="padding:12px;">
			<div class="definition">
				<h3>input [라디오버튼]</h3>
				<p>라디오버튼은 다음의 스타일을 그대로 사용합니다.</p>
			</div>
			<div class="example">
				<ol class="select">
					<li><label><input type="radio"> 전체</label></li>
					<li><label><input type="radio"> 사용</label></li>
					<li><label><input type="radio"> 미사용</label></li>
				</ol>
			</div>
			<div class="explanation">
				<div class="colorscripter-code" style="color:#010101; font-family:Consolas, 'Liberation Mono', Menlo, Courier, monospace !important; position:relative !important; overflow:auto"><table class="colorscripter-code-table" style="margin:0; padding:0; border:none; background-color:#fafafa; border-radius:4px;" cellspacing="0" cellpadding="0"><tr><td style="padding:6px 0"><div style="margin:0; padding:0; color:#010101; font-family:Consolas, 'Liberation Mono', Menlo, Courier, monospace !important; line-height:130%"><div style="padding:0 6px; white-space:pre; line-height:130%"><span style="color:#010101">&lt;</span><span style="color:#066de2">ol</span>&nbsp;<span style="color:#0a9989">class</span>=<span style="color:#df5000">"select"</span><span style="color:#0a9989"></span><span style="color:#010101">&gt;</span></div><div style="padding:0 6px; white-space:pre; line-height:130%">&nbsp;&nbsp;&nbsp;&nbsp;<span style="color:#010101">&lt;</span><span style="color:#066de2">li</span><span style="color:#010101">&gt;</span><span style="color:#010101">&lt;</span><span style="color:#066de2">label</span><span style="color:#010101">&gt;</span><span style="color:#010101">&lt;</span><span style="color:#066de2">input</span>&nbsp;<span style="color:#0a9989">type</span>=<span style="color:#df5000">"radio"</span><span style="color:#0a9989"></span>&nbsp;<span style="color:#0a9989">/</span><span style="color:#010101">&gt;</span>&nbsp;전체<span style="color:#010101">&lt;</span><span style="color:#010101">/</span><span style="color:#066de2">label</span><span style="color:#010101">&gt;</span><span style="color:#010101">&lt;</span><span style="color:#010101">/</span><span style="color:#066de2">li</span><span style="color:#010101">&gt;</span></div><div style="padding:0 6px; white-space:pre; line-height:130%">&nbsp;&nbsp;&nbsp;&nbsp;<span style="color:#010101">&lt;</span><span style="color:#066de2">li</span><span style="color:#010101">&gt;</span><span style="color:#010101">&lt;</span><span style="color:#066de2">label</span><span style="color:#010101">&gt;</span><span style="color:#010101">&lt;</span><span style="color:#066de2">input</span>&nbsp;<span style="color:#0a9989">type</span>=<span style="color:#df5000">"radio"</span><span style="color:#0a9989"></span>&nbsp;<span style="color:#0a9989">/</span><span style="color:#010101">&gt;</span>&nbsp;사용<span style="color:#010101">&lt;</span><span style="color:#010101">/</span><span style="color:#066de2">label</span><span style="color:#010101">&gt;</span><span style="color:#010101">&lt;</span><span style="color:#010101">/</span><span style="color:#066de2">li</span><span style="color:#010101">&gt;</span></div><div style="padding:0 6px; white-space:pre; line-height:130%">&nbsp;&nbsp;&nbsp;&nbsp;<span style="color:#010101">&lt;</span><span style="color:#066de2">li</span><span style="color:#010101">&gt;</span><span style="color:#010101">&lt;</span><span style="color:#066de2">label</span><span style="color:#010101">&gt;</span><span style="color:#010101">&lt;</span><span style="color:#066de2">input</span>&nbsp;<span style="color:#0a9989">type</span>=<span style="color:#df5000">"radio"</span><span style="color:#0a9989"></span>&nbsp;<span style="color:#0a9989">/</span><span style="color:#010101">&gt;</span>&nbsp;미사용<span style="color:#010101">&lt;</span><span style="color:#010101">/</span><span style="color:#066de2">label</span><span style="color:#010101">&gt;</span><span style="color:#010101">&lt;</span><span style="color:#010101">/</span><span style="color:#066de2">li</span><span style="color:#010101">&gt;</span></div><div style="padding:0 6px; white-space:pre; line-height:130%"><span style="color:#010101">&lt;</span><span style="color:#010101">/</span><span style="color:#066de2">ol</span><span style="color:#010101">&gt;</span></div></div></tr></table></div>
			</div>
		</div>
		
		<!-- select -->
		<div style="padding:12px;">
			<div class="definition">
				<h3>select</h3>
				<p>input과 마찬가지로 'normal' 클래스로 스타일을 적용합니다.</p>
			</div>
			<div class="example">
				<select class="normal w175">
					<option value="A">A</option>
					<option value="B">B</option>
					<option value="C">C</option>
				</select>
			</div>
			<div class="explanation">
				<div class="colorscripter-code" style="color:#010101; font-family:Consolas, 'Liberation Mono', Menlo, Courier, monospace !important; position:relative !important; overflow:auto"><table class="colorscripter-code-table" style="margin:0; padding:0; border:none; background-color:#fafafa; border-radius:4px;" cellspacing="0" cellpadding="0"><tr><td style="padding:6px 0"><div style="margin:0; padding:0; color:#010101; font-family:Consolas, 'Liberation Mono', Menlo, Courier, monospace !important; line-height:130%"><div style="padding:0 6px; white-space:pre; line-height:130%"><span style="color:#010101">&lt;</span><span style="color:#066de2">select</span>&nbsp;<span style="color:#0a9989">class</span>=<span style="color:#df5000">"normal"</span><span style="color:#0a9989"></span><span style="color:#010101">&gt;</span></div><div style="padding:0 6px; white-space:pre; line-height:130%">&nbsp;&nbsp;&nbsp;&nbsp;<span style="color:#010101">&lt;</span><span style="color:#066de2">option</span>&nbsp;<span style="color:#0a9989">value</span>=<span style="color:#df5000">"A"</span><span style="color:#0a9989"></span><span style="color:#010101">&gt;</span>A<span style="color:#010101">&lt;</span><span style="color:#010101">/</span><span style="color:#066de2">option</span><span style="color:#010101">&gt;</span></div><div style="padding:0 6px; white-space:pre; line-height:130%">&nbsp;&nbsp;&nbsp;&nbsp;<span style="color:#010101">&lt;</span><span style="color:#066de2">option</span>&nbsp;<span style="color:#0a9989">value</span>=<span style="color:#df5000">"B"</span><span style="color:#0a9989"></span><span style="color:#010101">&gt;</span>B<span style="color:#010101">&lt;</span><span style="color:#010101">/</span><span style="color:#066de2">option</span><span style="color:#010101">&gt;</span></div><div style="padding:0 6px; white-space:pre; line-height:130%">&nbsp;&nbsp;&nbsp;&nbsp;<span style="color:#010101">&lt;</span><span style="color:#066de2">option</span>&nbsp;<span style="color:#0a9989">value</span>=<span style="color:#df5000">"C"</span><span style="color:#0a9989"></span><span style="color:#010101">&gt;</span>C<span style="color:#010101">&lt;</span><span style="color:#010101">/</span><span style="color:#066de2">option</span><span style="color:#010101">&gt;</span></div><div style="padding:0 6px; white-space:pre; line-height:130%"><span style="color:#010101">&lt;</span><span style="color:#010101">/</span><span style="color:#066de2">select</span><span style="color:#010101">&gt;</span></div></div></td></tr></table></div>
			</div>
		</div>
		
		<!-- input, select 길이조절 -->
		<div style="padding:12px;">
			<div class="definition">
				<h3>input과 select의 길이 조절</h3>
				<p>'w100', 'w150' 등의 클래스로 길이를 조절 할 수 있으며 input과 select만 가능합니다.</p>
				<p>현재 조정 가능한 수치는 w75, w100, w125, w150, w175, w200입니다.</p>
			</div>
			<div class="example">
				<input type="text" class="bold w75" style="display:block; margin-bottom:10px;" />
				<input type="text" class="normal w100" style="display:block; margin-bottom:10px;" />
				<select class="normal w125" style="display:block; margin-bottom:10px;">
					<option value="">option1</option>
					<option value="">option2</option>
				</select>
				<select class="normal w150" style="display:block; margin-bottom:10px;">
					<option value="">CMS1</option>
					<option value="">CMS1_1</option>
				</select>
				<input type="text" class="bold w175" style="display:block; margin-bottom:10px;" />
				<input type="text" class="normal w200" style="display:block;" />
			</div>
			<div class="explanation">
				<div class="colorscripter-code" style="color:#010101; font-family:Consolas, 'Liberation Mono', Menlo, Courier, monospace !important; position:relative !important; overflow:auto"><table class="colorscripter-code-table" style="margin:0; padding:0; border:none; background-color:#fafafa; border-radius:4px;" cellspacing="0" cellpadding="0"><tr><td style="padding:6px 0"><div style="margin:0; padding:0; color:#010101; font-family:Consolas, 'Liberation Mono', Menlo, Courier, monospace !important; line-height:130%"><div style="padding:0 6px; white-space:pre; line-height:130%"><span style="color:#010101">&lt;</span><span style="color:#066de2">input</span>&nbsp;<span style="color:#0a9989">type</span>=<span style="color:#df5000">"text"</span><span style="color:#0a9989"></span>&nbsp;<span style="color:#0a9989">class</span>=<span style="color:#df5000">"normal&nbsp;w100"</span><span style="color:#0a9989"></span>&nbsp;<span style="color:#0a9989">/</span><span style="color:#010101">&gt;</span></div><div style="padding:0 6px; white-space:pre; line-height:130%"><span style="color:#010101">&lt;</span><span style="color:#066de2">select</span>&nbsp;<span style="color:#0a9989">class</span>=<span style="color:#df5000">"normal&nbsp;w150"</span><span style="color:#0a9989"></span><span style="color:#010101">&gt;</span></div><div style="padding:0 6px; white-space:pre; line-height:130%">&nbsp;&nbsp;&nbsp;&nbsp;<span style="color:#010101">&lt;</span><span style="color:#066de2">option</span>&nbsp;<span style="color:#0a9989">value</span>=<span style="color:#df5000">""</span><span style="color:#0a9989"></span><span style="color:#010101">&gt;</span>CMS1<span style="color:#010101">&lt;</span><span style="color:#010101">/</span><span style="color:#066de2">option</span><span style="color:#010101">&gt;</span></div><div style="padding:0 6px; white-space:pre; line-height:130%">&nbsp;&nbsp;&nbsp;&nbsp;<span style="color:#010101">&lt;</span><span style="color:#066de2">option</span>&nbsp;<span style="color:#0a9989">value</span>=<span style="color:#df5000">""</span><span style="color:#0a9989"></span><span style="color:#010101">&gt;</span>CMS1_1<span style="color:#010101">&lt;</span><span style="color:#010101">/</span><span style="color:#066de2">option</span><span style="color:#010101">&gt;</span></div><div style="padding:0 6px; white-space:pre; line-height:130%"><span style="color:#010101">&lt;</span><span style="color:#010101">/</span><span style="color:#066de2">select</span><span style="color:#010101">&gt;</span></div></div></tr></table></div>
			</div>
		</div>
		
		<!-- editor -->
		<div style="padding:12px;">
			<div class="definition">
				<h3>editor</h3>
				<p>textarea에 현재 사용중인 에디터 명을 적어주면 적용됩니다.</p>
				<p>(※ Smarteditor, ck-editor는 기본으로 제공되며, Crosseditor 및 기타 유료 에디터는 라이센스 보유시 사용가능합니다.)</p>
				<p>'global-editor'</p>
			</div>
			<div class="example">
				<textarea ng-model="textarea" global-editor ng-height="'200px'" ng-width="'800px'"></textarea>
				<textarea ng-model="textarea" global-editor="ck-editor" ng-height="'200px'" ng-width="'800px'"></textarea>
				<!-- <textarea ng-model="textarea" global-editor="crosseditor" ng-height="'200px'" ng-width="'800px'"></textarea> -->
			</div>
			<div class="explanation">
				<div class="colorscripter-code" style="color:#010101; font-family:Consolas, 'Liberation Mono', Menlo, Courier, monospace !important; position:relative !important; overflow:auto"><table class="colorscripter-code-table" style="margin:0; padding:0; border:none; background-color:#fafafa; border-radius:4px;" cellspacing="0" cellpadding="0"><tr><td style="padding:6px 0"><div style="margin:0; padding:0; color:#010101; font-family:Consolas, 'Liberation Mono', Menlo, Courier, monospace !important; line-height:130%"><div style="padding:0 6px; white-space:pre; line-height:130%"><span style="color:#010101">&lt;</span><span style="color:#066de2">textarea</span>&nbsp;<span style="color:#0a9989">ng-model</span>=<span style="color:#df5000">"textarea"</span><span style="color:#0a9989"></span>&nbsp;<span style="color:#0a9989">global-editor</span>&nbsp;<span style="color:#0a9989">ng-height</span>=<span style="color:#df5000">"'200px'"</span><span style="color:#0a9989"></span>&nbsp;<span style="color:#0a9989">ng-width</span>=<span style="color:#df5000">"'800px'"</span><span style="color:#0a9989"></span><span style="color:#010101">&gt;</span><span style="color:#010101">&lt;</span><span style="color:#010101">/</span><span style="color:#066de2">textarea</span><span style="color:#010101">&gt;</span></div><div style="padding:0 6px; white-space:pre; line-height:130%"><span style="color:#010101">&lt;</span><span style="color:#066de2">textarea</span>&nbsp;<span style="color:#0a9989">ng-model</span>=<span style="color:#df5000">"textarea"</span><span style="color:#0a9989"></span>&nbsp;<span style="color:#0a9989">global-editor</span>=<span style="color:#df5000">"smarteditor&nbsp;또는&nbsp;ck-editor"</span><span style="color:#0a9989"></span>&nbsp;<span style="color:#0a9989">ng-height</span>=<span style="color:#df5000">"'200px'"</span><span style="color:#0a9989"></span>&nbsp;<span style="color:#0a9989">ng-width</span>=<span style="color:#df5000">"'800px'"</span><span style="color:#0a9989"></span><span style="color:#010101">&gt;</span><span style="color:#010101">&lt;</span><span style="color:#010101">/</span><span style="color:#066de2">textarea</span><span style="color:#010101">&gt;</span></div></div></td></tr></table></div>
			</div>
		</div>
		
		<div style="padding:12px;">
			<div class="definition">
				<h3>tab</h3>
				<p>tab은 아래의 스타일을 그대로 사용합니다.</p>
			</div>
			<div class="example">
				<span class="bt_all">
					<span data-ng-class="{active : param.menu_type == null || param.menu_type == ''}" class="active">
						<input type="button" value="탭1" data-ng-click="param.menu_type='';">
					</span>
					<span data-ng-class="{active : param.menu_type == '2'}">
						<input type="button" value="탭2" data-ng-click="param.menu_type='2';">
					</span>
					<span data-ng-class="{active : param.menu_type == '3'}">
						<input type="button" value="탭3" data-ng-click="param.menu_type='3';">
					</span>
				</span>
			</div>
			<div class="explanation">
				<div class="colorscripter-code" style="color:#010101; font-family:Consolas, 'Liberation Mono', Menlo, Courier, monospace !important; position:relative !important; overflow:auto"><table class="colorscripter-code-table" style="margin:0; padding:0; border:none; background-color:#fafafa; border-radius:4px;" cellspacing="0" cellpadding="0"><tr><td style="padding:6px 0"><div style="margin:0; padding:0; color:#010101; font-family:Consolas, 'Liberation Mono', Menlo, Courier, monospace !important; line-height:130%"><div style="padding:0 6px; white-space:pre; line-height:130%"><span style="color:#010101">&lt;</span><span style="color:#066de2">span</span>&nbsp;<span style="color:#0a9989">class</span>=<span style="color:#df5000">"bt_all"</span><span style="color:#0a9989"></span><span style="color:#010101">&gt;</span></div><div style="padding:0 6px; white-space:pre; line-height:130%">&nbsp;&nbsp;&nbsp;&nbsp;<span style="color:#010101">&lt;</span><span style="color:#066de2">span</span>&nbsp;<span style="color:#0a9989">data-ng-class</span>=<span style="color:#df5000">"{active&nbsp;:&nbsp;param.menu_type&nbsp;==&nbsp;null&nbsp;||&nbsp;param.menu_type&nbsp;==&nbsp;''}"</span><span style="color:#0a9989"></span>&nbsp;<span style="color:#0a9989">class</span>=<span style="color:#df5000">"active"</span><span style="color:#0a9989"></span><span style="color:#010101">&gt;</span><span style="color:#010101">&lt;</span><span style="color:#066de2">input</span>&nbsp;<span style="color:#0a9989">type</span>=<span style="color:#df5000">"button"</span><span style="color:#0a9989"></span>&nbsp;<span style="color:#0a9989">value</span>=<span style="color:#df5000">"탭1"</span><span style="color:#0a9989"></span>&nbsp;<span style="color:#0a9989">data-ng-click</span>=<span style="color:#df5000">"param.menu_type='';"</span><span style="color:#0a9989"></span><span style="color:#010101">&gt;</span><span style="color:#010101">&lt;</span><span style="color:#010101">/</span><span style="color:#066de2">span</span><span style="color:#010101">&gt;</span></div><div style="padding:0 6px; white-space:pre; line-height:130%">&nbsp;&nbsp;&nbsp;&nbsp;<span style="color:#010101">&lt;</span><span style="color:#066de2">span</span>&nbsp;<span style="color:#0a9989">data-ng-class</span>=<span style="color:#df5000">"{active&nbsp;:&nbsp;param.menu_type&nbsp;==&nbsp;'2'}"</span><span style="color:#0a9989"></span><span style="color:#010101">&gt;</span><span style="color:#010101">&lt;</span><span style="color:#066de2">input</span>&nbsp;<span style="color:#0a9989">type</span>=<span style="color:#df5000">"button"</span><span style="color:#0a9989"></span>&nbsp;<span style="color:#0a9989">value</span>=<span style="color:#df5000">"탭2"</span><span style="color:#0a9989"></span>&nbsp;<span style="color:#0a9989">data-ng-click</span>=<span style="color:#df5000">"param.menu_type='2';"</span><span style="color:#0a9989"></span><span style="color:#010101">&gt;</span><span style="color:#010101">&lt;</span><span style="color:#010101">/</span><span style="color:#066de2">span</span><span style="color:#010101">&gt;</span></div><div style="padding:0 6px; white-space:pre; line-height:130%">&nbsp;&nbsp;&nbsp;&nbsp;<span style="color:#010101">&lt;</span><span style="color:#066de2">span</span>&nbsp;<span style="color:#0a9989">data-ng-class</span>=<span style="color:#df5000">"{active&nbsp;:&nbsp;param.menu_type&nbsp;==&nbsp;'3'}"</span><span style="color:#0a9989"></span><span style="color:#010101">&gt;</span><span style="color:#010101">&lt;</span><span style="color:#066de2">input</span>&nbsp;<span style="color:#0a9989">type</span>=<span style="color:#df5000">"button"</span><span style="color:#0a9989"></span>&nbsp;<span style="color:#0a9989">value</span>=<span style="color:#df5000">"탭3"</span><span style="color:#0a9989"></span>&nbsp;<span style="color:#0a9989">data-ng-click</span>=<span style="color:#df5000">"param.menu_type='3';"</span><span style="color:#0a9989"></span><span style="color:#010101">&gt;</span><span style="color:#010101">&lt;</span><span style="color:#010101">/</span><span style="color:#066de2">span</span><span style="color:#010101">&gt;</span></div><div style="padding:0 6px; white-space:pre; line-height:130%"><span style="color:#010101">&lt;</span><span style="color:#010101">/</span><span style="color:#066de2">span</span><span style="color:#010101">&gt;</span></div></div></td><td style="vertical-align:bottom; padding:0 2px 4px 0"></td></tr></table></div>
			</div>
		</div>
		
		<div style="padding:12px;">
			<div class="definition">
				<h3>작은버튼[아이콘]</h3>
				<p>button에 'bt_small' 클래스와 사용하고 싶은 아이콘이 정의된 클래스를 함께 적어 사용합니다. 아이콘과 별게로 원하는 버튼명을 자유롭게 지정할 수 있습니다. value값은 버튼명에 영향을 미치진 않습니다.</p>
				<p>주로 테이블 안에서 추가적인 기능을 동작할 때 사용하는 스타일입니다.</p>
			</div>
			<div class="example">
				<div>
					<button value="추가" class="bt_small add">추가</button>
					<button value="수정" class="bt_small modify">수정</button>
					<button value="페이지담당설정" class="bt_small page">페이지담당설정</button>
					<button value="페이지권한설정" class="bt_small page2">페이지권한설정</button>
				</div>
				<div>
					<button value="삭제" class="bt_small delete">삭제</button>
					<button value="완전삭제" class="bt_small delete2">완전삭제</button>
					<button value="정보삭제" class="bt_small delete3">정보삭제</button>
					<button value="탈퇴" class="bt_small withdrawal">탈퇴</button>
				</div>
				<div>
					<button value="초기화" class="bt_small refresh">초기화</button>
					<button value="로그보기" class="bt_small log">로그보기</button>
					<button value="바로가기" class="bt_small move">바로가기</button>
					<button value="검색" class="bt_small search">검색</button>
					<button value="보기" class="bt_small view">보기</button>
					<button value="권한보기" class="bt_small authority">권한보기</button>
					<button value="발송하기" class="bt_small mail">발송하기</button>
					<button value="이동추적" class="bt_small chase">이동추적</button>
					<button value="코드추가" class="bt_small code">코드추가</button>
				</div>
				<div>
					<button value="로그아웃" class="bt_small logout">로그아웃</button>
					<button value="휴면해제" class="bt_small sleep">휴면해제</button>
					<button value="잠금해제" class="bt_small lock">잠금해제</button>
					<button value="탈퇴철회" class="bt_small recover">탈퇴철회</button>
				</div>
			</div>
			<div class="explanation">
				<div class="colorscripter-code" style="color:#010101; font-family:Consolas, 'Liberation Mono', Menlo, Courier, monospace !important; position:relative !important; overflow:auto"><table class="colorscripter-code-table" style="margin:0; padding:0; border:none; background-color:#fafafa; border-radius:4px;" cellspacing="0" cellpadding="0"><tbody><tr><td style="padding:6px 0"><div style="margin:0; padding:0; color:#010101; font-family:Consolas, 'Liberation Mono', Menlo, Courier, monospace !important; line-height:130%"><div style="padding:0 6px; white-space:pre; line-height:130%"><span style="color:#010101">&lt;</span><span style="color:#066de2">button</span>&nbsp;<span style="color:#0a9989">value</span>=<span style="color:#df5000">"추가"</span><span style="color:#0a9989"></span>&nbsp;<span style="color:#0a9989">class</span>=<span style="color:#df5000">"bt_small&nbsp;add"</span><span style="color:#0a9989"></span><span style="color:#010101">&gt;</span>추가<span style="color:#010101">&lt;</span><span style="color:#010101">/</span><span style="color:#066de2">button</span><span style="color:#010101">&gt;</span></div><div style="padding:0 6px; white-space:pre; line-height:130%"><span style="color:#010101">&lt;</span><span style="color:#066de2">button</span>&nbsp;<span style="color:#0a9989">value</span>=<span style="color:#df5000">"수정"</span><span style="color:#0a9989"></span>&nbsp;<span style="color:#0a9989">class</span>=<span style="color:#df5000">"bt_small&nbsp;modify"</span><span style="color:#0a9989"></span><span style="color:#010101">&gt;</span>수정<span style="color:#010101">&lt;</span><span style="color:#010101">/</span><span style="color:#066de2">button</span><span style="color:#010101">&gt;</span></div><div style="padding:0 6px; white-space:pre; line-height:130%"><span style="color:#010101">&lt;</span><span style="color:#066de2">button</span>&nbsp;<span style="color:#0a9989">value</span>=<span style="color:#df5000">"페이지담당설정"</span><span style="color:#0a9989"></span>&nbsp;<span style="color:#0a9989">class</span>=<span style="color:#df5000">"bt_small&nbsp;page"</span><span style="color:#0a9989"></span><span style="color:#010101">&gt;</span>페이지담당설정<span style="color:#010101">&lt;</span><span style="color:#010101">/</span><span style="color:#066de2">button</span><span style="color:#010101">&gt;</span></div><div style="padding:0 6px; white-space:pre; line-height:130%"><span style="color:#010101">&lt;</span><span style="color:#066de2">button</span>&nbsp;<span style="color:#0a9989">value</span>=<span style="color:#df5000">"페이지권한설정"</span><span style="color:#0a9989"></span>&nbsp;<span style="color:#0a9989">class</span>=<span style="color:#df5000">"bt_small&nbsp;page2"</span><span style="color:#0a9989"></span><span style="color:#010101">&gt;</span>페이지권한설정<span style="color:#010101">&lt;</span><span style="color:#010101">/</span><span style="color:#066de2">button</span><span style="color:#010101">&gt;</span></div></div></td></tr></tbody></table></div>
				<br />
				<div class="colorscripter-code" style="color:#010101; font-family:Consolas, 'Liberation Mono', Menlo, Courier, monospace !important; position:relative !important; overflow:auto"><table class="colorscripter-code-table" style="margin:0; padding:0; border:none; background-color:#fafafa; border-radius:4px;" cellspacing="0" cellpadding="0"><tbody><tr><td style="padding:6px 0"><div style="margin:0; padding:0; color:#010101; font-family:Consolas, 'Liberation Mono', Menlo, Courier, monospace !important; line-height:130%"><div style="padding:0 6px; white-space:pre; line-height:130%"><span style="color:#010101">&lt;</span><span style="color:#066de2">button</span>&nbsp;<span style="color:#0a9989">value</span>=<span style="color:#df5000">"삭제"</span><span style="color:#0a9989"></span>&nbsp;<span style="color:#0a9989">class</span>=<span style="color:#df5000">"bt_small&nbsp;delete"</span><span style="color:#0a9989"></span><span style="color:#010101">&gt;</span>삭제<span style="color:#010101">&lt;</span><span style="color:#010101">/</span><span style="color:#066de2">button</span><span style="color:#010101">&gt;</span></div><div style="padding:0 6px; white-space:pre; line-height:130%"><span style="color:#010101">&lt;</span><span style="color:#066de2">button</span>&nbsp;<span style="color:#0a9989">value</span>=<span style="color:#df5000">"완전삭제"</span><span style="color:#0a9989"></span>&nbsp;<span style="color:#0a9989">class</span>=<span style="color:#df5000">"bt_small&nbsp;delete2"</span><span style="color:#0a9989"></span><span style="color:#010101">&gt;</span>완전삭제<span style="color:#010101">&lt;</span><span style="color:#010101">/</span><span style="color:#066de2">button</span><span style="color:#010101">&gt;</span></div><div style="padding:0 6px; white-space:pre; line-height:130%"><span style="color:#010101">&lt;</span><span style="color:#066de2">button</span>&nbsp;<span style="color:#0a9989">value</span>=<span style="color:#df5000">"정보삭제"</span><span style="color:#0a9989"></span>&nbsp;<span style="color:#0a9989">class</span>=<span style="color:#df5000">"bt_small&nbsp;delete3"</span><span style="color:#0a9989"></span><span style="color:#010101">&gt;</span>정보삭제<span style="color:#010101">&lt;</span><span style="color:#010101">/</span><span style="color:#066de2">button</span><span style="color:#010101">&gt;</span></div><div style="padding:0 6px; white-space:pre; line-height:130%"><span style="color:#010101">&lt;</span><span style="color:#066de2">button</span>&nbsp;<span style="color:#0a9989">value</span>=<span style="color:#df5000">"탈퇴"</span><span style="color:#0a9989"></span>&nbsp;<span style="color:#0a9989">class</span>=<span style="color:#df5000">"bt_small&nbsp;withdrawal"</span><span style="color:#0a9989"></span><span style="color:#010101">&gt;</span>탈퇴<span style="color:#010101">&lt;</span><span style="color:#010101">/</span><span style="color:#066de2">button</span><span style="color:#010101">&gt;</span></div></div></td></tr></tbody></table></div>
				<br />
				<div class="colorscripter-code" style="color:#010101; font-family:Consolas, 'Liberation Mono', Menlo, Courier, monospace !important; position:relative !important; overflow:auto"><table class="colorscripter-code-table" style="margin:0; padding:0; border:none; background-color:#fafafa; border-radius:4px;" cellspacing="0" cellpadding="0"><tbody><tr><td style="padding:6px 0"><div style="margin:0; padding:0; color:#010101; font-family:Consolas, 'Liberation Mono', Menlo, Courier, monospace !important; line-height:130%"><div style="padding:0 6px; white-space:pre; line-height:130%"><span style="color:#010101">&lt;</span><span style="color:#066de2">button</span>&nbsp;<span style="color:#0a9989">value</span>=<span style="color:#df5000">"초기화"</span><span style="color:#0a9989"></span>&nbsp;<span style="color:#0a9989">class</span>=<span style="color:#df5000">"bt_small&nbsp;refresh"</span><span style="color:#0a9989"></span><span style="color:#010101">&gt;</span>초기화<span style="color:#010101">&lt;</span><span style="color:#010101">/</span><span style="color:#066de2">button</span><span style="color:#010101">&gt;</span></div><div style="padding:0 6px; white-space:pre; line-height:130%"><span style="color:#010101">&lt;</span><span style="color:#066de2">button</span>&nbsp;<span style="color:#0a9989">value</span>=<span style="color:#df5000">"로그보기"</span><span style="color:#0a9989"></span>&nbsp;<span style="color:#0a9989">class</span>=<span style="color:#df5000">"bt_small&nbsp;log"</span><span style="color:#0a9989"></span><span style="color:#010101">&gt;</span>로그보기<span style="color:#010101">&lt;</span><span style="color:#010101">/</span><span style="color:#066de2">button</span><span style="color:#010101">&gt;</span></div><div style="padding:0 6px; white-space:pre; line-height:130%"><span style="color:#010101">&lt;</span><span style="color:#066de2">button</span>&nbsp;<span style="color:#0a9989">value</span>=<span style="color:#df5000">"바로가기"</span><span style="color:#0a9989"></span>&nbsp;<span style="color:#0a9989">class</span>=<span style="color:#df5000">"bt_small&nbsp;move"</span><span style="color:#0a9989"></span><span style="color:#010101">&gt;</span>바로가기<span style="color:#010101">&lt;</span><span style="color:#010101">/</span><span style="color:#066de2">button</span><span style="color:#010101">&gt;</span></div><div style="padding:0 6px; white-space:pre; line-height:130%"><span style="color:#010101">&lt;</span><span style="color:#066de2">button</span>&nbsp;<span style="color:#0a9989">value</span>=<span style="color:#df5000">"검색"</span><span style="color:#0a9989"></span>&nbsp;<span style="color:#0a9989">class</span>=<span style="color:#df5000">"bt_small&nbsp;search"</span><span style="color:#0a9989"></span><span style="color:#010101">&gt;</span>검색<span style="color:#010101">&lt;</span><span style="color:#010101">/</span><span style="color:#066de2">button</span><span style="color:#010101">&gt;</span></div><div style="padding:0 6px; white-space:pre; line-height:130%"><span style="color:#010101">&lt;</span><span style="color:#066de2">button</span>&nbsp;<span style="color:#0a9989">value</span>=<span style="color:#df5000">"보기"</span><span style="color:#0a9989"></span>&nbsp;<span style="color:#0a9989">class</span>=<span style="color:#df5000">"bt_small&nbsp;view"</span><span style="color:#0a9989"></span><span style="color:#010101">&gt;</span>보기<span style="color:#010101">&lt;</span><span style="color:#010101">/</span><span style="color:#066de2">button</span><span style="color:#010101">&gt;</span></div><div style="padding:0 6px; white-space:pre; line-height:130%"><span style="color:#010101">&lt;</span><span style="color:#066de2">button</span>&nbsp;<span style="color:#0a9989">value</span>=<span style="color:#df5000">"권한보기"</span><span style="color:#0a9989"></span>&nbsp;<span style="color:#0a9989">class</span>=<span style="color:#df5000">"bt_small&nbsp;authority"</span><span style="color:#0a9989"></span><span style="color:#010101">&gt;</span>권한보기<span style="color:#010101">&lt;</span><span style="color:#010101">/</span><span style="color:#066de2">button</span><span style="color:#010101">&gt;</span></div><div style="padding:0 6px; white-space:pre; line-height:130%"><span style="color:#010101">&lt;</span><span style="color:#066de2">button</span>&nbsp;<span style="color:#0a9989">value</span>=<span style="color:#df5000">"발송하기"</span><span style="color:#0a9989"></span>&nbsp;<span style="color:#0a9989">class</span>=<span style="color:#df5000">"bt_small&nbsp;mail"</span><span style="color:#0a9989"></span><span style="color:#010101">&gt;</span>발송하기<span style="color:#010101">&lt;</span><span style="color:#010101">/</span><span style="color:#066de2">button</span><span style="color:#010101">&gt;</span></div><div style="padding:0 6px; white-space:pre; line-height:130%"><span style="color:#010101">&lt;</span><span style="color:#066de2">button</span>&nbsp;<span style="color:#0a9989">value</span>=<span style="color:#df5000">"이동추적"</span><span style="color:#0a9989"></span>&nbsp;<span style="color:#0a9989">class</span>=<span style="color:#df5000">"bt_small&nbsp;chase"</span><span style="color:#0a9989"></span><span style="color:#010101">&gt;</span>이동추적<span style="color:#010101">&lt;</span><span style="color:#010101">/</span><span style="color:#066de2">button</span><span style="color:#010101">&gt;</span></div><div style="padding:0 6px; white-space:pre; line-height:130%"><span style="color:#010101">&lt;</span><span style="color:#066de2">button</span>&nbsp;<span style="color:#0a9989">value</span>=<span style="color:#df5000">"코드추가"</span><span style="color:#0a9989"></span>&nbsp;<span style="color:#0a9989">class</span>=<span style="color:#df5000">"bt_small&nbsp;code"</span><span style="color:#0a9989"></span><span style="color:#010101">&gt;</span>코드추가<span style="color:#010101">&lt;</span><span style="color:#010101">/</span><span style="color:#066de2">button</span><span style="color:#010101">&gt;</span></div></div></td></tr></tbody></table></div>
				<br />
				<div class="colorscripter-code" style="color:#010101; font-family:Consolas, 'Liberation Mono', Menlo, Courier, monospace !important; position:relative !important; overflow:auto"><table class="colorscripter-code-table" style="margin:0; padding:0; border:none; background-color:#fafafa; border-radius:4px;" cellspacing="0" cellpadding="0"><tbody><tr><td style="padding:6px 0"><div style="margin:0; padding:0; color:#010101; font-family:Consolas, 'Liberation Mono', Menlo, Courier, monospace !important; line-height:130%"><div style="padding:0 6px; white-space:pre; line-height:130%"><span style="color:#010101">&lt;</span><span style="color:#066de2">button</span>&nbsp;<span style="color:#0a9989">value</span>=<span style="color:#df5000">"로그아웃"</span><span style="color:#0a9989"></span>&nbsp;<span style="color:#0a9989">class</span>=<span style="color:#df5000">"bt_small&nbsp;logout"</span><span style="color:#0a9989"></span><span style="color:#010101">&gt;</span>로그아웃<span style="color:#010101">&lt;</span><span style="color:#010101">/</span><span style="color:#066de2">button</span><span style="color:#010101">&gt;</span></div><div style="padding:0 6px; white-space:pre; line-height:130%"><span style="color:#010101">&lt;</span><span style="color:#066de2">button</span>&nbsp;<span style="color:#0a9989">value</span>=<span style="color:#df5000">"휴면해제"</span><span style="color:#0a9989"></span>&nbsp;<span style="color:#0a9989">class</span>=<span style="color:#df5000">"bt_small&nbsp;sleep"</span><span style="color:#0a9989"></span><span style="color:#010101">&gt;</span>휴면해제<span style="color:#010101">&lt;</span><span style="color:#010101">/</span><span style="color:#066de2">button</span><span style="color:#010101">&gt;</span></div><div style="padding:0 6px; white-space:pre; line-height:130%"><span style="color:#010101">&lt;</span><span style="color:#066de2">button</span>&nbsp;<span style="color:#0a9989">value</span>=<span style="color:#df5000">"잠금해제"</span><span style="color:#0a9989"></span>&nbsp;<span style="color:#0a9989">class</span>=<span style="color:#df5000">"bt_small&nbsp;lock"</span><span style="color:#0a9989"></span><span style="color:#010101">&gt;</span>잠금해제<span style="color:#010101">&lt;</span><span style="color:#010101">/</span><span style="color:#066de2">button</span><span style="color:#010101">&gt;</span></div><div style="padding:0 6px; white-space:pre; line-height:130%"><span style="color:#010101">&lt;</span><span style="color:#066de2">button</span>&nbsp;<span style="color:#0a9989">value</span>=<span style="color:#df5000">"탈퇴철회"</span><span style="color:#0a9989"></span>&nbsp;<span style="color:#0a9989">class</span>=<span style="color:#df5000">"bt_small&nbsp;recover"</span><span style="color:#0a9989"></span><span style="color:#010101">&gt;</span>탈퇴철회<span style="color:#010101">&lt;</span><span style="color:#010101">/</span><span style="color:#066de2">button</span><span style="color:#010101">&gt;</span></div></div></td></tr></tbody></table></div>
			</div>
		</div>
		
		<div style="padding:12px;">
			<div class="definition">
				<h3>작은버튼[아이콘  없음]</h3>
				<p>a태그에 'btalls'스타일로 사용합니다.</p>
				<p>테이블안에서 아이콘 지정이 불필요한 경우 사용하는 간단한 버튼 스타일입니다. 2가지 스타일이 있습니다.</p>
			</div>
			<div class="example">
				<div>
					<a class="btalls">스타일1</a>
				</div>
				<div>
					<a class="btalls2">스타일2</a>
				</div>
			</div>
			<div class="explanation">
				<div class="colorscripter-code" style="color:#010101; font-family:Consolas, 'Liberation Mono', Menlo, Courier, monospace !important; position:relative !important; overflow:auto"><table class="colorscripter-code-table" style="margin:0; padding:0; border:none; background-color:#fafafa; border-radius:4px;" cellspacing="0" cellpadding="0"><tr><td style="padding:6px 0"><div style="margin:0; padding:0; color:#010101; font-family:Consolas, 'Liberation Mono', Menlo, Courier, monospace !important; line-height:130%"><div style="padding:0 6px; white-space:pre; line-height:130%"><span style="color:#010101">&lt;</span><span style="color:#066de2">a</span>&nbsp;<span style="color:#0a9989">class</span>=<span style="color:#df5000">"btalls"</span><span style="color:#0a9989"></span><span style="color:#010101">&gt;</span>스타일1<span style="color:#010101">&lt;</span><span style="color:#010101">/</span><span style="color:#066de2">a</span><span style="color:#010101">&gt;</span></div><div style="padding:0 6px; white-space:pre; line-height:130%"><span style="color:#010101">&lt;</span><span style="color:#066de2">a</span>&nbsp;<span style="color:#0a9989">class</span>=<span style="color:#df5000">"btalls2"</span><span style="color:#0a9989"></span><span style="color:#010101">&gt;</span>스타일2<span style="color:#010101">&lt;</span><span style="color:#010101">/</span><span style="color:#066de2">a</span><span style="color:#010101">&gt;</span></div></div></td></tr></table></div>
			</div>
		</div>
		
	</div>
</body>
</html>