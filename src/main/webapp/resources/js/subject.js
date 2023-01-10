/*파일 누르면 이름 들어가게*/
$(function(){
	$("#file").on('change',function(){
		console.log("change");
		var fileName = $("#file").val();
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

/*강좌변화에 따라 비동기로 데이터 출력*/
$(function(){
	$('#subjectId, #courseId').on('change',function(){
		const courseId = $('#courseId').val();
		const subjectId = $('#subjectId').val();
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
				let level = $('#level');
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
				level.empty();
				cost.empty();
				support.empty();

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

				if(courseId === ""){ //과정없을때 (선택안했을때)
					printHours.append("("+result.subjectInfo.hours+"시간)");
					hours.val(result.subjectInfo.hours);

					if(!result.subjectInfo.levelEtc){//난이도 기타값이 null일때
						level.append(result.subjectInfo.level);
					}else{
						level.append(result.subjectInfo.level+"("+result.subjectInfo.levelEtc+")");
					}

					cost.append(result.subjectInfo.cost+"원");

					if(result.subjectInfo.supportYn === 'Y'){
						support.append("※교육비 지원을 받는 강좌입니다.");
					}
				} else { //과정있을때 (1. 최조개설 2.개설되어있는 과정)
					if(result.courseInfo === null) { //최초개설(과정에대한 정보가 없으면)
						console.log("최초개설");

						printHours.append("("+result.subjectInfo.hours+"시간)");
						hours.val(result.subjectInfo.hours);
						if(!result.subjectInfo.levelEtc){//난이도 기타값이 null일때
							level.append(result.subjectInfo.level);
						}else{
							level.append(result.subjectInfo.level+"("+result.subjectInfo.levelEtc+")");
						}
						cost.append(result.subjectInfo.cost+"원");
						if(result.subjectInfo.supportYn === 'Y'){
							support.append("※교육비 지원을 받는 강좌입니다.");
						}
					}else { //개설되어있는 경우(과정에대한 정보가 있을때)
						console.log("result: "+result);//리스트 몇개 넘어오는지 확인
						//result[0]은 과정에 대한 정보, result[1]은 강좌에 대한 정보
						console.log("개설되어있는 경우");

						// 과정안에 담겨있는 강좌 데이터 저장
						let ajaxCheckList = [];
						for(var i=0;i<result.checkList.length;i++){
							ajaxCheckList.push(result.checkList[i].subjectId);
						}
						console.log(options);
						console.log(ajaxCheckList);

						//ajaxCheckList랑 options비교해서 비활성화
						for(var i=0;i<options.length;i++){
							for(var j=0;j<ajaxCheckList.length;j++){
								if(options[i] === ajaxCheckList[j]){
									console.log(ajaxCheckList[j]);
									$("select option[value="+options[i]).attr('disabled', true);
								}
							}
						}

						//과정 정보 입력
						let date = parse(result.courseInfo.endDay);
						startDay.val(date); // 과정안에서 다른 강좌 끝나는날 시작
						ajaxEnd = date;

						//startDay의 min을 endDay로 지정 (과정이 개설되어있는경우에만 필요) -- 아직안됨
						console.log("endDay: "+ date);
						startDay.attr('value', date);
						console.log("startDay"+startDay.val());

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
						console.log('result[1].hours:'+result.subjectInfo.hours);
						printHours.append("("+result.subjectInfo.hours+"시간)");
						hours.val(result.subjectInfo.hours);
						if(!result.subjectInfo.levelEtc){//난이도 기타값이 null일때
							level.append(result.subjectInfo.level);
						}else{
							level.append(result.subjectInfo.level+"("+result.subjectInfo.levelEtc+")");
						}
						cost.append(result.subjectInfo.cost+"원");
						if(result.subjectInfo.supportYn === 'Y'){
							support.append("※교육비 지원을 받는 강좌입니다.");
						}
					}
				}
			},
			error: function(){
				console.log("fail");
			}
		})

	});
});

/*과정안에 들어있는 강좌 비활성화*/
function disabledCourse(courseId, list){

}

// $(function(){
// 	$('#subjectId, #courseId').on('change',function(){
// 		const courseId = $('#courseId').val();
// 		const subjectId = $('#subjectId').val();
// 		$.ajax({
// 			type: "get",
// 			url: "ajax?courseId="+courseId+"&subjectId="+subjectId,
// 			data: {
// 				// subjectId: subjectId,
// 			},
// 			success: function(result) {
// 				console.log("subjectId: "+subjectId);
// 				console.log("courseId:"+courseId);

// 				let startTime = $('#startTime');
// 				let endTime = $('#endTime');
// 				let startDay = $('#startDay');
// 				let endDay = $('#endDay');
// 				let recruitStartDay = $('#recruitStartDay');
// 				let recruitEndDay = $('#recruitEndDay');
// 				let printHours = $('#printHours');
// 				let printDay = $('#printDay');
// 				let hours = $('#hours');
// 				let level = $('#level');
// 				let cost = $('#cost');
// 				let support = $('.support');

// 				startTime.val('');
// 				endTime.val('');
// 				startDay.val('');
// 				endDay.val('');
// 				recruitStartDay.val('');
// 				recruitStartDay.removeAttr('max'); //연수시작이 바뀌면 selectRecruitDay 실행으로 max생김
// 				recruitEndDay.val('');
// 				recruitEndDay.removeAttr('max'); 
// 				recruitEndDay.removeAttr('min');
// 				printHours.empty();
// 				printDay.empty();
// 				level.empty();
// 				cost.empty();
// 				support.empty();


// 				if(courseId === ""){ //과정없을때 (선택안했을때)
// 					printHours.append("("+result[0].hours+"시간)");
// 					hours.val(result[0].hours);

// 					if(!result[0].levelEtc){//난이도 기타값이 null일때
// 						level.append(result[0].level);
// 					}else{
// 						level.append(result[0].level+"("+result[0].levelEtc+")");
// 					}

// 					cost.append(result[0].cost+"원");

// 					if(result[0].supportYn === 'Y'){
// 						support.append("※교육비 지원을 받는 강좌입니다.");
// 					}
// 				} else { //과정있을때 (1. 최조개설 2.개설되어있는 과정)
// 					if(!result[0].recruitStartDay) { //신청일자가 존재하지 않음 -> 최초개설
// 						console.log("최초개설")
// 						printHours.append("("+result[0].hours+"시간)");
// 						hours.val(result[0].hours);
// 						if(!result[0].levelEtc){//난이도 기타값이 null일때
// 							level.append(result[0].level);
// 						}else{
// 							level.append(result[0].level+"("+result[0].levelEtc+")");
// 						}
// 						cost.append(result[0].cost+"원");
// 						if(result[0].supportYn === 'Y'){
// 							support.append("※교육비 지원을 받는 강좌입니다.");
// 						}
// 					}else { //개설되어있는 경우
// 						console.log("result: "+result);//리스트 몇개 넘어오는지 확인
// 						//result[0]은 과정에 대한 정보, result[1]은 강좌에 대한 정보
// 						console.log("개설되어있는 경우");

// 						//과정 정보 입력
// 						let date = parse(result[0].endDay);
// 						startDay.val(date); // 과정안에서 다른 강좌 끝나는날 시작
// 						ajaxEnd = date;

// 						//startDay의 min을 endDay로 지정 (과정이 개설되어있는경우에만 필요) -- 아직안됨
// 						console.log("endDay: "+ date);
// 						startDay.attr('value', date);
// 						console.log("startDay"+startDay.val());

// 						date = parse(result[0].startDay);
// 						ajaxStart = date;

// 						date = parse(result[0].recruitStartDay);
// 						recruitStartDay.val(date);
// 						ajaxRecruitStart = date;

// 						date = parse(result[0].recruitEndDay);
// 						recruitEndDay.val(date);
// 						ajaxRecruitEnd = date;

// 						startDay.change();

// 						//강좌 정보 입력
// 						console.log('result[1].hours:'+result[1].hours);
// 						printHours.append("("+result[1].hours+"시간)");
// 						hours.val(result[1].hours);
// 						if(!result[1].levelEtc){//난이도 기타값이 null일때
// 							level.append(result[1].level);
// 						}else{
// 							level.append(result[1].level+"("+result[1].levelEtc+")");
// 						}
// 						cost.append(result[1].cost+"원");
// 						if(result[1].supportYn === 'Y'){
// 							support.append("※교육비 지원을 받는 강좌입니다.");
// 						}
// 					}
// 				}
// 			},
// 			error: function(){
// 				console.log("fail");
// 			}
// 		})

// 	});
// });

/*날짜format*/
function parse(str){
	let y = str.substring(0,4);
	let m = str.substring(4,6);
	let d = str.substring(6);
	return y+'-'+m+'-'+d;
}

/*첨부파일 이미지 미리보기*/
function previewImg(input) {
	if(input.files && input.files[0]){
		var reader = new FileReader();
		reader.onload = function(e) {
			document.querySelector('.detail_img').src = e.target.result;
		};
		reader.readAsDataURL(input.files[0]);
	}else {
		document.querySelector('.detail_img').src = "";
	}
}

/*select 두개 연계 (필요X)*/
function courseChange(e){
	var course1 = ["AI가 대신 만들어주는 앱", "자바 기초"];
	var course2 = ["한번에 끝내는 HTML","두번만에 끝내는 CSS", "세번해도 안끝나는 JS"];
	var target = document.querySelector(".select_smallCourse");

	if(e.value == "a") var d = course1;
	else if(e.value == "b") var d = course2;

	target.options.length = 0;

	for(x in d) {
		var opt = document.createElement("option");
		console.log(d[x]);
		opt.value = d[x];
		opt.innerHTML = d[x];
		target.appendChild(opt);
	}
}

/*jquery timepicker 사용해서 30분단위로 보이도록 커스텀*/
$('input.timepicker').timepicker({
	timeFormat: 'HH:mm',
	interval: 30,
	startTime: '09:00',
	minTime: '9',
	maxTime: '11:00pm',
	dynamic: false,
	dropdown: true,
	scrollbar: true,
	change: calcEndDay
});


/*시수에 맞춰 endDay 설정해주기, startTime, endTime변환시*/
function calcEndDay(){
	const startDay = document.getElementById("startDay").value;
		var startDay2 = new Date(startDay);
		const startTime = document.getElementById("startTime").value;
		const endTime = document.getElementById("endTime").value;
		const printDay = document.getElementById("printDay");
		let endDay = document.getElementById("endDay");

		printDay.innerHTML = ''; //비울때는 =

		if(startTime !== '' && endTime !== ''){
			console.log('start');
			let hours = document.getElementById("hours").value;

			let startHour = parseInt(startTime.substring(0,2));
			let startMin = parseInt(startTime.substring(3))
			let endHour = parseInt(endTime.substring(0,2));
			let endMin = parseInt(endTime.substring(3));

			let diffHour = endHour - startHour;
			let diffMin = 0;
			if(endMin < startMin){
				diffMin = (endMin - startMin) + 60;
				diffHour = diffHour - 1;
			}else{
				diffMin = endMin - startMin;
			}
			diffMin = Math.ceil(diffMin/60 * 100) / 100; //소수점 두자리 변환

			let diffTime = diffHour+diffMin; // 시작시간과 끝시간 계산

			let days = Math.ceil(parseInt(hours) / diffTime); // 일수 = 시수/입력한 시간차이

			startDay2.setDate(startDay2.getDate() + days);
			
			endDay.val = '';
			endDay.value = startDay2.toJSON().substring(0,10);

			//일수 출력
			printDay.innerText += "("+days+"일)"; //추가해주는거라 +=
		}
}


/*연수시작기간 수정시, 끝나는 기간도 같이 수정*/
function updateTime(){
	const startTime = document.getElementById("startTime");
	// const endTime = document.getElementById("endTime");
	
}

/*신청기간 지정*/
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

}

/*오늘날짜와 기간들 비교해서 모집상태 입력*/
function inputState(){
	const date = new Date();
	const today = parseInt(date.toJSON().substring(0,10).replaceAll('-',''));

	let recruitStartDay = parseInt(document.getElementById('recruitStartDay').value.replaceAll('-',''));
	let recruitEndDay = parseInt(document.getElementById('recruitEndDay').value.replaceAll('-',''));
	let state = document.getElementById('state');

	state.value = ''; //원래있던 상태 초기화
	console.log(state.value);

	if(today < recruitStartDay) { //현재날짜가 모집시작일 보다 작으면
		state.value = 'OPN01'; //모집예정
	}else if(recruitStartDay <= today && today <= recruitEndDay){
		state.value = 'OPN02'; //모집중
	}else{
		state.value = 'OPN03'; //모집마감
	}
	console.log(state.value);
}



