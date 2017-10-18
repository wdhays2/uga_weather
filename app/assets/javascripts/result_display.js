$(document).ready(function(){

  $(".click_row").click(function(){
  });

  $("#datepicker").datepicker({
    changeMonth: true,
    changeYear: true,
    minDate: new Date(2002, 09, 07),
    maxDate: -1,
    dateFormat: 'yymmdd',
    onSelect: function(){
      // window.location = '/results',
      console.log('Hey')
    }
  });

});
