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
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common/menu.css"/>
		<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/menu.js"></script>
		<script src="https://code.jquery.com/jquery-3.6.2.js"></script>
		<script type="text/javascript">

		$(function() {
			const tag = '${menu}';

			const arrName = submenuNames[tag];
			const arrLink = submenuLinks[tag];
			
			for(let i=0, max = arrName.length; i<max; i++) {
				let line = '<div class="submenu-items aside-bar-submenu-' + i + '" onclick="Click(this)"><a href=' + submenuLinks[tag][i] + '>' + submenuNames[tag][i] + '</a></div>';
				$(".aside-bar-submenu").append(line);
			};
		});
		</script>
		
	</head>
	<body>
		<div class="d-flex flex-column vh-100" style="background-color:#e8eff5;">
			<nav class="navbar navbar-white bg-white text-white font-weight-bold">
				<a class="navbar-brand" href="<c:url value='/'/>"> 
					<img src="${pageContext.request.contextPath}/resources/images/logo-spring.png" width="30" height="30" class="d-inline-block align-top">
					소프트웨어 교육 연수원 - 관리시스템
				</a>
				<div class="nav-list" id="menu-1" onclick='clickMenu(this)'><a href="<c:url value='/course/regularlist'/>">강좌 관리</a></div>
				<div class="nav-list" id="menu-2" onclick='clickMenu(this)'><a href="<c:url value='/register/list'/>">수강 관리</a></div>						
				<div class="nav-list" id="menu-3" onclick='clickMenu(this)'><a href="<c:url value='/student/list'/>">수강생 관리</a></div>
				<div class="nav-list" id="menu-4" onclick='clickMenu(this)'><a href="<c:url value='/survey/list'/>">강의 만족도 조사 관리</a></div>
				<div class="nav-list" id="menu-5" onclick='clickMenu(this)'><a href="<c:url value='/data/download'/>">연계 자료 다운</a></div>
				<div>
					<div>
						<a class="btn btn-sm" href="#" style="background-color: #8db2ff; color:white;">로그인</a>
						<a class="btn btn-sm" href="#" style="background-color: #8db2ff; color:white;">로그아웃</a>
					</div>
				</div>
			</nav>
			<div class="flex-grow-1 container-fluid">
				<div class="row h-100">
					<div class="col-md-3" style="border: 1px solid #e8e8e8;padding: 0 !important;">
						<div class="h-100 d-flex flex-column">
							<div class="flex-grow-1" style="height: 0px; overflow-y: auto; overflow-x: hidden;">
								<%@ include file="/WEB-INF/views/common/menu.jsp" %>
							</div>
						</div>
					</div>
	
					<div class="col-md-9 p-3">
						<div class=" h-100 d-flex flex-column">
							<div class="flex-grow-1 overflow-auto pr-3" style="height: 0px">