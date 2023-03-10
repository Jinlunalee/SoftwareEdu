/* 선택완료 버튼 클릭 시 remove-hide 클래스에서 hide-first 클래스 삭제하기 */
function removeHideFirst() {
	const removeHide = document.getElementsByClassName('remove-hide');
	for(let i=0; i<removeHide.length; i++) {
		removeHide[i].classList.remove('hide-first')
	}
}

/* 초기화 버튼 클릭 시 선택한 값들 다 reset하기 */
function resetSelected() {
	// 강좌
	document.getElementById('subjectTitle-input').value=null;
	document.getElementById('subject-input').removeAttribute("value");
	document.getElementById('subjectId-input').removeAttribute("value");
	document.getElementById('subjectId-string').removeAttribute("value"); // 과정에 이미 포함된 강좌 넘어온 값
	// 과정
	document.getElementById('courseTitle-input').value=null;
	document.getElementById('course-input').removeAttribute("value");
	document.getElementById('courseId-input').removeAttribute("value");
	document.getElementById('courseId-string').removeAttribute("value"); // 과정에 이미 포함된 강좌 넘어온 값
	// remove-hide 클래스에 hide-first 클래스 다시 넣기
	const removeHide = document.getElementsByClassName('remove-hide');
	for(let i=0; i<removeHide.length; i++) {
		removeHide[i].classList.add('hide-first')
	}

}

/*파일 누르면 이름 들어가게*/
$(function(){
	$("#file").on('change',function(){
		var fileName = $("#file").val();
		fileName = fileName.substring(12);
		$(".insert_FileUpload").val(fileName);
	});
});

/*이미지 미리보기 기능 만들기 */
function previewImg(input) {
	//input 태그에 파일이 있는 경우
	if(input.files && input.files[0]){
		//FileReader 인스턴스 생성 -> FileReader()를 통해 이미지 로딩
		var reader = new FileReader();
		//이미지가 로드가 된 경우
		reader.onload = function(e) {
			document.querySelector('.detail_img').src = e.target.result;
		};
		//reader가 이미지 읽도록 하기
		reader.readAsDataURL(input.files[0]);
	}else {
		document.querySelector('.detail_img').src = "";
	}
}

var ajaxRecruitStart;
var ajaxRecruitEnd;
var ajaxStart;
var ajaxEnd;

/*과정필수인지 아닌지 확인*/
function chcekCourseOrSubject() {
	const courseId = document.getElementById('courseId-input').value;
	const subjectId = document.getElementById('subjectId-input').value;
	const check = document.getElementById('check').value;
	console.log(courseId , subjectId, check);

	if(check === "openCourse"){ //과정 필수
		if(courseId && subjectId){
			selected(courseId, subjectId);
			removeHideFirst()
		}else{
			// swal('','과정과 강좌 모두 선택 후 눌러주세요.', 'warning');
			alert("과정과 강좌 모두 선택 후 눌러주세요.");
		}
	}else{ //강좌만 필수
		if(subjectId){
			selected(courseId, subjectId);
			removeHideFirst()
		}else{
			// swal('','강좌 선택 후 눌러주세요.', 'warning');
			alert("강좌 선택 후 눌러주세요.");
		}
	}

}

