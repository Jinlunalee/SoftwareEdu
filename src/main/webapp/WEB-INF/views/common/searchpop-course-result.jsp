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
                        <td class="th-column-1">과정아이디</td>
                        <td class="th-column-2">과정명</td>
                        <td class="th-column-15">분류</td>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${boardList}" var="board">
                        <tr>
                            <td>${board.courseId}</td>
                            <td>
                                <a id="${board.courseId}" class="move" onclick="return moveOutside(event, this.name);" href="#" name="${board.courseId}/${board.catCourseCd}/${board.courseTitle}/${checkFirst}">
                                    ${board.courseTitle}
                                </a>
                            </td>
                            <td>${board.catCourseCdTitle}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>                			
    </c:if>
    <!-- 게시물 x -->
    <c:if test="${boardCheck == 'empty'}">
        <div class="table-empty">
            과정이 없습니다.
        </div>
    </c:if>
</div>
