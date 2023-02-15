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
                    <!-- <div class="info">※ 개설 강좌는 '모집중', '모집마감', '진행중' 상태만 수강 추가할 수 있습니다. '진행중' 상태일 때는 강좌 시작 7일이내까지 수강 추가할 수 있습니다.</div> -->
                    <form id="search-form" onsubmit="return false;">
                        <div class="search-input">
                            <div class="search-section">
                                <span class="search-section-title">개설강좌</span>
                                <div class="search-section-content">
                                    <select name="subject" onchange="putNameonInput(this.value)" class="input-box select-box-short">
                                        <option value="subjectId">강좌아이디</option>
                                        <option value="subjectTitle">강좌명</option>
                                    </select>
                                    <input type="text" id="subject-input" name="subjectId" class="input-box">
                                </div>
                            </div>
                            <div class="search-section">
                                <span class="search-section-title">난이도</span>
                                <div class="search-section-content">
                                    <select name="levelCd" class="input-box select-box">
                                        <option value="">전체</option>
                                        <c:forEach items="${levelList}" var="level">
                                            <option value="${level.comnCd}">${level.comnCdTitle}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                            <div class="search-section">
                                <span class="search-section-title">상태</span>
                                <div class="search-section-content">
                                    <select name="openStateCd" class="input-box select-box">
                                        <option value="">전체</option>
                                        <c:forEach items="${stateList}" var="state">
                                            <option value="${state.comnCd}">${state.comnCdTitle}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                            <div class="search-section">
                                <span class="search-section-title">분류</span>
                                <div class="search-section-content">
                                    <select name="catSubjectCd" class="input-box select-box">
                                        <option value="">전체</option>
                                        <c:forEach items="${catSubjectList}" var="catSubject">
                                            <option value="${catSubject.comnCd}">${catSubject.comnCdTitle}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                            <div class="search-section">
                                <span class="search-section-title">개설연도</span>
                                <div class="search-section-content">
                                    <select name="openDtYear" class="input-box select-box">
                                        <option value="0">전체</option>
                                        <c:forEach items="${yearList}" var="year">
                                            <option value="${year}">${year}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                            <button type="button" id="search-btn" class="btn search-btn open-subject-search-btn input-button">검 색</button>
                            <button type="button" id="close-btn" class="input-button">창닫기</button>
                        </div>
                    </form>

                    <div class="info">※ 개설 강좌는 '모집중', '모집마감', '진행중' 상태만 수강 추가할 수 있습니다. '진행중' 상태일 때는 강좌 시작 7일이내까지 수강 추가할 수 있습니다.</div>

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