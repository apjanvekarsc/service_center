//= require active_admin/base
//= require chosen-jquery
//= require_tree ./active_admin
//= require activeadmin-sortable
//= require encrypted_field

$(document).ready(function(){
  $(".ui-datepicker-inline").width("75em");

  $('#session_new').submit(function(){
    $("#admin_user_username").val($('#username-show').val());
    $("#admin_user_password").val($('#password-show').val());
  });
    
  $("#username-show,#password-show").keypress(function(e) {
    if (e.which == 13) {
      $("#session_new").submit();
    }
  });
});