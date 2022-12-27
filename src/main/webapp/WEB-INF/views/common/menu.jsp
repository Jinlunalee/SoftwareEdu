<%@ page contentType="text/html; charset=UTF-8"%>

<ul class="nav flex-column">
	<li class="nav-item mb-2">
		<h6 class="text-white">
			<span class="mr-2">Title.</span>
			<a class="text-white" href="#">강좌 관리</a>
			<ul>
				<li><a href="<c:url value='/course/regularlist'/>">과정 정보 확인</a></li>
				<li>새 과정 추가</li>
				<li>강좌 정보 확인</li>
				<li>강좌 등록</li>
				<li>
				<a href="#">개설 강좌 정보 확인</a>
					<div>
						<ul>
							<li><a href="<c:url value='/course/courselist'/>">개설 강좌 목록</a></li>
							<li><a href="">개설 강좌</a></li>
							<li><a href="">개설 강좌 목록</a></li>
						</ul>
					</div>
				</li>
				<li><a href="<c:url value='/course/insert'/>">강좌 개설</a></li>
				
				
				
				<li><a class="text-white" href="<c:url value='/course/regularlist'/>">과정목록</a></li>
				<li><a class="text-white" href="<c:url value='/register/list'/>">수강목록</a></li>
				<li><a class="text-white" href="<c:url value='/student/list'/>">수강생목록</a></li>
				<li><a class="text-white" href="<c:url value='/survey/list'/>">강의 만족도 조사 목록</a></li>
				<li><a class="text-white" href="<c:url value='/data/download'/>">연계 자료 다운</a></li>
			</ul>
		</h6>
	</li>	
</ul>