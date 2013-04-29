//= require highcharts
//= require highcharts/highcharts-more
function graph_chooser(tagid) {
    $('#chart-tabs a:first').tab('show');
    $("a[href='#bubble-chart']").click(initialize_bubblechart(tagid));
    $("a[href='#bar-chart']").click(initialize_barchart(tagid));
  }
function initialize_barchart(tagid) {
  $.get('/dashboard/chart_data/' + tagid+ '.csv', function(data) {
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
              click: function open_new_tab(e) {
                e.preventDefault();
                window.location.href = this.options.url,target="_newtab"
              }
            }
          }
        }
      },
      series:  []
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

function initialize_bubblechart(tagid) {
 $.get('/dashboard/chart_data/' + tagid + '.csv', function(data) { 
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
    plotOptions: {
        series: {
          cursor: 'pointer',
          point: {
            events: {
              click: function() {
                window.location.href = this.options.url,target="_newtab" ;
              }
            }
          }
        }
      },
    series: []
  };
    var lines = data.split('\n');
    $.each(lines, function(lineNo, line) {
      if (line == "") return;
      var items = line.split(',');      
      var series = {
        name: items[0],
        data: [{y: parseInt(items[1]),x:parseInt(items[2]), url: '/ideas/' + items[2]}]
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