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
    && !$(event.target).hasClass("fa-comment-alt")){
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

// === SETTING === //
$(".profile_tab").on("click", function(){
  $(this).addClass("underline");
  $(".security_tab").removeClass("underline");
  $(".profile_setting").addClass("select");
  $(".profile_setting").removeClass("delete");
  $(".security_setting").addClass("delete");
  $(".security_setting").removeClass("select");
});

$(".security_tab").on("click", function(){
  $(this).addClass("underline");
  $(".profile_tab").removeClass("underline");
  $(".security_setting").addClass("select");
  $(".security_setting").removeClass("delete");
  $(".profile_setting").addClass("delete");
  $(".profile_setting").removeClass("select");
});