/*강좌변화후 #select-btn 버튼 클릭 시 비동기 데이터 출력*/
const selected = function(courseId, subjectId) {
	// const courseId = document.getElementById('courseId-input').value;
	// const subjectId = document.getElementById('subjectId-input').value;
	// const check = document.getElementById('check').value;
	// console.log(courseId , subjectId, check);
	// if(subjectId) {
	const now = new Date();
	const year = String(now.getFullYear());
	console.log(year);
	$.ajax({
		type: "get",
		url: "ajax?courseId="+courseId+"&subjectId="+subjectId+"&year="+year,
		data: {
			// subjectId: subjectId,
		},
		success: function(result) {
			console.log("subjectId: "+subjectId);
			console.log("courseId:"+courseId);

			// console.log(JSON.stringify(result)); // result값 확인 
			// console.log(result.checkList); // map형식 데이터에서 key가 checkList인 값 가져오기
			// console.log(result.checkList[0].subjectId); //checkList 0번째의 subjectId가져오기

			let startTime = $('#startTime');
			let endTime = $('#endTime');
			let startDay = $('#startDay');
			let endDay = $('#endDay');
			let recruitStartDay = $('#recruitStartDay');
			let recruitEndDay = $('#recruitEndDay');
			let printHours = $('#printHours');
			let printDay = $('#printDay');
			let hours = $('#hours');
			let levelCd = $('#levelCd');
			let levelCdTitle = $('#levelCdTitle');
			let cost = $('#cost');
			let support = $('.support');

			startTime.val('');
			endTime.val('');
			startDay.val('');
			endDay.val('');
			recruitStartDay.val('');
			recruitStartDay.removeAttr('max'); //연수시작이 바뀌면 selectRecruitDay 실행으로 max생김
			recruitEndDay.val('');
			recruitEndDay.removeAttr('max'); 
			recruitEndDay.removeAttr('min');
			printHours.empty();
			printDay.empty();
			levelCd.val('');
			levelCdTitle.empty();
			cost.empty();
			support.empty();

			ajaxRecruitStart = null; //초기화 안하면 과정을 바꿨을때 그대로 값이 남아있음
			ajaxRecruitEnd = null;
			ajaxStart = null;
			ajaxEnd = null;

			// select option에 있는 모든value가져오기
			let options = $('#subjectId').find('option').map(function(){
				return this.value;
			}).get();

			//비활성화 되어있던 속성 제거 (초기화)
			for(var i=0;i<options.length;i++){
				//option의 0번부터 끝까지 초기화
				$('#subjectId option:eq('+i+')').prop('disabled', false);

				// $("select option[value="+options[i]).attr('disabled', false);
				// $("select#subjectId").val(options[i]).removeAttr('disabled')
				// $('#subjectId').val(options[i]).prop("disabled", false);
				// $('#subjectId').val(options[i]).removeAttr('disabled');
				// console.log("삭제"+$('#subjectId').val(options[i]).disabled);
			}

			if(courseId !== "" && result.courseInfo){ //과정이 개설되어있는 경우
				console.log("result: " + result);//리스트 몇개 넘어오는지 확인
				//result[0]은 과정에 대한 정보, result[1]은 강좌에 대한 정보
				console.log("개설되어있는 경우");

				/*
				// 과정안에 담겨있는 강좌 데이터 저장
				let ajaxCheckList = [];
				for (var i = 0; i < result.checkList.length; i++) {
					ajaxCheckList.push(result.checkList[i].subjectId);
				}
				console.log(options);
				console.log(ajaxCheckList);

				//ajaxCheckList랑 options비교해서 비활성화
				for (var i = 0; i < options.length; i++) {
					for (var j = 0; j < ajaxCheckList.length; j++) {
						if (options[i] === ajaxCheckList[j]) {
							console.log(ajaxCheckList[j]);
							$("select option[value=" + options[i]).attr('disabled', true);
						}
					}
				}
				*/

				//과정 정보 입력
				let date = parse(result.courseInfo.endDay);
				startDay.val(date); // 과정안에서 다른 강좌 끝나는날 시작
				startDay.attr('min', date);
				ajaxEnd = date;

				date = parse(result.courseInfo.startDay);
				ajaxStart = date;

				date = parse(result.courseInfo.recruitStartDay);
				recruitStartDay.val(date);
				ajaxRecruitStart = date;

				date = parse(result.courseInfo.recruitEndDay);
				recruitEndDay.val(date);
				ajaxRecruitEnd = date;

				startDay.change();

				//강좌 정보 입력
				console.log('result[1].hours:' + result.subjectInfo.hours);
				printHours.append("(" + result.subjectInfo.hours + "시간)");
				hours.val(result.subjectInfo.hours);
				if (!result.subjectInfo.levelEtc) {//난이도 기타값이 null일때
					// level.append(result.subjectInfo.level);
					levelCdTitle.append(result.subjectInfo.levelCdTitle);
					levelCd.val(result.subjectInfo.levelCd);
				} else {
					// level.append(result.subjectInfo.level+"("+result.subjectInfo.levelEtc+")");
					levelCdTitle.append(result.subjectInfo.levelCdTitle + "(" + result.subjectInfo.levelEtc + ")");
					levelCd.val(result.subjectInfo.levelCd);
				}
				cost.append(result.subjectInfo.cost.toLocaleString() + "원");
				if (result.subjectInfo.supportYn === 'Y') {
					support.append("※교육비 지원을 받는 강좌입니다.");
				}
			}else {
				console.log("과정 선택을 안했거나 최초개설인 경우");
				printHours.append("("+result.subjectInfo.hours+"시간)");
				hours.val(result.subjectInfo.hours);

				if(!result.subjectInfo.levelEtc){//난이도 기타값이 null일때
					// levelCd.append(result.subjectInfo.levelCd);
					levelCdTitle.append(result.subjectInfo.levelCdTitle);
					levelCd.val(result.subjectInfo.levelCd);
				}else{
					// levelCd.append(result.subjectInfo.levelCd+"("+result.subjectInfo.levelEtc+")");
					levelCdTitle.append(result.subjectInfo.levelCdTitle+"("+result.subjectInfo.levelEtc+")");
					levelCd.val(result.subjectInfo.levelCd);

				}

				cost.append(result.subjectInfo.cost.toLocaleString()+"원");

				if(result.subjectInfo.supportYn === 'Y'){
					support.append("※교육비 지원을 받는 강좌입니다.");
				}
			}
		},
		error: function(){
			console.log("fail");
		}
	})
	// } else {
	// 	console.log('강좌를 선택 후 눌러주세요.');
	// }
};

