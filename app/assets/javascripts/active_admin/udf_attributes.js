$(document).ready(function(){
    
    $("#udf_attribute_control_type").on("change",function(){
        var controlType = $(this).val();
        if(controlType == "TextBox"){
          $('#udf_attribute_data_type').val('');
          $('#udf_attribute_length').val('');
          $('#udf_attribute_min_length').val('');
          $('#udf_attribute_max_length').val('');
          $('#udf_attribute_min_value').val('');
          $('#udf_attribute_max_value').val('');
          $('#udf_attribute_select_options').val('');
          $('#udf_attribute_data_type').prop('disabled',false);
          $('#udf_attribute_length').prop('readOnly',true);
          $('#udf_attribute_min_length').prop('readOnly',true);
          $('#udf_attribute_max_length').prop('readOnly',true);
          $('#udf_attribute_min_value').prop('readOnly',true);
          $('#udf_attribute_max_value').prop('readOnly',true);
          $('#udf_attribute_select_option').prop('readOnly',true);
        }
        else if(controlType == "DropDown"){
          $('#udf_attribute_data_type').val('');
          $('#udf_attribute_length').val('');
          $('#udf_attribute_min_length').val('');
          $('#udf_attribute_max_length').val('');
          $('#udf_attribute_min_value').val('');
          $('#udf_attribute_max_value').val('');
          $('#udf_attribute_data_type').prop('disabled',true);
          $('#udf_attribute_length').prop('readOnly',true);
          $('#udf_attribute_min_length').prop('readOnly',true);
          $('#udf_attribute_max_length').prop('readOnly',true);
          $('#udf_attribute_min_value').prop('readOnly',true);
          $('#udf_attribute_max_value').prop('readOnly',true);
          $('#udf_attribute_select_options').prop('readOnly',false);
        }
        else{
          $('#udf_attribute_data_type').val('');
          $('#udf_attribute_length').val('');
          $('#udf_attribute_min_length').val('');
          $('#udf_attribute_max_length').val('');
          $('#udf_attribute_min_value').val('');
          $('#udf_attribute_max_value').val('');
          $('#udf_attribute_select_options').val('');
          $('#udf_attribute_data_type').prop('disabled',true);
          $('#udf_attribute_length').prop('readOnly',true);
          $('#udf_attribute_min_length').prop('readOnly',true);
          $('#udf_attribute_max_length').prop('readOnly',true);
          $('#udf_attribute_min_value').prop('readOnly',true);
          $('#udf_attribute_max_value').prop('readOnly',true);
          $('#udf_attribute_select_options').prop('readOnly',true);
        }
    });


    $('#udf_attribute_data_type').on("change",function(){
        var dataType = $(this).val();
        if(dataType == "String"){
          $('#udf_attribute_length').prop('readOnly',false);
          $('#udf_attribute_min_length').prop('readOnly',false);
          $('#udf_attribute_max_length').prop('readOnly',false);
          $('#udf_attribute_min_value').val('');
          $('#udf_attribute_max_value').val('');
          $('#udf_attribute_select_options').val('');
          $('#udf_attribute_min_value').prop('readOnly',true);
          $('#udf_attribute_max_value').prop('readOnly',true);
          $('#udf_attribute_select_options').prop('readOnly',true);
        }
        else if(dataType == "Numeric"){
          $('#udf_attribute_length').prop('readOnly',true);
          $('#udf_attribute_min_length').prop('readOnly',true);
          $('#udf_attribute_max_length').prop('readOnly',true);
          $('#udf_attribute_length').val('');
          $('#udf_attribute_min_length').val('');
          $('#udf_attribute_max_length').val('');
          $('#udf_attribute_select_options').val('');
          $('#udf_attribute_min_value').prop('readOnly',false);
          $('#udf_attribute_max_value').prop('readOnly',false);
          $('#udf_attribute_select_options').prop('readOnly',true);
        }
        else{
          $('#udf_attribute_length').prop('readOnly',true);
          $('#udf_attribute_min_length').prop('readOnly',true);
          $('#udf_attribute_max_length').prop('readOnly',true);
          $('#udf_attribute_min_value').prop('readOnly',true);
          $('#udf_attribute_max_value').prop('readOnly',true);
          $('#udf_attribute_select_options').prop('readOnly',true);
          $('#udf_attribute_length').val('');
          $('#udf_attribute_min_length').val('');
          $('#udf_attribute_max_length').val('');
          $('#udf_attribute_min_value').val('');
          $('#udf_attribute_max_value').val('');
          $('#udf_attribute_select_options').val('');
        };
    });


    if($('#udf_attribute_control_type').val() == 'TextBox'){
      $('#udf_attribute_data_type').prop('disabled',false);
      $('#udf_attribute_length').prop('readOnly',true);
      $('#udf_attribute_min_length').prop('readOnly',true);
      $('#udf_attribute_max_length').prop('readOnly',true);
      $('#udf_attribute_min_value').prop('readOnly',true);
      $('#udf_attribute_max_value').prop('readOnly',true);
      $('#udf_attribute_select_options').prop('readOnly',true);
    }
    else if($('#udf_attribute_control_type').val() == "DropDown"){
      $('#udf_attribute_data_type').prop('disabled',true);
      $('#udf_attribute_length').prop('readOnly',true);
      $('#udf_attribute_min_length').prop('readOnly',true);
      $('#udf_attribute_max_length').prop('readOnly',true);
      $('#udf_attribute_min_value').prop('readOnly',true);
      $('#udf_attribute_max_value').prop('readOnly',true);
      $('#udf_attribute_select_options').prop('readOnly',false);
    }
    else{
      $('#udf_attribute_data_type').prop('disabled',true);
      $('#udf_attribute_length').prop('readOnly',true);
      $('#udf_attribute_min_length').prop('readOnly',true);
      $('#udf_attribute_max_length').prop('readOnly',true);
      $('#udf_attribute_min_value').prop('readOnly',true);
      $('#udf_attribute_max_value').prop('readOnly',true);
      $('#udf_attribute_select_options').prop('readOnly',true);
    };

    if($('#udf_attribute_data_type').val() == "String"){
      $('#udf_attribute_length').prop('readOnly',false);
      $('#udf_attribute_min_length').prop('readOnly',false);
      $('#udf_attribute_max_length').prop('readOnly',false);
      $('#udf_attribute_min_value').prop('readOnly',true);
      $('#udf_attribute_max_value').prop('readOnly',true);
    }
    else if($('#udf_attribute_data_type').val() == "Numeric"){
      $('#udf_attribute_length').prop('readOnly',true);
      $('#udf_attribute_min_length').prop('readOnly',true);
      $('#udf_attribute_max_length').prop('readOnly',true);
      $('#udf_attribute_min_value').prop('readOnly',false);
      $('#udf_attribute_max_value').prop('readOnly',false);
    }
    else{
      $('#udf_attribute_length').prop('readOnly',true);
      $('#udf_attribute_min_length').prop('readOnly',true);
      $('#udf_attribute_max_length').prop('readOnly',true);
      $('#udf_attribute_min_value').prop('readOnly',true);
      $('#udf_attribute_max_value').prop('readOnly',true);
    };

  $('#udf_attribute_form').on('submit', function(){
    $(this).find(':input').removeAttr('disabled');
  });
  
  $("#udf_attribute_length").on("change",function(){
    if ($("#udf_attribute_length").val() != ''){
      $('#udf_attribute_min_length').val('');
      $('#udf_attribute_min_length').prop('readOnly',true);
      $('#udf_attribute_max_length').val('');
      $('#udf_attribute_max_length').prop('readOnly',true);
    }
    else{
      $('#udf_attribute_min_length').prop('readOnly',false);
      $('#udf_attribute_max_length').prop('readOnly',false);
    }
  });
  
  if ($("#udf_attribute_length").val() != ''){
    $('#udf_attribute_min_length').val('');
    $('#udf_attribute_min_length').prop('readOnly',true);
    $('#udf_attribute_max_length').val('');
    $('#udf_attribute_max_length').prop('readOnly',true);
  }
  
  $("#udf_attribute_min_length").on("change",function(){
    if ($("#udf_attribute_min_length").val() != '' || $("#udf_attribute_max_length").val() != ''){
      $("#udf_attribute_length").val('');
      $("#udf_attribute_length").prop('readOnly',true);
    }
    else{
      $("#udf_attribute_length").prop('readOnly',false);
    }
  });
  
  if ($("#udf_attribute_min_length").val() != '' || $("#udf_attribute_max_length").val() != ''){
    $("#udf_attribute_length").val('');
    $("#udf_attribute_length").prop('readOnly',true);
  }
  
  $("#udf_attribute_max_length").on("change",function(){
    if ($("#udf_attribute_min_length").val() != '' || $("#udf_attribute_max_length").val() != ''){
      $("#udf_attribute_length").val('');
      $("#udf_attribute_length").prop('readOnly',true);
    }
    else{
      $("#udf_attribute_length").prop('readOnly',false);
    }
  });
  
  
});