$(document).ready(function() {

  $("#pass").keyup(function() {
    pass = $(this).val();
    if(pass=="")
      $("#generate").val(false);
    else
      $("#generate").val(true);
  }); 

  $("#enc_pass_reset_btn").on('click', function(){
    $("#generate_enc_pass_form").find("input[type=text]").val("");
    $("#generate").val(false);
  });

});