/*날짜format*/
function parse(str){
	let y = str.substring(0,4);
	let m = str.substring(4,6);
	let d = str.substring(6);
	return y+'-'+m+'-'+d;
}


/*시간 선후관계 설정*/
function timeMinMax(startTime, endTime) {
	console.log(startTime, endTime);	

	if(startTime){
		console.log("timeMinMax22 startTime");
		// select option에 있는 모든value가져오기
		let options = $('#endTime').find('option').map(function(){
			return this.value;
		}).get();

		//비활성화 되어있던 속성 제거 (초기화)
		for(var i=0;i<options.length;i++){
			//option의 0번부터 끝까지 초기화
			$('#endTime option:eq('+i+')').prop('disabled', false);
		}

		//선택된 startTime 가져오기
		let checkSelectTime = $("#startTime option:selected").val();

		//checkSelectTime랑 options비교해서 비활성화
		for (var i = 0; i < options.length; i++) {
			// $('#endTime option:eq(1)').prop('disabled', true); //9:00 비활성화 처리
			if (options[i] <= checkSelectTime) {
				// $('select#endTime option[value=' + options[i]+ ']').prop('disabled', true);
				// $("select#endTime").val(options[i]).prop("disabled", true);
				$('#endTime option:eq('+i+')').prop('disabled', true);
			}
		}
	}
	if(endTime){
		console.log("timeMinMax22 endTime");
		// select option에 있는 모든value가져오기
		let options = $('#startTime').find('option').map(function(){
			return this.value;
		}).get();

		//비활성화 되어있던 속성 제거 (초기화)
		for(var i=0;i<options.length;i++){
			//option의 0번부터 끝까지 초기화
			$('#startTime option:eq('+i+')').prop('disabled', false);
		}

		//선택된 endTime 가져오기
		let checkSelectTime = $("#endTime option:selected").val();

		// console.log(checkSelectTime);
		// console.log(options);

		//checkSelectTime랑 options비교해서 비활성화
		for (var i = 0; i < options.length; i++) {
			if (options[i] >= checkSelectTime) {
				$('#startTime option:eq('+i+')').prop('disabled', true);
			}
		}
		// $('#startTime option:eq(1)').prop('disabled', false); //9:00 비활성화 제거
	}
	
}

