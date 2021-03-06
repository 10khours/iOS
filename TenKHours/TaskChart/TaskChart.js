var canvas = document.getElementById("task-chart");
canvas.width  = window.innerWidth;
canvas.height = window.innerHeight;
var ctx = canvas.getContext("2d");
var chart = new Chart(ctx);
var maxLables = 7;

function showChart(dates, times, color) {
    var labels = dates.split(',');
    var labelsLength = labels.length;
    var displayLabels = [];
    
    if (labelsLength > maxLables) {
        var displayLabelsStep = Math.round(labelsLength / maxLables);
        for (var i = 0; i < labelsLength; i++) {
            if (i % displayLabelsStep === 0) {
                displayLabels.push(labels[i]);
            } else {
                displayLabels.push('');
            }
        }
    } else {
        displayLabels = labels;
    }
    
    var dataInDataSets = times.split(',').map(Number);
    
    var data = {
    labels: displayLabels,
    datasets: [{
               fillColor: 'rgba(255,255,255,0.1)',
               strokeColor: color,
               pointColor: color,
               pointStrokeColor: '#333',
               data: dataInDataSets
               }]
    };
    
    var scaleSteps = 5;
    var scaleTotal = (Math.floor(dataInDataSets.slice(-1)[0] / 500) + 1) * 500;
    var scaleStepWidth = scaleTotal / scaleSteps;
    
    if (dataInDataSets.length === 1) {
        chart.Bar(data, {
                  pointDot: false,
                  scaleOverride: true,
                  scaleSteps: scaleSteps,
                  scaleStepWidth: scaleStepWidth,
                  scaleStartValue: 0,
                  barValueSpacing: 200
                  });
    }
    else if (dataInDataSets.length > 1) {
        chart.Line(data, {
                   pointDot: false,
                   scaleOverride: true,
                   scaleSteps: scaleSteps,
                   scaleStepWidth: scaleStepWidth,
                   scaleStartValue: 0
                   });
    }

};
