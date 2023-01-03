 /* 입력값 추출하여 input태그 hidden타입으로 저장 */
    clostBtn.addEventListner('click', saveInputQuestions);
	
	function saveInputQuestions() {
		console.log("connected!");
		document.getElementsByClassName("hiddenInputs").style.display = "none";
		/* 입력값 추출 */
		// questionNumber로 배열 공간 만들기
		// var arr = [questionNumber];

		// //for문으로 입력값 배열에 저장하기
		// for(var i=0; i<questionNumber; i++) {
		// 	let questionClassName = "#question-set-" + i;
		// 	let question = document.querySelector("#question-set-i .question input")
		// 	let questionValue = question.innerText;
		// 	console.log(questionValue);
		// 	arr[i] = questionValue;
		// };

	    /* input태그 hidden타입으로 저장  */
		//for문으로 배열 털어서 어떠한 div에 hidden타입으로 저장하기
		for(var k=0; k<questionNumber; k++) {
			let hiddenInputNum = document.querySelector("#new-questions #question-inputNum-" + k)
			let hiddenInputSet = document.querySelector("#new-questions #question-inputSet-" + k)
			$(hiddenInputNum).clone().appendTo('.hidden-inputs');
			$(hiddenInputSet).clone().appendTo('.hidden-inputs');
		};

    }
    