/*시수에 맞춰 endDay 설정해주기, startTime, endTime 변환시(onChange)*/
function calcEndDay(){
	console.log("calcEndDay");
	let startDay = document.getElementById("startDay").value;
	let startDay2 = new Date(startDay);
	let startTime = document.getElementById("startTime").value;
	let endTime = document.getElementById("endTime").value;
	let printDay = document.getElementById("printDay");
	let endDay = document.getElementById("endDay");
	let calcHours = document.getElementById("calcHours");
	
	printDay.innerHTML = ''; //비울때는 =
	calcHours.value = '';
	
	//시간 선후관계 비활성화
	timeMinMax(startTime, endTime);

	if (startTime !== '' && endTime !== '') {
		console.log("start");
		let hours = document.getElementById("hours").value;

		let startHour = parseInt(startTime.substring(0, 2));
		// let startMin = parseInt(startTime.substring(3))
		let endHour = parseInt(endTime.substring(0, 2));
		// let endMin = parseInt(endTime.substring(3));

		let diffHour = endHour - startHour;
		console.log(diffHour);
		if(6 <= diffHour && diffHour < 9 ){
			diffHour = diffHour - 1; //점심시간 제외
			console.log(diffHour);
		}else if(diffHour >= 9){
			diffHour = diffHour - 2; //점심,저녁시간 제외
			console.log(diffHour);
		}

		// let diffMin = 0;
		// if (endMin < startMin) {
		// 	diffMin = (endMin - startMin) + 60;
		// 	diffHour = diffHour - 1;
		// } else {
		// 	diffMin = endMin - startMin;
		// }
		// diffMin = Math.ceil(diffMin / 60 * 100) / 100; //소수점 두자리 변환

		// let diffTime = diffHour + diffMin; // 시작시간과 끝시간 계산

		let diffTime = diffHour; // 시작시간과 끝시간 계산

		let days = Math.ceil(parseInt(hours) / diffTime); // 일수 = 시수/입력한 시간차이

		startDay2.setDate(startDay2.getDate() + days); //시수계산한 날짜를 더해 endDay

		//휴일체크
		let resultDay = checkHoliday(startDay, startDay2.toJSON().substring(0, 10));

		// 휴일인만큼 날짜 더하기
		startDay2.setDate(startDay2.getDate() + resultDay); 
		// days += resultDay; 

		endDay.value = '';
		endDay.value = startDay2.toJSON().substring(0, 10);

		//일수 출력
		printDay.innerText += "(" + days + "일)"; //추가해주는거라 +=
		calcHours.value =days;
	}
}

/*기간내에 휴일 확인*/
function checkHoliday(startDay, endDay){
	console.log("checkHoliday!");
	let resultData;
	startDay = startDay.replaceAll("-","");
	endDay = endDay.replaceAll("-","");
	$.ajax({
		type: "get",
		url: "/subject/ajaxcheckholiday?startDay="+startDay+"&endDay="+endDay,
		async: false,
	}).done(function(result){
		console.log('success');
		resultData = result;

	}).fail(function(){
		console.log('fail');
	});

	return resultData;
}

