<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>수강생 목록 팝업</title>
<script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.min.js"></script>
<link rel="stylesheet" href="<c:url value='/resources/css/common/searchpop.css'/>"/>
</head>
<body>
    <div class="subject-name-warp">
        <span>수강생 선택</span>
    </div>
    <div class="content-wrap">
            <!-- 게시물 표 영역 -->
            <div class="table-wrap">
                
                <!-- 검색 영역 -->
                <div class="search-wrap">
                    <form id="search-form" onsubmit="return false;">
                        <div class="search-input">
                            <div class="search-section">
                                <span class="search-section-title">수강생</span>
                                <div class="search-section-content">
                                    <select name="student" onchange="putNameonInput(this.value)" class="input-box select-box-short">
                                        <option value="name">수강생명</option>
                                        <option value="studentId">수강생아이디</option>
                                    </select>
                                    <input type="text" id="student-input" name="name" class="input-box">
                                </div>
                            </div>
                            
                            <button type="button" id="search-btn" class="btn search-btn open-subject-search-btn input-button">검 색</button>
                            <button type="button" id="close-btn" class="input-button">창닫기</button>
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