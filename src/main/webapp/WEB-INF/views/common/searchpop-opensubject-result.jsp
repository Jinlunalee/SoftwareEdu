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
                        <td class="th-column-3">과정아이디</td>
                        <td class="th-column-4">과정명</td>
                        <td class="th-column-5">교육비 지원여부</td>
                        <c:if test="${board.levelCd ne 'LEV04'}">
                            <td class="th-column-6">난이도</td>
                        </c:if>
                        <c:if test="${board.levelCd eq 'LEV04'}">
                            <td class="th-column-6">난이도 기타</td>
                        </c:if>
                        <td class="th-column-7">수강일수</td>
                        <td class="th-column-8">수강시수</td>
                        <td class="th-column-9">강의 진행 기간</td>
                        <td class="th-column-10">강의 모집 기간</td>
                        <td class="th-column-11">모집인원</td>
                        <td class="th-column-12">상태</td>
                        <td class="th-column-13">분류</td>
                        <td class="th-column-14">개설일자</td>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${boardList}" var="board">
                        <tr>
                            <td>${board.subjectId}</td>
                            <td>
                                <a class="${board.openStateCd} ${board.subjectId}-${board.subjectSeq}" class="move" onclick="return moveOutside(event, this.name);" href="#" 
                                name="${board.subjectId}/${board.subjectSeq}/${board.subjectTitle}/${board.openDt}/${board.openStateCd}/
                                ${board.supportYn}/${board.levelCdTitle}/${board.levelEtc}/${board.days}/${board.hours}/${board.startDay}/${board.endDay}/
                                ${board.recruitStartDay}/${board.recruitEndDay}/${board.recruitPeople}/${board.openStateCdTitle}/${board.catSubjectCdTitle}">
                                ${board.subjectTitle}</a>
                            </td>
                            <td>${board.courseId}</td>
                            <td>${board.courseTitle}</td>
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
                            <td>${board.startDay} ~ ${board.endDay}</td>
                            <td>${board.recruitStartDay} ~ ${board.recruitEndDay}</td>
                            <td>${board.recruitPeople}</td>
                            <td>${board.openStateCdTitle}</td>
                            <td>${board.catSubjectCdTitle}</td>
                            <td>${board.openDt}</td>
                        </tr>
                    </c:forEach>
                </tbody>
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
