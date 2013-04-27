//= require highcharts
//= require highcharts/highcharts-more

function initialize_barchart() {
  var tag_id = 6;
  
  $.get('/dashboard/chart_data/' + tag_id + '.csv', function(data) {
    var options = {
      chart: {
        renderTo: 'bar-chart',
        defaultSeriesType: 'column'
      },
      title: {
        text: 'Number of votes'
      },
      xAxis: {
        categories: []
      },
      yAxis: {
        title: {
          text: 'Units'
        }
      },
      plotOptions: {
        series: {
          cursor: 'pointer',
          point: {
            events: {
              click: function() {
                location.href = this.options.url;
              }
            }
          }
        }
      },
      series:  []
      /*{name: "Boogie",
      data: [{y:1, url: "http://google.com/?q=boogie"}]}, 

      {data: [{y:2}]},

      {data:[{y:3}]}
      ]*/
    };

    var lines = data.split('\n');
    $.each(lines, function(lineNo, line) {
      if (line == "") return;
      var items = line.split(',');      
      var series = {
        name: items[0],
        data: [{y: parseInt(items[1]), url: '/ideas/' + items[2]}]
      };

      options.series.push(series);
    });

    var chart = new Highcharts.Chart(options);
    console.log(options);
  });
}

function initialize_bubblechart() {
  var tag_id = 6;
  var options = {
    chart: {
      renderTo: 'bubble-chart',
      defaultSeriesType: 'bubble'
    },
    title: {
      text: 'Number of votes'
    },
    xAxis: {
      categories: []
    },
    yAxis: {
      title: {
        text: 'Units'
      }
    },
    series: []
  };
  $.get('/dashboard/chart_data/' + tag_id + '.csv', function(data) {
    var lines = data.split('\n');
    $.each(lines, function(lineNo, line) {
      if (line == "") return;
      var items = line.split(',');      
      var series = {
        name: items[0],
        data: [{y: parseInt(items[1]), url: '/ideas/' + items[2]}]
      };

      options.series.push(series);
    });

    var chart = new Highcharts.Chart(options);
    console.log(options);
  });
}  



// function columnurl(e, chart, data) { 
//   var selection = chart.getSelection();
//   var row = selection[0].row;
//   var column = selection[0].column;
//   var idea_no = data.getValue(row,0);
//   var title =data.getValue(column,row);
//   console.log(idea_no);
//   //$.getScript("/link_idea.js?&title="+title);
//   window.location.href='/ideas/' + idea_no;
// }


