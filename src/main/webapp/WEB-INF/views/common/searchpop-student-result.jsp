<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.min.js"></script>
<div id="result-list">
    <!-- 게시물 O -->
    <c:if test="${boardCheck != 'empty'}">
        <div class="table-exist">
            <table class="table">
                <thead>
                    <tr>
                        <td class="th-column-1">수강생 명</td>
                        <td class="th-column-2">아이디</td>
                        <td class="th-column-5">생년월일</td>
                        <td class="th-column-6">성별</td>
                        <td class="th-column-6">이메일</td>
                        <td class="th-column-7">전화번호</td>
                        <td class="th-column-8">주소 도</td>
                        <td class="th-column-15">주소 상세</td>
                        <td class="th-column-16">지위</td>
                    </tr>
                </thead>
                <c:forEach items="${studentList}" var="student">
                    <tr>
                        <td>${student.name}</td>
                        <td>
                            <a id="${student.studentId}" class="move" onclick="return moveOutside(event, this.name);" href="#"  name="${student.studentId}/${student.name}">
                                ${student.studentId}
                            </a>
                        </td>
                        <td>${student.birth}</td>
                        <td>${student.genderCd}</td>
                        <td>${student.email}</td>
                        <td>${student.phone}</td>
                        <td>${student.addDoCd}</td>
                        <td>${student.addEtc}</td>
                        <td>${student.positionCd}</td>
                    </tr>
                </c:forEach>
            </table>
        </div>                         
    </c:if>
    <!-- 게시물 x -->
    <c:if test="${boardCheck == 'empty'}">
        <div class="table-empty">
            수강생이 없습니다.
        </div>
    </c:if>
</div>
