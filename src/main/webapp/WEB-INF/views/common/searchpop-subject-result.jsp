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
                        <td class="th-column-1">강좌아이디</td>
                        <td class="th-column-2">강좌명</td>
                        <td class="th-column-5">지원여부</td>
                        <c:if test="${board.level ne 'LEV04'}">
                            <td class="th-column-6">난이도</td>
                        </c:if>
                        <c:if test="${board.level eq 'LEV04'}">
                            <td class="th-column-6">난이도 기타</td>
                        </c:if>
                        <td class="th-column-7">수강일수</td>
                        <td class="th-column-8">수강시수</td>
                        <td class="th-column-15">분류</td>
                        <td class="th-column-16">등록년도</td>
                    </tr>
                </thead>
                <c:forEach items="${boardList}" var="board">
                    <tr>
                        <td>${board.subjectId}</td>
                        <td>
                            <a id="${board.subjectId}" class="move" onclick="return moveOutside(event, this.name);" href="#"  name="${board.subjectId}/${board.subjectSeq}/${board.subjectTitle}/${board.regYear}">
                                ${board.subjectTitle}
                            </a>
                        </td>
                        <td>
                            <c:if test="${board.supportYn eq 'Y'}">
                                지원가능
                            </c:if>
                            <c:if test="${board.supportYn eq 'N'}">
                                지원불가
                            </c:if>
                        </td>
                        <c:if test="${board.levelCd ne 'LEV04'}">
                            <td>${board.levelCdTitle}</td>
                        </c:if>
                        <c:if test="${board.levelCd eq 'LEV04'}">
                            <td>${board.levelEtc}</td>
                        </c:if>
                        <td>${board.days}</td>
                        <td>${board.hours}</td>
                        <td>${board.catSubjectCdTitle}</td>
                        <td>${board.regYear}</td>
                    </tr>
                </c:forEach>
            </table>
        </div>                			
    </c:if>
    <!-- 게시물 x -->
    <c:if test="${boardCheck == 'empty'}">
        <div class="table-empty">
            강좌가 없습니다.
        </div>
    </c:if>
</div>
