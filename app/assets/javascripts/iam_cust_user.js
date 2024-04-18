$(document).ready(function(){

  $("#test_login_btn").on("click", function () {
    empty_modal();
  });
  
  $(".resend-link").on("click", function () {
    $('#resendPassword').modal().show();
  });

  $("#resend").on("click", function () {
    empty_modal();
    $('#resendPassword').hide();
  });
  
  $(".add-link").on("click", function () {
    $('#addUser').modal().show();
  });

  $("#add").on("click", function () {
    empty_modal();
    $('#addUser').hide();
  });
  
  $(".delete-link").on("click", function () {
    $('#deleteUser').modal().show();
  });

  $("#delete").on("click", function () {
    empty_modal();
    $('#deleteUser').hide();
  });
  
  function empty_modal(){
    $("#modal-window").find(".modal-body").text("");
  }

});
