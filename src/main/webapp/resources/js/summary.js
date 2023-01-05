// subject에 따른 table chart 보여주기
function showTableChart(data) {
  console.log("showTableChart function working");

}

// subject에 따른 bar chart 보여주기
function showBarChart(data) {

}

var tableOptions = {
    series: [80, 55, 13, 43, 22],
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


var barOptions = {
    series: [{
    name: '매우만족',
    data: [70, 50, 80, 20, 21]
  }, {
    name: '만족',
    data: [53, 32, 33, 52, 13]
  }, {
    name: '보통',
    data: [12, 17, 11, 9, 15]
  }, {
    name: '불만족',
    data: [9, 7, 5, 8, 6]
  }, {
    name: '매우불만족',
    data: [25, 12, 19, 32, 25]
  }],
    chart: {
    type: 'bar',
    width: 500,
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
    categories: ['문항1', '문항2', '문항3', '문항4', '문항5'],
  },
  tooltip: {
    y: {
      formatter: function (val) {
        return val + "K"
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