/*신청기간 지정 - 처음에 입력했을때*/
function selectRecruitDay(){
	console.log("change startDay");
	const startDay = document.getElementById("startDay").value;
	let recruitStartDay = document.getElementById("recruitStartDay");
	let recruitEndDay = document.getElementById("recruitEndDay");

	if(ajaxRecruitStart){// 같은 과정이 있으면 그 과정의 신청기간을 들고와서 입력해줌
		//신청시작일자
		let ajaxStartDate = new Date(ajaxStart);
		ajaxStartDate.setDate(ajaxStartDate.getDate()-1);

		recruitStartDay.value = ajaxRecruitStart;
		// recruitStartDay.max = ajaxStart; //같은과정 연수 시작하기 전
		recruitStartDay.max = ajaxStartDate.toJSON().substring(0,10); //같은과정 연수 시작하기 전

		//신청끝나는일자
		recruitEndDay.value = ajaxRecruitEnd;
		recruitEndDay.min = recruitStartDay.value;
		// recruitEndDay.max = ajaxStart;  //같은과정 연수 시작하기 전
		recruitEndDay.max = ajaxStartDate.toJSON().substring(0,10);  //같은과정 연수 시작하기 전

		recruitStartDay.onchange();
		recruitEndDay.onchange();

	}else{//신청시작 == 연수시작 한달전, 신청끝 == 신청시작 + 2주 => 이경우는 과정이 없을때/과정이있지만 최초개설일떄

		//신청시작일자
		let rSDay = new Date(startDay);
		rSDay.setMonth(rSDay.getMonth()-1);
		recruitStartDay.value = rSDay.toJSON().substring(0,10);
		recruitStartDay.max = startDay;

		//신청끝나는일자
		rSDay.setDate(rSDay.getDate()+14);
		recruitEndDay.value = rSDay.toJSON().substring(0,10);
		recruitEndDay.min = recruitStartDay.value; // 신청시작일자 전까지
		recruitEndDay.max = startDay; //연수시작 시간날까지만 가능
		recruitEndDay.onchange(); //값이 바뀐 엘리먼트의 onchange 함수 실행
	}

	calcEndDay();

}

/*신청기간이 변경 */
function MinMaxChange(startDay, recruitStartDay, recruitEndDay){
	let startDate;
	//입력시랑 수정시에 따라서 다르게 
	pathArr = location.pathname.split('/');
	pathName = pathArr[2];
	if(pathName === 'insert'){ //입력시
		if(ajaxRecruitStart){ // 같은 과정이 있을때 
			let ajaxStartDate = new Date(ajaxStart);
			ajaxStartDate.setDate(ajaxStartDate.getDate()-1);

			recruitStartDay.max = ajaxStartDate.toJSON().substring(0,10); //같은과정 연수 시작하기 전

			recruitEndDay.max = ajaxStartDate.toJSON().substring(0,10); //같은과정 연수 시작하기 전
			if (recruitEndDay.value < recruitStartDay.value) { //모집기간 시작일이 모집기간 끝나는날보다 크면 
				recruitEndDay.value = recruitStartDay.value;
			}
			recruitEndDay.min = recruitStartDay.value;
		}else{ //같은 과정이 없을때
			startDate = new Date(startDay);
			startDate.setDate(startDate.getDate() - 1); // 강좌시작 하루전까지만 신청가능하도록
			recruitStartDay.max = startDate.toJSON().substring(0, 10);

			recruitEndDay.max = startDate.toJSON().substring(0, 10);
			if (recruitEndDay.value < recruitStartDay.value) { //모집기간 시작일이 모집기간 끝나는날보다 크면 
				recruitEndDay.value = recruitStartDay.value;
			}
			recruitEndDay.min = recruitStartDay.value;
		}
	}else if(pathName === 'update'){ //수정시 
		//같은 과정을 가진 시작날짜 가져오기
		const openCourseStartDay = document.getElementById("openCourseStartDay");
		if(openCourseStartDay.value){ //같은과정이 있을떄
			let csDate = new Date(parse(openCourseStartDay.value));
			csDate.setDate(csDate.getDate()-1);
			recruitStartDay.max = csDate.toJSON().substring(0,10); //같은과정 연수 시작하기 전

			recruitEndDay.max = csDate.toJSON().substring(0,10); //같은과정 연수 시작하기 전
			if (recruitEndDay.value < recruitStartDay.value) { //모집기간 시작일이 모집기간 끝나는날보다 크면 
				recruitEndDay.value = recruitStartDay.value;
			}
			recruitEndDay.min = recruitStartDay.value;
		}else{ //같은 과정이 없을때
			startDate = new Date(startDay);
			startDate.setDate(startDate.getDate() - 1); // 강좌시작 하루전까지만 신청가능하도록
			recruitStartDay.max = startDate.toJSON().substring(0, 10);

			recruitEndDay.max = startDate.toJSON().substring(0, 10);
			if (recruitEndDay.value < recruitStartDay.value) { //모집기간 시작일이 모집기간 끝나는날보다 크면 
				recruitEndDay.value = recruitStartDay.value;
			}
			recruitEndDay.min = recruitStartDay.value;
		}
	}
	
}

