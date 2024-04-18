$(document).ready(function(){
  $(".show_record_text").on("click", function () {
    var record_txt = $(this).attr('data-record-txt');
    display_beautified_data(record_txt, "#record_txt", "#recordText");
  });

  $(".show_response_text").on("click", function () {
    var rep_text = $(this).attr('data-rep-text');
    display_beautified_data(rep_text, "#rep_text", "#responseText");
  });

  $(".show_fault_text").on("click", function () {
    var fault_reason = $(this).attr('data-fault-reason');
    var fault_code = $(this).attr('data-fault-code');
    $(".modal-body .fault_code").text("");
    $(".modal-body .fault_code").text(fault_code);
    $(".modal-body .fault_reason").text("");
    $(".modal-body .fault_reason").text(fault_reason);
    $('#faultText').modal();
  });

  $(".show_fault_bitstream").on("click", function () {
    var fault_bitstream = $(this).attr('data-fault-bitstream');
    display_beautified_data(fault_bitstream, "#fault_bitstream", "#faultBitstream");
  });

  $(".show_status").on("click", function () {
    var status_subcode = $(this).attr('data-status-subcode');
    var status_code = $(this).attr('data-status-code');
    $(".modal-body .status_code").text("");
    $(".modal-body .status_code").text(status_code);
    $(".modal-body .status_subcode").text("");
    $(".modal-body .status_subcode").text(status_subcode);
    $('#status').modal();
  });
});