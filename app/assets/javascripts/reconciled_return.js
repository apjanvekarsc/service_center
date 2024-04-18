$(document).ready(function(){
  
  $("#reconciled_return_settlement_date").datepicker(
  {
    dateFormat: 'yy-mm-dd',
    changeMonth: true,
    changeYear: true,
    yearRange: "-70:+70"
  });
  
  $('#reconciled_return_settlement_date').datepicker("setDate", $('#reconciled_return_settlement_date').val());
  
  $("#reconciled_return_settlement_date").prop("readOnly",true);

  $("#reconciled_return_reset").on('click', function(){
    $('input#bank_ref_no').val('');
  });
  
});