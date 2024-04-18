$(document).ready(function(){

  if ($("#iam_organisation_on_vpn").attr('checked')) {
    toggle_required_fields('Y');
  }
  else {
    toggle_required_fields('N'); 
  }

  $("#iam_organisation_on_vpn").on("change",function(){
    if ($(this).attr('checked')) {
      toggle_required_fields('Y');
    } 
    else {
      toggle_required_fields('N'); 
    }
  });

  function toggle_required_fields(is_vpn_on){
    var mandatory_mark = "*";
    if (is_vpn_on == 'Y') {
      $("#iam_organisation_cert_dn").prop('required',false);
      $("#iam_organisation_cert_dn").val('');
      $("#iam_organisation_cert_dn").prop('readOnly',true);
      $("#cert_dn_lbl").text($("#cert_dn_lbl").text().replace(mandatory_mark,''));

      $("#iam_organisation_source_ips").prop('required',false);
      $("#source_ips_lbl").text($("#source_ips_lbl").text().replace(mandatory_mark,''));
    }
    else {
      $("#iam_organisation_cert_dn").prop('required',true);
      $("#iam_organisation_cert_dn").prop('readOnly',false);
      $("#cert_dn_lbl").text(mandatory_mark + $("#cert_dn_lbl").text().replace(/\*/g, ''));

      $("#iam_organisation_source_ips").prop('required',true);
      $("#source_ips_lbl").text(mandatory_mark + $("#source_ips_lbl").text().replace(/\*/g, ''));
    }
  }

});
