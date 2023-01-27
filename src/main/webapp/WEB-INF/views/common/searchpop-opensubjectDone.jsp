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
                            <table border="1" style="width:100%;">
                                <colgroup>
                                    <col width="10%">
                                    <col width="30%">
                                    <col width="10%">
                                    <col width="20%">
                                    <col width="10%">
                                    <col width="20%">
                                </colgroup>
                                <tr>
                                    <td>
                                    <select name="subject" onchange="putNameonInput(this.value)" >
                                        <option value="subjectId">강좌아이디</option>
                                        <option value="subjectTitle">강좌명</option>
                                    </select>
                                    </td>
                                    <td>
                                        <input type="text" id="subject-input" name="subjectId">
                                    </td>
                                    <td>
                                        상태
                                    </td>
                                    <td>
                                        <select name="openStateCd">
                                            <option value="">전체</option>
                                            <c:forEach items="${stateList}" var="state">
                                                <option value="${state.comnCd}">${state.comnCdTitle}</option>
                                            </c:forEach>
                                        </select>
                                    </td>
                                    <td>
                                        분류
                                    </td>
                                    <td>
                                        <select name="catSubjectCd">
                                            <option value="">전체</option>
                                            <c:forEach items="${catSubjectList}" var="catSubject">
                                                <option value="${catSubject.comnCd}">${catSubject.comnCdTitle}</option>
                                            </c:forEach>
                                        </select>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        난이도
                                    </td>
                                    <td>
                                        <select name="levelCd">
                                            <option value="">전체</option>
                                            <c:forEach items="${levelList}" var="level">
                                                <option value="${level.comnCd}">${level.comnCdTitle}</option>
                                            </c:forEach>
                                        </select>
                                    </td>
                                    <td>
                                        등록년도
                                    </td>
                                    <td>
                                        <select name="regYear">
                                            <option value="0">전체</option>
                                            <c:forEach var="i" begin="2019" end="2023">
                                                <option value="${i}">${i}</option>
                                            </c:forEach>
                                        </select>
                                    </td>
                                    <td rowspan="2">
                                        <button type="button" id="search-btn" class='btn search-btn open-subject-search-btn'>검 색</button>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </form>
                </div>

                <!-- 리스트 영역 -->
                <div class="list-wrap">
                    
                </div>
            </div>

</div>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/searchpop.js"></script>
</body>
</html>