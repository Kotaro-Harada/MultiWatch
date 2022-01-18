// === HEADER === //
$(".user_icon").on("click", function(){
  $(".user_menu").toggleClass("show");
});

$(".side_nav").on("click", function(){
  $(".sidebar").toggleClass("slide");
});

$(".whisper").on("click", function(){
  $(".whisper_box").toggleClass("show");
});

$(document).on("click", function(event){
  if (!$(event.target).closest(".whisper_box").length
    && !$(event.target).hasClass("fa-comment-alt")
    && !$(event.target).hasClass("whisper_button")){
      $(".whisper_box").removeClass("show");
  }
});

$(document).on("click", function(event){
  if (!$(event.target).closest(".user_menu").length
    && !$(event.target).hasClass("icon_image")){
      $(".user_menu").removeClass("show");
  }
});

$(document).on("click", function(event){
  if (!$(event.target).closest(".sidebar").length
    && !$(event.target).hasClass("side_nav")
    && !$(event.target).hasClass("menu")){
      $(".sidebar").removeClass("slide");
  }
});

$(document).on("click", function(){
  if ($(".user_menu").hasClass("show")
    || $(".sidebar").hasClass("slide")
    || $(".whisper_box").hasClass("show")){
      $(".wrap").addClass("hide");
  }else{
    $(".wrap").removeClass("hide");
  }
});

// === FRIEND === //
$(".whisper_button").on("click", function(){
  const user_name = $(this).val();
  $(".whisper_box").addClass("show");
  $(".receive_user_name").val(user_name);
});
