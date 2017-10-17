$(document).ready(function(){
  $(".click_row").click(function(){
  });
});

$(document).ready(function(){
  $("#datepicker").datepicker({
    changeMonth: true,
    changeYear: true,
    minDate: new Date(2002, 09, 07),
    maxDate: -1,
    dateFormat: 'yymmdd'
  });
});

// document.getElementById("myDate").addEventListener("select", loadDate);

// function loadDate() {
//     document.getElementById("datepicker");
// };