<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="contents_wrap">
	<div class="ct_wrap">
		<div class="conwrap_tap">
			<ul>
				<li id='contManagerTab' ng-if="param.permit=='Y'"><a href="<c:url value="/super/homepage/modifyFrm.do"/>?cms_menu_seq={{param.cms_menu_seq}}&amp;parent_menu_seq={{param.parent_menu_seq }}&amp;permit={{param.permit}}"><span>메뉴관리</span></a></li>
				<li class="on"><a href="${context_path }/super/homepage/intro/index.do?cms_menu_seq={{param.cms_menu_seq}}&amp;parent_menu_seq={{param.parent_menu_seq}}&amp;permit={{param.permit}}" target="_self"><span>프로그램관리</span></a></li>
			</ul>
		</div>
		<div class="contents">
		포털 소개개발화면<br />
		요청테스트URL : /super/intro/test.do<br />
		결과값 : {{data}}
		</div>
	</div>
</div>
