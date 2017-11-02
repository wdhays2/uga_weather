$(document).ready(function(){

  $(".click_row").click(function(){
  });

  $("#datepicker").datepicker({
    changeMonth: true,
    changeYear: true,
    minDate: new Date(2002, 09, 07),
    maxDate: -1,
    dateFormat: 'yymmdd',
    onSelect: function(dateText, inst) {
      loadNewPage()
    }
  });

});

function setCategoryAndDateToUse(category, date) {
  $("#category").val(category)
  $("#datepicker").val(date)
  loadNewPage()
}

function setCategoryToUse(category) {
  $("#category").val(category)
  loadNewPage()
}

function loadNewPage() {
  var category = $("#category").val()
  var date = $("#datepicker").val()
  window.location = "/weather_results?category=" + category + "&date=" + date
}
