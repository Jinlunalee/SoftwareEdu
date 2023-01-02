<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		<title>Software Education Training Institute</title>

		<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" />
		<script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.min.js"></script>
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js"></script>

		<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common/app.css"/>
	</head>
	<body>
		<div class="d-flex flex-column vh-100" style="background-color:#e8eff5;">
			<nav class="navbar navbar-white bg-white text-white font-weight-bold">
				<a class="navbar-brand" href="<c:url value='/'/>"> 
					<img class="logo-header" src="${pageContext.request.contextPath}/resources/images/logo_header.png">
					소프트웨어 교육 연수원 - 관리시스템
				</a>
				<div class="nav-list"><a href="<c:url value='/subject/courselist'/>">강좌 관리</a></div>
				<div class="nav-list"><a href="<c:url value='/student/list'/>">수강생 관리</a></div>						
				<div class="nav-list"><a href="<c:url value='/enroll/list'/>">수강 관리</a></div>
				<div class="nav-list"><a href="<c:url value='/survey/list'/>">강의 만족도 조사 관리</a></div>
				<div class="nav-list"><a href="<c:url value='/data/download'/>">연계 자료 관리</a></div>
				<div>
					<div>
						<a class="btn btn-sm" href="#" style="background-color: #8db2ff; color:white;">로그인</a>
						<a class="btn btn-sm" href="#" style="background-color: #8db2ff; color:white;">로그아웃</a>
					</div>
				</div>
			</nav>
			<div class="container-fluid">
				<div class="h-100">
					<div class="p-3">
						<div class=" h-100 d-flex flex-column">
							<div class="main-content"style="height: 100%">