function weatherDisplay(data) {
  Highcharts.chart(data['section'], {
    chart: { type: 'columnrange', inverted: true },
    title: { text: data['section'] + ' Variation' },
    subtitle: { text: '' },
    xAxis: { categories: data['date_range'] },
    yAxis: { title: { text: data['section'] } },
    tooltip: { valueSuffix: data['tooltip'] },
    plotOptions: {
        columnrange: {
            dataLabels: {
                enabled: true,
                formatter: function () {
                    return this.y + data['tooltip'];
                }
            }
        }
    },
    legend: { enabled: false },
    series: [{ name: data['section'], data: data['values'] }]
  });
}