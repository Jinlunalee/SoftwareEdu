/* subject에 따른 table chart 보여주기 */
function showTableChart(data) {
  // 답변 값 총합의 변수 만듦
  let fiveStarSum=0;
  let fourStarSum=0;
  let threeStarSum=0;
  let twoStarSum=0;
  let oneStarSum=0;

  // 답변 값 총합 구하기
  for(let i=0; i<data.length; i++) {
    if(data[i]!==null){
      if(data[i].answerValue==5){
        fiveStarSum += data[i].countAnswerValue;
      } else if(data[i].answerValue==4){
        fourStarSum += data[i].countAnswerValue;
      } else if(data[i].answerValue==3){
        threeStarSum += data[i].countAnswerValue;
      } else if(data[i].answerValue==2){
        twoStarSum += data[i].countAnswerValue;
      } else if(data[i].answerValue==1){
        oneStarSum += data[i].countAnswerValue;
      }
    }
  }

  console.log(fiveStarSum + ' ' + fourStarSum + ' ' + threeStarSum + ' ' + twoStarSum + ' ' + oneStarSum);

  // table chart 실행
  var tableOptions = {
      series: [fiveStarSum, fourStarSum, threeStarSum, twoStarSum, oneStarSum],
      chart: {
      width: 500,
      type: 'pie',
    },
    labels: ['매우만족', '만족', '보통', '불만족', '매우불만족'],
    responsive: [{
      breakpoint: 480,
      options: {
        chart: {
          width: 200
        },
        legend: {
          position: 'top'
        }
      }
    }]
    };

    const chartTableLocation = opener.document.querySelector("#chart-table");
    var chartTable = new ApexCharts(chartTableLocation, tableOptions);
    chartTable.render();
}

  
/* subject에 따른 bar chart 보여주기 */
function showBarChart(data) {
  const questionCount = data.length/5;

  // 답변 값의 배열 만듦
  let fiveStarArr = new Array(questionCount);
  let fourStarArr = new Array(questionCount);
  let threeStarArr = new Array(questionCount);
  let twoStarArr = new Array(questionCount);
  let oneStarArr = new Array(questionCount);

  // 배열에 0 넣어놓기
  for(let k=0; k<questionCount; k++) {
    fiveStarArr[k] = 0;
    fourStarArr[k] = 0;
    threeStarArr[k] = 0;
    twoStarArr[k] = 0;
    oneStarArr[k] = 0;
  }

  // 문항 제목
  let titleArr = new Array();

  // 배열에 for문으로 데이터 입력
  for(let i=0; i<data.length; i++) {
    console.log(i, data[i]);
    if(data[i]!==null){
      if(data[i].answerValue==5){
        fiveStarArr[data[i].questionNum-1] += parseInt(data[i].countAnswerValue);
      } else if(data[i].answerValue==4){
        fourStarArr[data[i].questionNum-1] += parseInt(data[i].countAnswerValue);
      } else if(data[i].answerValue==3){
        threeStarArr[data[i].questionNum-1] += parseInt(data[i].countAnswerValue);
      } else if(data[i].answerValue==2){
        twoStarArr[data[i].questionNum-1] += parseInt(data[i].countAnswerValue);
      } else if(data[i].answerValue==1){
        oneStarArr[data[i].questionNum-1] += parseInt(data[i].countAnswerValue);
      }
      titleArr.push(data[i].questionContent);
    }
  }

  // title 배열 중복 제거 --> uniqueTitleArr
  let set = new Set(titleArr);
  let uniqueTitleArr = [...set];

  // table chart 실행
  var barOptions = {
      series: [{
      name: '매우만족',
      data: fiveStarArr
    }, {
      name: '만족',
      data: fourStarArr
    }, {
      name: '보통',
      data: threeStarArr
    }, {
      name: '불만족',
      data: twoStarArr
    }, {
      name: '매우불만족',
      data: oneStarArr
    }],
      chart: {
      type: 'bar',
      width: 600,
      stacked: true,
      stackType: '100%'
    },
    plotOptions: {
      bar: {
        horizontal: true,
      },
    },
    stroke: {
      width: 1,
      colors: ['#fff']
    },
    xaxis: {
      categories: uniqueTitleArr
    },
    tooltip: {
      y: {
        formatter: function (val) {
          return val
        }
      }
    },
    fill: {
      opacity: 1
    },
    legend: {
      position: 'top',
      offsetX: 40
    }
    };

    const chartBarLocation = opener.document.querySelector("#chart-bar");
    var chartBar = new ApexCharts(chartBarLocation, barOptions);
    chartBar.render();
}