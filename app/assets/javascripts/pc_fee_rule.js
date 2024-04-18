$(document).ready(function() {
  $("#pc_fee_rule_no_of_tiers").on("change",function(){
    var no_of_tiers =  $(this).val();
    if (no_of_tiers == 1){
      for (var i=2; i<=3; i++) {
        $('#pc_fee_rule_tier' + i + '_to_amt').val('');
        $('#pc_fee_rule_tier' + i + '_to_amt').prop('disabled',true);
        $('#pc_fee_rule_tier' + i + '_method').val('');
        $('#pc_fee_rule_tier' + i + '_method').prop('disabled',true);
        $('#pc_fee_rule_tier' + i + '_fixed_amt').val('');
        $('#pc_fee_rule_tier' + i + '_fixed_amt').prop('disabled',true);
        $('#pc_fee_rule_tier' + i + '_pct_value').val('');
        $('#pc_fee_rule_tier' + i + '_pct_value').prop('disabled',true);
        $('#pc_fee_rule_tier' + i + '_min_sc_amt').val('');
        $('#pc_fee_rule_tier' + i + '_min_sc_amt').prop('disabled',true);
        $('#pc_fee_rule_tier' + i + '_max_sc_amt').val('');
        $('#pc_fee_rule_tier' + i + '_max_sc_amt').prop('disabled',true);
      }
		}
		else if (no_of_tiers == 2){
      $('#pc_fee_rule_tier2_to_amt').prop('disabled',false);
      $('#pc_fee_rule_tier2_method').prop('disabled',false);
      $('#pc_fee_rule_tier2_fixed_amt').prop('disabled',false);
      $('#pc_fee_rule_tier2_pct_value').prop('disabled',false);
      $('#pc_fee_rule_tier2_min_sc_amt').prop('disabled',false);
      $('#pc_fee_rule_tier2_max_sc_amt').prop('disabled',false);
			
      $('#pc_fee_rule_tier3_to_amt').val('');
      $('#pc_fee_rule_tier3_to_amt').prop('disabled',true);
      $('#pc_fee_rule_tier3_method').val('');
      $('#pc_fee_rule_tier3_method').prop('disabled',true);
      $('#pc_fee_rule_tier3_fixed_amt').val('');
      $('#pc_fee_rule_tier3_fixed_amt').prop('disabled',true);
      $('#pc_fee_rule_tier3_pct_value').val('');
      $('#pc_fee_rule_tier3_pct_value').prop('disabled',true);
      $('#pc_fee_rule_tier3_min_sc_amt').val('');
      $('#pc_fee_rule_tier3_min_sc_amt').prop('disabled',true);
      $('#pc_fee_rule_tier3_max_sc_amt').val('');
      $('#pc_fee_rule_tier3_max_sc_amt').prop('disabled',true);
		}
		else {
      for (var i=1; i<=3; i++) {
        $('#pc_fee_rule_tier' + i + '_to_amt').prop('disabled',false);
        $('#pc_fee_rule_tier' + i + '_method').prop('disabled',false);
        $('#pc_fee_rule_tier' + i + '_fixed_amt').prop('disabled',false);
        $('#pc_fee_rule_tier' + i + '_pct_value').prop('disabled',false);
        $('#pc_fee_rule_tier' + i + '_min_sc_amt').prop('disabled',false);
        $('#pc_fee_rule_tier' + i + '_max_sc_amt').prop('disabled',false);
      }
		}
	});
	
  if ($("#pc_fee_rule_no_of_tiers").val() == 1){
    for (var i=2; i<=3; i++) {
      $('#pc_fee_rule_tier' + i + '_to_amt').val('');
      $('#pc_fee_rule_tier' + i + '_to_amt').prop('disabled',true);
      $('#pc_fee_rule_tier' + i + '_method').val('');
      $('#pc_fee_rule_tier' + i + '_method').prop('disabled',true);
      $('#pc_fee_rule_tier' + i + '_fixed_amt').val('');
      $('#pc_fee_rule_tier' + i + '_fixed_amt').prop('disabled',true);
      $('#pc_fee_rule_tier' + i + '_pct_value').val('');
      $('#pc_fee_rule_tier' + i + '_pct_value').prop('disabled',true);
      $('#pc_fee_rule_tier' + i + '_min_sc_amt').val('');
      $('#pc_fee_rule_tier' + i + '_min_sc_amt').prop('disabled',true);
      $('#pc_fee_rule_tier' + i + '_max_sc_amt').val('');
      $('#pc_fee_rule_tier' + i + '_max_sc_amt').prop('disabled',true);
    }
	}
	else if ($("#pc_fee_rule_no_of_tiers").val() == 2){
    $('#pc_fee_rule_tier1_to_amt').prop('disabled',false);
    $('#pc_fee_rule_tier1_method').prop('disabled',false);
    $('#pc_fee_rule_tier1_fixed_amt').prop('disabled',false);
    $('#pc_fee_rule_tier1_pct_value').prop('disabled',false);
    $('#pc_fee_rule_tier1_min_sc_amt').prop('disabled',false);
    $('#pc_fee_rule_tier1_max_sc_amt').prop('disabled',false);
		
    $('#pc_fee_rule_tier3_to_amt').val('');
    $('#pc_fee_rule_tier3_to_amt').prop('disabled',true);
    $('#pc_fee_rule_tier3_method').val('');
    $('#pc_fee_rule_tier3_method').prop('disabled',true);
    $('#pc_fee_rule_tier3_fixed_amt').val('');
    $('#pc_fee_rule_tier3_fixed_amt').prop('disabled',true);
    $('#pc_fee_rule_tier3_pct_value').val('');
    $('#pc_fee_rule_tier3_pct_value').prop('disabled',true);
    $('#pc_fee_rule_tier3_min_sc_amt').val('');
    $('#pc_fee_rule_tier3_min_sc_amt').prop('disabled',true);
    $('#pc_fee_rule_tier3_max_sc_amt').val('');
    $('#pc_fee_rule_tier3_max_sc_amt').prop('disabled',true);
	}
	else {
    for (var i=1; i<=3; i++) {
      $('#pc_fee_rule_tier' + i + '_to_amt').prop('disabled',false);
      $('#pc_fee_rule_tier' + i + '_method').prop('disabled',false);
      $('#pc_fee_rule_tier' + i + '_fixed_amt').prop('disabled',false);
      $('#pc_fee_rule_tier' + i + '_pct_value').prop('disabled',false);
      $('#pc_fee_rule_tier' + i + '_min_sc_amt').prop('disabled',false);
      $('#pc_fee_rule_tier' + i + '_max_sc_amt').prop('disabled',false);
    }
	}

  $("#pc_fee_rule_tier1_method").on("change",function()
    {
      if ($("#pc_fee_rule_tier1_method").val() == 'F')
      {
        $("#pc_fee_rule_tier1_pct_value").val('0');
        $("#pc_fee_rule_tier1_min_sc_amt").val('0');
        $("#pc_fee_rule_tier1_pct_value").prop('readOnly',true);
        $("#pc_fee_rule_tier1_fixed_amt").prop('readOnly',false);
      }
      else if ($("#pc_fee_rule_tier1_method").val() == 'P')
      {
        $('#pc_fee_rule_tier1_fixed_amt').val('0');
        $("#pc_fee_rule_tier1_fixed_amt").prop('readOnly',true);
        $("#pc_fee_rule_tier1_pct_value").prop('readOnly',false);
      }
      else{
        $("#pc_fee_rule_tier1_pct_value").prop('readOnly',false);
        $("#pc_fee_rule_tier1_fixed_amt").prop('readOnly',false);
      }
    });

  $("#pc_fee_rule_tier2_method").on("change",function()
    {
      if ($("#pc_fee_rule_tier2_method").val() == 'F')
      {
        $("#pc_fee_rule_tier2_pct_value").val('0');
        $("#pc_fee_rule_tier2_pct_value").prop('readOnly',true);
        $("#pc_fee_rule_tier2_fixed_amt").prop('readOnly',false);
      }
      else if ($("#pc_fee_rule_tier2_method").val() == 'P')
      {
        $('#pc_fee_rule_tier2_fixed_amt').val('0');
        $("#pc_fee_rule_tier2_fixed_amt").prop('readOnly',true);
        $("#pc_fee_rule_tier2_pct_value").prop('readOnly',false);
      }
      else{
        $("#pc_fee_rule_tier2_pct_value").prop('readOnly',false);
        $("#pc_fee_rule_tier2_fixed_amt").prop('readOnly',false);
      }
    });

  $("#pc_fee_rule_tier3_method").on("change",function()
    {
      if ($("#pc_fee_rule_tier3_method").val() == 'F')
      {
        $("#pc_fee_rule_tier3_pct_value").val('0');
        $("#pc_fee_rule_tier3_pct_value").prop('readOnly',true);
        $("#pc_fee_rule_tier3_fixed_amt").prop('readOnly',false);
      }
      else if ($("#pc_fee_rule_tier3_method").val() == 'P')
      {
        $('#pc_fee_rule_tier3_fixed_amt').val('0');
        $("#pc_fee_rule_tier3_fixed_amt").prop('readOnly',true);
        $("#pc_fee_rule_tier3_pct_value").prop('readOnly',false);
      }
      else{
        $("#pc_fee_rule_tier3_pct_value").prop('readOnly',false);
        $("#pc_fee_rule_tier3_fixed_amt").prop('readOnly',false);
      }
    });
});