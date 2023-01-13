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
    <div class="subject_name_warp">
        <span>작가 선택</span>
    </div>
    <div class="content_wrap">
            <!-- 게시물 표 영역 -->
            <div class="author_table_wrap">
                <!-- 게시물 O -->
                <c:if test="${listCheck != 'empty'}">
                    <div class="table_exist">
                        <table class="author_table">
                            <thead>
                                <tr>
                                    <c:forEach var="board" items="${board}">
                                        <td class="th_column_1">강좌아이디</td>
                                        <td class="th_column_2">강좌명</td>
                                        <td class="th_column_3">분류</td>
                                        <td class="th_column_3">난이도</td>
                                        <td class="th_column_3">강좌등록년도</td>
                                    </c:forEach>
                                </tr>
                            </thead>
                            <c:forEach items="${list}" var="list">
                            <tr>
                                <td><c:out value="${list.authorId}"></c:out> </td>
                                <td><c:out value="${list.authorName}"></c:out></td>
                                <td><c:out value="${list.nationName}"></c:out> </td>
                            </tr>
                            </c:forEach>
                        </table>
                    </div>                			
                </c:if>
                <!-- 게시물 x -->
                <c:if test="${listCheck == 'empty'}">
                    <div class="table_empty">
                        등록된 작가가 없습니다.
                    </div>
                </c:if>

                <!-- 검색 영역 -->
                <div class="search_wrap">
                    <form id="searchForm" action="/admin/authorPop" method="get">
                        <div class="search_input">
                            <input type="text" name="keyword" value='<c:out value="${pageMaker.cri.keyword}"></c:out>'>
                            <input type="hidden" name="pageNum" value='<c:out value="${pageMaker.cri.pageNum }"></c:out>'>
                            <input type="hidden" name="amount" value='${pageMaker.cri.amount}'>
                            <button class='btn search_btn'>검 색</button>
                        </div>
                    </form>
                </div>
                
                <!-- 페이지 이동 인터페이스 영역 -->
                <div class="pageMaker_wrap" >
                
                    <ul class="pageMaker">
                    
                        <!-- 이전 버튼 -->
                        <c:if test="${pageMaker.prev}">
                            <li class="pageMaker_btn prev">
                                <a href="${pageMaker.pageStart - 1}">이전</a>
                            </li>
                        </c:if>
                        
                        <!-- 페이지 번호 -->
                        <c:forEach begin="${pageMaker.pageStart}" end="${pageMaker.pageEnd}" var="num">
                            <li class="pageMaker_btn ${pageMaker.cri.pageNum == num ? "active":""}">
                                <a href="${num}">${num}</a>
                            </li>
                        </c:forEach>
                        
                        <!-- 다음 버튼 -->
                        <c:if test="${pageMaker.next}">
                            <li class="pageMaker_btn next">
                                <a href="${pageMaker.pageEnd + 1 }">다음</a>
                            </li>
                        </c:if>
                        
                    </ul>
                    
                </div>               		
                <form id="moveForm" action="/admin/authorPop" method="get">
                    <input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
                    <input type="hidden" name="amount" value="${pageMaker.cri.amount}">
                    <input type="hidden" name="keyword" value="${pageMaker.cri.keyword}">
                </form>               		
    </div>

</div>
</body>
</html>