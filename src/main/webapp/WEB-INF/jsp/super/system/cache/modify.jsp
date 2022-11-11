<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<div class="contents" data-ng-cloak>
	    	    
	    <div class="solr_sch cache">
			<h6>캐시 데이터 삭제</h6>
			<p class="v2">메인페이지의 적용되어 있는 이미지 썸네일이나 게시글, 배너이미지등은 <b>약 5분의 간격으로 데이터를 갱신</b>하기 때문에 이미지 업로드나 게시글 설정 후 즉시 반영되지 않을 수 있습니다.<br />캐시 데이터 삭제를 통해 이미지 썸네일, 배너이미지, 게시글을 즉시 반영하시려면 캐시 데이터 삭제를 실행하세요.</p>
			<button value="검색 데이터 갱신" class="bt_small trash" data-ng-click="clearCache()">캐시삭제</button>
		</div>
	    
	</div>
