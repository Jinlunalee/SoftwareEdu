/* subject에 따른 table chart 보여주기 */
function showTableChart(data) {
  const questionCount = data.length/5; // 항목 수

  // 답변 값 총합의 변수 만듦
  let fiveStarSum=0;
  let fourStarSum=0;
  let threeStarSum=0;
  let twoStarSum=0;
  let oneStarSum=0;

  // 답변 값 총합 구하기
  for(let i=0; i<questionCount; i++) {
    fiveStarSum += data[5*i+5-1].countAnswerValue;
    fourStarSum += data[5*i+4-1].countAnswerValue;
    threeStarSum += data[5*i+3-1].countAnswerValue;
    twoStarSum += data[5*i+2-1].countAnswerValue;
    oneStarSum += data[5*i+1-1].countAnswerValue;
  }

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

    var chartTable = new ApexCharts(document.querySelector("#chart-table"), tableOptions);
    chartTable.render();
}

  
/* subject에 따른 bar chart 보여주기 */
function showBarChart(data) {
  const questionCount = data.length/5; // 항목 수

  // 답변 값의 배열 만듦
  let fiveStarArr = new Array();
  let fourStarArr = new Array();
  let threeStarArr = new Array();
  let twoStarArr = new Array();
  let oneStarArr = new Array();

  // 문항 제목
  let titleArr = new Array();

  // 배열에 for문으로 데이터 입력
  for(let i=0; i<questionCount; i++) {
    fiveStarArr.push(data[i*5+4].countAnswerValue);
    fourStarArr.push(data[i*5+3].countAnswerValue);
    threeStarArr.push(data[i*5+2].countAnswerValue);
    twoStarArr.push(data[i*5+1].countAnswerValue);
    oneStarArr.push(data[i*5].countAnswerValue);
    titleArr.push(data[i*5].questionContent);
  }

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
      categories: titleArr
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

    var chartBar = new ApexCharts(document.querySelector("#chart-bar"), barOptions);
    chartBar.render();
}