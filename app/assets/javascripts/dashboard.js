//= require highcharts
//= require highcharts/highcharts-more

function initialize_barchart() {
  var tag_id = 6;
  var options = {
    chart: {
        renderTo: 'bar-chart',
        defaultSeriesType: 'bar'
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
  console.log(data);
    var lines = data.split('\n');
    $.each(lines, function(lineNo, line) {
        var items = line.split(',');
        if (lineNo == 0) {
            $.each(items, function(itemNo, item) {
                if (itemNo > 0) options.xAxis.categories.push(item);
            });
        }
        else {
            var series = {
                data: []
            };
            $.each(items, function(itemNo, item) {
                if (itemNo == 0) {
                    series.name = item;
                } else {
                    series.data.push(parseFloat(item));
                }
            });
            options.series.push(series);
        }
        
    });
    
    // Create the chart
    var chart = new Highcharts.Chart(options);
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
  console.log(data);
    var lines = data.split('\n');
    $.each(lines, function(lineNo, line) {
        var items = line.split(',');
        if (lineNo == 0) {
            $.each(items, function(itemNo, item) {
                if (itemNo > 0) options.xAxis.categories.push(item);
            });
        }
        else {
            var series = {
                data: []
            };
            $.each(items, function(itemNo, item) {
                if (itemNo == 0) {
                    series.name = item;
                } else {
                    series.data.push(parseFloat(item));
                }
            });
            options.series.push(series);
        }
        
    });
    
    // Create the chart
    var chart = new Highcharts.Chart(options);
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

  
