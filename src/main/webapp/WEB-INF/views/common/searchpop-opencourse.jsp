<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>검색 팝업</title>
<script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.min.js"></script>
<link rel="stylesheet" href="<c:url value='/resources/css/common/searchpop.css'/>"/>
</head>
<body>
    <div class="subject-name-warp">
        <span>과정 선택</span>
    </div>
    <div class="content-wrap">
            <!-- 게시물 표 영역 -->
            <div class="table-wrap">

                <!-- 검색 영역 -->
                <div class="search-wrap">
                    <form id="search-form">
                        <div class="search-input">
                            <select name="course" onchange="putNameonInput(this.value)" >
                                <option value="courseId">과정아이디</option>
                                <option value="courseTitle">과정명</option>
                            </select>
                            <input type="text" id="course-input" name="courseId">
                            상태 : 
                            <select name="openStateCd">
                                <option value="">전체</option>
                                <c:forEach items="${stateList}" var="state">
                                    <c:if test="${(state.comnCd eq 'OPN02') or (state.comnCd eq 'OPN03') or (state.comnCd eq 'OPN04')}">
                                    <option value="${state.comnCd}">${state.comnCdTitle}</option>
                                    </c:if>
                                </c:forEach>
                            </select>
                            분류 : 
                            <select name="catCourseCd">
                                <option value="">전체</option>
                                <c:forEach items="${catCourseList}" var="catCourse">
                                    <option value="${catCourse.comnCd}">${catCourse.comnCdTitle}</option>
                                </c:forEach>
                            </select>
                            등록년도 :
                            <select name="courseOpenYear">
                                <option value="0">전체</option>
                                <c:forEach var="i" begin="2019" end="2023">
                                    <option value="${i}">${i}</option>
                                </c:forEach>
                            </select>
                            <button type="button" id="search-btn" class='btn search-btn open-subject-search-btn'>검 색</button>
                        </div>
                    </form>
                    <!-- 과정에 이미 포함된 강좌 넘어온 값 -->
                    <div id="unavailable-pop" type="hidden">
                    </div>
                </div>

                <!-- 리스트 영역 -->
                <div class="list-wrap">
                    
                </div>
            </div>

</div>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/searchpop.js"></script>
</body>
</html>