/*오늘날짜와 기간들 비교해서 모집상태 입력*/
function inputState(){
	console.log("change recruitStartDay, EndDay");

	const date = new Date();
	const today = parseInt(date.toJSON().substring(0,10).replaceAll('-',''));

	let startDay = document.getElementById("startDay").value;
	let recruitStartDay = document.getElementById('recruitStartDay');
	let recruitEndDay = document.getElementById('recruitEndDay');
	let state = document.getElementById('openStateCd');

	MinMaxChange(startDay,recruitStartDay,recruitEndDay); //신청기간 MINMAX 변경

	recruitStartDay = parseInt(recruitStartDay.value.replaceAll('-',''));
	recruitEndDay = parseInt(recruitEndDay.value.replaceAll('-',''));

	state.value = ''; //원래있던 상태 초기화

	if(today < recruitStartDay) { //현재날짜가 모집시작일 보다 작으면
		state.value = 'OPN01'; //모집예정
	}else if(recruitStartDay <= today && today <= recruitEndDay){
		state.value = 'OPN02'; //모집중
	}else{
		state.value = 'OPN03'; //모집마감
	}
	// console.log(state.value);
}



// /*페이지별 개수 선택 유지(subject) - ajax*/
// function listCount(RowsPerPage, subject, keyword) { // 검색 결과 리스트 출력
// 	console.log(RowsPerPage);
// 	$.ajax({
// 		url: "ajaxsubjectboardlist?strRowsPerPage="+RowsPerPage+"&subject="+subject+"&keyword="+keyword,
// 		type: "POST"
// 	}).done(function (result) {
// 		console.log('success');
// 		var html = jQuery('<div>').html(result); // div 요소의 내용을 지우고 result를넣음
// 		var contents = html.find('div#page-list').html(); //위의 html요소의 하위요소 중 ''를 선택해서 변수에 저장/끼워넣을 jsp
// 		$('#list-wrap').html(contents);//contents를 원래 jsp(subjectlist)에 넣음.
// 	}).fail(function(){
// 		console.log('fail');
// 	});
// }

// /*페이지별 개수 선택 유지(course) - ajax*/
// function listCount2(RowsPerPage, course, keyword) { // 검색 결과 리스트 출력
// 	console.log(RowsPerPage);
// 	$.ajax({
// 		url: "ajaxcourseboardlist?strRowsPerPage="+RowsPerPage+"&course="+course+"&keyword="+keyword,
// 		type: "POST"
// 	}).done(function (result) {
// 		console.log('success');
// 		var html = jQuery('<div>').html(result); // div 요소의 내용을 지우고 result를넣음
// 		var contents = html.find('div#page-list').html(); //위의 html요소의 하위요소 중 ''를 선택
// 		$('#list-wrap').html(contents);//contents를 원래 jsp(subjectlist)에 넣음.
// 	}).fail(function(){
// 		console.log('fail');
// 	});
// }