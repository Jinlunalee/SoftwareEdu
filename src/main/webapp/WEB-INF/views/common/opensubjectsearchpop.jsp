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
        <span>개설 강좌 선택</span>
    </div>
    <div class="content-wrap">
            <!-- 게시물 표 영역 -->
            <div class="table-wrap">

                <!-- 검색 영역 -->
                <div class="search-wrap">
                    <form id="search-form">
                        <div class="search-input">
                            <select name="subject" onchange="putNameonInput(this.value)" >
                                <option value="subjectId">강좌아이디</option>
                                <option value="subjectTitle">강좌명</option>
                            </select>
                            <input type="text" id="subject-input" name="subjectId">
                            난이도 : 
                            <select name="level">
                                <option value="">전체</option>
                                <c:forEach items="${levelList}" var="level">
                                    <option value="${level.comnCd}">${level.comnCdTitle}</option>
                                </c:forEach>
                            </select>
                            상태 : 
                            <select name="state">
                                <option value="">전체</option>
                                <c:forEach items="${stateList}" var="state">
                                    <option value="${state.comnCd}">${state.comnCdTitle}</option>
                                </c:forEach>
                            </select>
                            분류 : 
                            <select name="catSubject">
                                <option value="">전체</option>
                                <c:forEach items="${catSubjectList}" var="catSubject">
                                    <option value="${catSubject.comnCd}">${catSubject.comnCdTitle}</option>
                                </c:forEach>
                            </select>
                            </select>
                            등록년도 :
                            <select name="regYear">
                                <option value="0">전체</option>
                                <c:forEach var="i" begin="2019" end="2020">
                                    <option value="${i}">${i}</option>
                                </c:forEach>
                            </select>
                            <button type="button" id="search-btn" class='btn search-btn open-subject-search-btn'>검 색</button>
                        </div>
                    </form>
                </div>

                <!-- 리스트 영역 -->
                <div class="list-wrap">
                    
                </div>

                <form id="moveForm" action="/admin/authorPop" method="get">
                    <input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
                    <input type="hidden" name="amount" value="${pageMaker.cri.amount}">
                    <input type="hidden" name="keyword" value="${pageMaker.cri.keyword}">
                </form>               		
            </div>

</div>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/searchpop.js"></script>
</body>
</html>