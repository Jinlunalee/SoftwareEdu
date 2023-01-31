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

/*강좌변화후 #select-btn 버튼 클릭 시 비동기 데이터 출력*/
const selected = function() {
		const courseId = document.getElementById('courseId-input').value;
		const subjectId = document.getElementById('subjectId-input').value;
		console.log(courseId , subjectId);
		if(subjectId) {
			$.ajax({
				type: "get",
				url: "ajax?courseId="+courseId+"&subjectId="+subjectId,
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
		} else {
			alert('강좌를 선택 후 눌러주세요.');
		}
};

/*날짜format*/
function parse(str){
	let y = str.substring(0,4);
	let m = str.substring(4,6);
	let d = str.substring(6);
	return y+'-'+m+'-'+d;
}

/*select 두개 연계 (필요X)*/
// function courseChange(e){
// 	var course1 = ["AI가 대신 만들어주는 앱", "자바 기초"];
// 	var course2 = ["한번에 끝내는 HTML","두번만에 끝내는 CSS", "세번해도 안끝나는 JS"];
// 	var target = document.querySelector(".select_smallCourse");

// 	if(e.value == "a") var d = course1;
// 	else if(e.value == "b") var d = course2;

// 	target.options.length = 0;

// 	for(x in d) {
// 		var opt = document.createElement("option");
// 		console.log(d[x]);
// 		opt.value = d[x];
// 		opt.innerHTML = d[x];
// 		target.appendChild(opt);
// 	}
// }

/*jquery timepicker 사용해서 30분단위로 보이도록 커스텀*/
$('input#startTime').timepicker({
	timeFormat: 'HH:mm',
	interval: 30,
	startTime: '09:00',
	minTime: '9',
	maxTime: '11:00pm',
	dynamic: false,
	dropdown: true,
	scrollbar: true,
	disableTextInput: true,
	change: function(resultTime){ // 선택한 시간인 date 객체가 첫번째 인수로 전달됨
		// $('input#endTime').timepicker('option', 'minTime', resultTime);
		let endTimePicker = $('input#endTime').timepicker('getTime');
		console.log(resultTime);
		console.log(endTimePicker);
		timeMinMax(resultTime, endTimePicker);
	}
});

$('input#endTime').timepicker({
	timeFormat: 'HH:mm',
	interval: 30,
	startTime: '09:00',
	minTime: '9',
	maxTime: '11:00pm',
	dynamic: false,
	dropdown: true,
	scrollbar: true,
	disableTextInput: true,
	change: function(result){
		endTime = result;
		calcEndDay();
	}
	
});

/*시간 선후관계 설정*/
function timeMinMax(startTime, endTime){
	console.log("timeMinMax");
	$('input#endTime').timepicker('option', 'minTime', startTime);
	$('intput#startTime').timepicker('option', 'maxTime', endTime);
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
	
	printDay.innerHTML = ''; //비울때는 =

	if (startTime !== '' && endTime !== '') {
		console.log("start");
		let hours = document.getElementById("hours").value;

		let startHour = parseInt(startTime.substring(0, 2));
		let startMin = parseInt(startTime.substring(3))
		let endHour = parseInt(endTime.substring(0, 2));
		let endMin = parseInt(endTime.substring(3));

		let diffHour = endHour - startHour;
		let diffMin = 0;
		if (endMin < startMin) {
			diffMin = (endMin - startMin) + 60;
			diffHour = diffHour - 1;
		} else {
			diffMin = endMin - startMin;
		}
		diffMin = Math.ceil(diffMin / 60 * 100) / 100; //소수점 두자리 변환

		let diffTime = diffHour + diffMin; // 시작시간과 끝시간 계산

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
		recruitStartDay.value = ajaxRecruitStart;
		recruitStartDay.max = ajaxStart; //같은과정 연수 시작하기 전

		//신청끝나는일자
		recruitEndDay.value = ajaxRecruitEnd;
		recruitEndDay.min = recruitStartDay.value;
		recruitEndDay.max = ajaxStart;  //같은과정 연수 시작하기 전
		console.log(recruitStartDay.max);

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
	recruitStartDay.max = startDay;
	
	recruitEndDay.max = startDay;
	recruitEndDay.min = recruitStartDay.value;
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

/*페이지별 개수 선택 유지(subject) - ajax*/
function listCount(RowsPerPage) { // 검색 결과 리스트 출력
	console.log(RowsPerPage);
	$.ajax({
		url: "ajaxsubjectboardlist?strRowsPerPage="+RowsPerPage,
		type: "POST"
	}).done(function (result) {
		console.log('success');
		var html = jQuery('<div>').html(result); // div 요소의 내용을 지우고 result를넣음
		var contents = html.find('div#page-list').html(); //위의 html요소의 하위요소 중 ''를 선택해서 변수에 저장/끼워넣을 jsp
		$('#list-wrap').html(contents);//contents를 원래 jsp(subjectlist)에 넣음.
	}).fail(function(){
		console.log('fail');
	});
}

/*페이지별 개수 선택 유지(course) - ajax*/
function listCount2(RowsPerPage) { // 검색 결과 리스트 출력
	console.log(RowsPerPage);
	$.ajax({
		url: "ajaxcourseboardlist?strRowsPerPage="+RowsPerPage,
		type: "POST"
	}).done(function (result) {
		console.log('success');
		var html = jQuery('<div>').html(result); // div 요소의 내용을 지우고 result를넣음
		var contents = html.find('div#page-list').html(); //위의 html요소의 하위요소 중 ''를 선택
		$('#list-wrap').html(contents);//contents를 원래 jsp(subjectlist)에 넣음.
	}).fail(function(){
		console.log('fail');
	});
}