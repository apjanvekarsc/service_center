$(document).ready(function(){
  
  $("#adv_search_reset_button").on('click', function(){
    $(".form-horizontal").find("input[type=text],input[type=number], input[type=datetime], input[type=date], select").val("");
    return false; 
  });
  
  $('.dropdown').hover(function(){
    $(this).find('.dropdown-menu').slideDown(100);
  }, function(){
    $(this).find('.dropdown-menu').slideUp(100);
  });

  window.setInterval(function(){
    $('.alert').fadeOut();
    $('.notice').fadeOut();
  }, 5000);

  $('h2.collapsible').click(function(){
    $(this).siblings('.collapsible-content').toggle();
  });

  $("a.request-link").on("click", function () {
    var request = $(this).data('request');
    display_beautified_data(request, "div.request", "#requestText");
  });

  $("a.reply-link").on("click", function () {
    var reply = $(this).data('reply');
    display_beautified_data(reply, "div.reply", "#replyText");
  });

  $("a.fault-link").on("click", function () {
    $('#faultText').modal();
  });

  $("a.result-link").on("click", function () {
    $('#resultText').modal();
  });
  
  $("#aml_reset").on('click', function(){
    $('input#search_params_firstName').val('');
    $('input#search_params_idNumber').val('');
  });

  $("#ecol_remitter_reset").on('click', function(){
    $('input#customer_code').val('');
    $('input#customer_subcode').val('');
    $('input#remitter_code').val('');
  });

  $("#ecol_customer_reset").on('click', function(){
    $('input#code').val('');
    $('select#is_enabled').val('');
    $('input#credit_acct_val_pass').val('');
    $('input#credit_acct_val_fail').val('');
  });

  $("#ecol_transaction_reset").on('click', function(){
    $('input#transfer_unique_no').val('');
    $('input#customer_code').val('');
    $('select#status').val('');
    $('select#notification_status').val('');
    $('select#validation_status').val('');
    $('select#settle_status').val('');
    $('select#transfer_type').val('');
    $('input#bene_account_no').val('');
    $('input#from_transfer_timestamp').val('');
    $('input#to_transfer_timestamp').val('');
    $('input#from_amount').val('');
    $('input#to_amount').val('');
  });
	
  $("#bm_app_reset").on('click', function(){
    $(".form-horizontal").find("input[type=text], select").val("");
  });
	
  $("#bm_biller_reset").on('click', function(){
    $(".form-horizontal").find("input[type=text], select").val("");
  });
	
  $("#bm_bill_payment_reset").on('click', function(){
    $(".form-horizontal").find("input[type=text], select").val("");
  });
	
  $("#bm_aggr_reset").on('click', function(){
    $(".form-horizontal").find("input[type=text], select").val("");
  });
	
  $("#imt_customer_reset").on('click', function(){
    $(".form-horizontal").find("input[type=text], select").val("");
  });
	
  $("#imt_transfer_reset").on('click', function(){
    $(".form-horizontal").find("input[type=text], select").val("");
  });

  $("#adv_search_reset_button").on('click', function(){
    $(".form-horizontal").find("input[type=text], select").val("");
  });

  $(".reset-btn").on('click', function(){
    $(".form-horizontal").find("input[type=text], select, input[type=number]").val("");
  });

  $(".val-request-link").on("click", function () {
    var request = $(this).data('request');
    display_beautified_data(request, "div.request", "#requestText");
  });

  $(".val-reply-link").on("click", function () {
    var reply = $(this).data('reply');
    display_beautified_data(reply, "div.reply", "#replyText");
  });

  $(".val-req-header-link").on("click", function () {
    var request = $(this).data('request');
    display_beautified_data(request, "div.request_header", "#requestHeader");
  });

  $(".val-rep-header-link").on("click", function () {
    var reply = $(this).data('reply');
    display_beautified_data(reply, "div.reply_header", "#replyHeader");
  });

  $(".val-fault-link").on("click", function () {
    var fault = $(this).data('fault');
    display_beautified_data(fault, "div.fault", "#faultLink");
  });
  
  $(".data-link").on("click", function () {
    var data = $(this).data('temp');
    display_beautified_data(data, "div.temp_data", "#templateData");
  });

  $("a.active-link").on("click", function () {
    var f_code = $(this).data('fault-code');
    var f_reason = $(this).data('fault-reason');
    var f_subcode = $(this).data('fault-subcode'); 
    var f_bitstream = $(this).data('fault-bitstream');  
    $(".modal-body .fault_code").text("");
    $(".modal-body .fault_code").text(f_code);
    $(".modal-body .fault_reason").text("");
    $(".modal-body .fault_reason").text(f_reason);
    $(".modal-body .fault_subcode").text("");
    $(".modal-body .fault_subcode").text(f_subcode);
    $(".modal-body .fault_bitstream").text("");
    $(".modal-body .fault_bitstream").text(f_bitstream);
    $('#faultText').modal();
  });

  $("a.val-url-link").on("click", function () {
    var host = $(this).data('host');
    var uri = $(this).data('uri'); 
    $(".modal-body .remote_host").text("");
    $(".modal-body .remote_host").text(host);
    $(".modal-body .req_uri").text("");
    $(".modal-body .req_uri").text(uri);
    $('#urlText').modal();
  });

  $("#submit_rc_transfer").click(function(){
    $("#update_transactions").submit(function(){
      $("#submit_rc_transfer").prop('disabled', true);
    });
  });

  $("#submit_override").click(function(){
    $("#update_records").submit(function(){
      $("#submit_override").prop('disabled', true);
    });
  });

  $("#submit_skip").click(function(e){
    var file_id = $('#file_id').val();    
    $('#update_records').attr("action", "/incoming_files/"+file_id+"/skip_records");
    $("#update_records").submit(function(){
      $("#submit_skip").prop('disabled', true);
    });
  });

  $("#submit_restart").click(function(){
    var file_id = $('#file_id').val();    
    $('#update_records').attr("action", "/incoming_files/"+file_id+"/approve_restart");
    $("#update_records").submit(function(){
      $("#submit_restart").prop('disabled', true);
    });
  });

  $("#submit_reset").click(function(){
    var file_id = $('#file_id').val();    
    $('#update_records').attr("action", "/incoming_files/"+file_id+"/reset");
    $("#update_records").submit(function(){
      $("#submit_reset").prop('disabled', true);
    });
  });

  $("#submit_reject").click(function(){
    $("#reject_records").submit(function(){
      $("#submit_reject").prop('disabled', true);
    });
  });

  $("#submit_process_file").click(function(){
    $("#process_file").submit(function(){
      $("#submit_process_file").prop('disabled', true);
    });
  });

  $("#submit_generate").click(function(){
    $("#generate_records").submit(function(){
      $("#submit_generate").prop('disabled', true);
    });
  });
  
  $("input.between_input[type=datetime]").datetimepicker({
    dateFormat: "dd/mm/yy",
    timeFormat: 'hh:mmTT' 
  });
  
  $("input.between_input[type=date]").datepicker({
    dateFormat: "dd/mm/yy"
  });
  
  // $("#obdx_from_date, #obdx_to_date").datepicker({
  //   dateFormat: 'yy-mm-dd',
  //   changeMonth: true,
  //   changeYear: true,
  //   yearRange: "-10:+70",
  //   minDate: 0,
  //   maxDate: '+1M'
  // });

  $("#from_date, #to_date, #search_params_idIssueDate, #search_params_idExpiryDate, #invoice_from_due_date, #invoice_to_due_date, #repayment_from_date, #repayment_to_date").datepicker({
    dateFormat: 'yy-mm-dd',
    changeMonth: true,
    changeYear: true,
    yearRange: "-10:+70",
  });

  $("#qg_ecol_todays_imps_txn_transfer_date").datepicker(
  {
    dateFormat: 'yy-mm-dd',
    changeMonth: true,
    changeYear: true,
    yearRange: "-70:+70"
  });
  
  $('#qg_ecol_todays_imps_txn_transfer_date').datepicker("setDate", $('#qg_ecol_todays_imps_txn_transfer_date').val());

  $('#rc_transfer_schedule_next_run_at').datetimepicker({
    dateFormat: "dd/mm/yy",
    timeFormat: 'hh:mmTT',
    minDate: 0
  });

  $('#next_from_date').datetimepicker({
    dateFormat: "dd/mm/yy",
    timeFormat: 'hh:mmTT' 
  });

  $('#next_to_date').datetimepicker({
    dateFormat: "dd/mm/yy",
    timeFormat: 'hh:mmTT' 
  });

  $('#last_from_date').datetimepicker({
    dateFormat: "dd/mm/yy",
    timeFormat: 'hh:mmTT' 
  });

  $('#last_to_date').datetimepicker({
    dateFormat: "dd/mm/yy",
    timeFormat: 'hh:mmTT' 
  });

  $('#ft_purge_saf_transfer_from_req_timestamp, #ft_purge_saf_transfer_to_req_timestamp').datetimepicker({
    dateFormat: "dd/mm/yy",
    timeFormat: 'hh:mmTT',
  });

  $('#from_request_timestamp, #to_request_timestamp, #from_reply_timestamp, #to_reply_timestamp').datetimepicker({
    dateFormat: "dd/mm/yy",
    timeFormat: 'hh:mmTT',
  });

  $('#from_issue_date, #to_issue_date, #from_acquire_date, #to_acquire_date').datetimepicker({
    dateFormat: "dd/mm/yy",
    timeFormat: 'hh:mmTT',
  });
});


function beautify_xml(xml_string) {
  var beautified_xml_req, result;
  try {
    beautified_xml_req = vkbeautify.xml(xml_string);
  }
  catch (e) {
    beautified_xml_req = 'xml_parse_err';
  }
  return beautified_xml_req;
}

function beautify_json(json_string) {
  var beautified_json_req, result;
  try {
    beautified_json_req = vkbeautify.json(json_string);
  }
  catch (e) {
    beautified_json_req = 'json_parse_err';
  }
  return beautified_json_req;
}

function display_beautified_data(string, html_ele, modal){
  var xml_result = beautify_xml(string);
  $(html_ele).text("");
  if (xml_result != 'xml_parse_err') {
    $(html_ele).text(xml_result);  
  }
  else {
    var json_result = beautify_json(string);
    if (json_result != 'json_parse_err') {
      $(html_ele).text(json_result);  
    }
  }
  $(modal).modal();
}