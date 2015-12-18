/*
  Reload the chart with the origin selected in the select option.
*/
function loadTransferChart() {
  var origin = $('#origin option:selected').val();

  var hours_path = '/api/1/pings/hours?origin=' + origin;
  $.getJSON(hours_path, function (data) {
    var chart = new Highcharts.Chart({
        chart: {
          renderTo: 'transfer_chart'
        },
        title: {
          text: 'Average Transfer Time Hourly',
          x: -20 //center
        },
        legend: {
          enabled: false
        },
        xAxis: {
          type: 'datetime'
        },
        yAxis: {
            title: {
                text: 'ms'
            },
        },
        series: [
          {
            name: 'Average Transfer Time Hourly',
            data: data
          }
        ]
    });
  });
}

$(function () {
  $("#origin").selectmenu({

    create: function( event, ui ) {
      var origins_path = '/api/1/pings/origins';
      $.getJSON(origins_path, function (data) {

        $.each(data, function(key, value) {   
             $('#origin')
                 .append($("<option></option>")
                 .attr("value", value)
                 .text(value)); 
        });

        if (data.length > 0) {
          // select first option
          $("#origin").val($("#origin option:first").val());
          $("#origin").selectmenu("refresh");

          // reload chart
          loadTransferChart();
        }
      });
    },

    change: function( event, ui ) {
      loadTransferChart();
    }
  });
});
