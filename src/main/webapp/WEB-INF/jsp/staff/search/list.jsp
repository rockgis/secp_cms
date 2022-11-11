<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tlds/StringUtil_fn.tld" prefix="suf" %>
<%@ taglib uri="/WEB-INF/tlds/DateUtil_fn.tld" prefix="dtf" %>
<%@ taglib prefix="sec"  uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>조직도</title>
<script type="text/javascript">
</script>
</head>
<body>

          
          <!-- 검색시작 -->
          <div class="search_box2">
            <form id="searchFrm" name="searchFrm" action="list.do" method="get">
			<input type="hidden" name="condition" value="member_nm"/>
			<fieldset>
			<legend>직원안내</legend>
              <div class="sf_1">
                <label for="search_lb">부서명</label>
                <select name="group_seq" class="top_select in_length200">
                  <option value="">부서명 전체</option>
	                <c:forEach var="item" items="${group_list }">
	                <option value="${item.group_seq }" <c:if test="${item.group_seq eq param.group_seq }">selected="selected"</c:if>><c:forEach begin="2" end="${item.level }">&nbsp;&nbsp;</c:forEach> ${item.group_nm }</option>
	              </c:forEach>
                </select>
                <label>
                <input type="checkbox" name="has_child" value="N" <c:if test="${param.has_child eq 'N' }">checked="checked"</c:if>>하위조직 멤버 미포함
                </label>
              </div>
              <div class="sf_2">
                <label for="search_lb2">직원명</label>
                <span class="in_t"><input type="text" id="serUserNm" class="in_s_box2" name="keyword" value="" title="검색어입력"></span>
                <span class="in_i"><input type="image" src="/images/sub/scv_search_btn.gif" alt="검색"></span>
				<span class="btn"><a href="../org_chart/list.do"><img src="/images/sub/org_view_btn.gif" alt=""></a></span>
              </div>
			  </fieldset>
            </form>
          </div>
          <!--// 검색끝 --> 
		
		${list }  

</body>
</html>