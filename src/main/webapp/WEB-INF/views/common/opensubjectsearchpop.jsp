<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>검색 팝업</title>
<link rel="stylesheet" href="<c:url value='/resources/css/common/searchpop.css'/>" />
</head>
<body>
    <div class="subject-name-warp">
        <span>작가 선택</span>
    </div>
    <div class="content-wrap">
            <!-- 게시물 표 영역 -->
            <div class="table-wrap">

                <!-- 검색 영역 -->
                <div class="search-wrap">
                    <form id="searchForm" action="<c:url value='/common/opensubjectsearchpop'/>" method="get">
                        <div class="search-input">
                            강좌아이디 : <input type="text" name="subjectId">
                            강좌명 : <input type="text" name="subjectTitle">
                            난이도 : <input type="text" name="level">
                            상태 : <input type="text" name="state">
                            분류 : <input type="text" name="catSubject">
                            등록년도 : <input type="text" name="regYear">
                            <button class='btn search-btn'>검 색</button>
                        </div>
                    </form>
                </div>

                <!-- 게시물 O -->
                <c:if test="${board != 'empty'}">
                    <div class="table-exist">
                        <table class="table">
                            <thead>
                                <tr>
                                    <td class="th-column-1">강좌아이디</td>
                                    <td class="th-column-2">강좌명</td>
                                    <td class="th-column-3">과정아이디</td>
                                    <td class="th-column-4">과정명</td>
                                    <td class="th-column-5">지원여부</td>
                                    <c:if test="board.level ne 'LEV04">
                                        <td class="th-column-6">난이도</td>
                                    </c:if>
                                    <c:if test="board.level eq 'LEV04">
                                        <td class="th-column-6">난이도 기타</td>
                                    </c:if>
                                    <td class="th-column-7">수강일수</td>
                                    <td class="th-column-8">수강시수</td>
                                    <td class="th-column-9">시작일자</td>
                                    <td class="th-column-10">종료일자</td>
                                    <td class="th-column-11">모집시작일자</td>
                                    <td class="th-column-12">모집종료일자</td>
                                    <td class="th-column-13">모집인원</td>
                                    <td class="th-column-14">상태</td>
                                    <td class="th-column-15">분류</td>
                                    <td class="th-column-16">등록일자</td>

                                </tr>
                            </thead>
                            <c:forEach items="${board}" var="boardList">
                            <tr>
                                <td><c:out value="${board.subjectId}"></c:out> </td>
                                <td><c:out value="${board.subjectTitle}"></c:out></td>
                                <td><c:out value="${board.courseId}"></c:out> </td>
                                <td><c:out value="${board.courseTitle}"></c:out> </td>
                                <td><c:out value="${board.supportYn}"></c:out> </td>
                                <td><c:out value="${board.level}"></c:out> </td>
                                <td><c:out value="${board.days}"></c:out> </td>
                                <td><c:out value="${board.hours}"></c:out> </td>
                                <td><c:out value="${board.startDay}"></c:out> </td>
                                <td><c:out value="${board.endDay}"></c:out> </td>
                                <td><c:out value="${board.recruitStartDay}"></c:out> </td>
                                <td><c:out value="${board.recruitEndDay}"></c:out> </td>
                                <td><c:out value="${board.state}"></c:out> </td>
                                <td><c:out value="${board.catSubject}"></c:out> </td>
                                <td><c:out value="${board.regDt}"></c:out> </td>
                            </tr>
                            </c:forEach>
                        </table>
                    </div>                			
                </c:if>
                <!-- 게시물 x -->
                <c:if test="${board == 'empty'}">
                    <div class="table-empty">
                        개설된 강좌가 없습니다.
                    </div>
                </c:if>
                
                <form id="moveForm" action="/admin/authorPop" method="get">
                    <input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
                    <input type="hidden" name="amount" value="${pageMaker.cri.amount}">
                    <input type="hidden" name="keyword" value="${pageMaker.cri.keyword}">
                </form>               		
            </div>

</div>
</body>
</html>