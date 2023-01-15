<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div id="result-list">
    <!-- 게시물 O -->
    <c:if test="${boardCheck != 'empty'}">
        <div class="table-exist">
            <table class="table">
                <thead>
                    <tr>
                        <td class="th-column-1">강좌아이디</td>
                        <td class="th-column-2">강좌명</td>
                        <td class="th-column-3">과정아이디</td>
                        <td class="th-column-4">과정명</td>
                        <td class="th-column-5">지원여부</td>
                        <c:if test="${board.level ne 'LEV04'}">
                            <td class="th-column-6">난이도</td>
                        </c:if>
                        <c:if test="${board.level eq 'LEV04'}">
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
                <c:forEach items="${boardList}" var="board">
                    <tr>
                        <td>${board.subjectId}</td>
                        <td>
                            <a class="move"  href="${board.subjectId}/${board.subjectSeq}/${board.regDt}" name="${board.subjectTitle}">
                                ${board.subjectTitle}
                            </a>
                        </td>
                        <td>${board.courseId}</td>
                        <td>${board.courseTitle}</td>
                        <td>${board.supportYn}</td>
                        <c:if test="${board.level ne 'LEV04'}">
                            <td>${board.levelTitle}</td>
                        </c:if>
                        <c:if test="${board.level eq 'LEV04'}">
                            <td>${board.levelEtc}</td>
                        </c:if>
                        <td>${board.days}</td>
                        <td>${board.hours}</td>
                        <td>${board.startDay}</td>
                        <td>${board.endDay}</td>
                        <td>${board.recruitStartDay}</td>
                        <td>${board.recruitEndDay}</td>
                        <td>${board.recruitPeople}</td>
                        <td>${board.comnCdTitle}</td>
                        <td>${board.catSubjectTitle}</td>
                        <td>${board.regDt}</td>
                    </tr>
                </c:forEach>
            </table>
        </div>                			
    </c:if>
    <!-- 게시물 x -->
    <c:if test="${boardCheck == 'empty'}">
        <div class="table-empty">
            개설된 강좌가 없습니다.
        </div>
    </c:if>
</div>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/searchpop.js"></script>