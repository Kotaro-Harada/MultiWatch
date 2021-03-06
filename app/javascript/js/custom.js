// === HOME === //
$(".youtube1").on("input", function(){
  let input = $(".youtube1").val();
  if (input){
    $(".youtube2").addClass("display");
  }else{
    $(".youtube2").removeClass("display");
  }
});

$(".youtube2").on("input", function(){
  let input = $(".youtube2").val();
  if (input){
    $(".youtube3").addClass("display");
  }else{
    $(".youtube3").removeClass("display");
  }
});

$(".youtube3").on("input", function(){
  let input = $(".youtube3").val();
  if (input){
    $(".youtube4").addClass("display");
  }else{
    $(".youtube4").removeClass("display");
  }
});

$(".twitch1").on("input", function(){
  let input = $(".twitch1").val();
  if (input){
    $(".twitch2").addClass("display");
  }else{
    $(".twitch2").removeClass("display");
  }
});

$(".twitch2").on("input", function(){
  let input = $(".twitch2").val();
  if (input){
    $(".twitch3").addClass("display");
  }else{
    $(".twitch3").removeClass("display");
  }
});

$(".twitch3").on("input", function(){
  let input = $(".twitch3").val();
  if (input){
    $(".twitch4").addClass("display");
  }else{
    $(".twitch4").removeClass("display");
  }
});

$(".niconico1").on("input", function(){
  let input = $(".niconico1").val();
  if (input){
    $(".niconico2").addClass("display");
  }else{
    $(".niconico2").removeClass("display");
  }
});

$(".niconico2").on("input", function(){
  let input = $(".niconico2").val();
  if (input){
    $(".niconico3").addClass("display");
  }else{
    $(".niconico3").removeClass("display");
  }
});

$(".niconico3").on("input", function(){
  let input = $(".niconico3").val();
  if (input){
    $(".niconico4").addClass("display");
  }else{
    $(".niconico4").removeClass("display");
  }
});

// === HEADER === //
$(".user_icon").on("click", function(){
  $(".user_menu").toggleClass("show");
  $(".short_header_menu").toggleClass("header_slide");
});

$(".side_nav").on("click", function(){
  $(".sidebar").toggleClass("slide");
});

$(".whisper").on("click", function(){
  $(".whisper_box").toggleClass("show");
  $(".short_header_menu").toggleClass("header_slide");
});

$(".edit_layout").on("click", function(){
  $(".layout").toggleClass("show");
  $(".short_header_menu").toggleClass("header_slide");
});

$(".edit_video").on("click", function(){
  $(".video").toggleClass("show");
  $(".short_header_menu").toggleClass("header_slide");
});

$(".delete_video_icon").on("click", function(){
  $(".delete_video").toggleClass("show");
  $(".short_header_menu").toggleClass("header_slide");
});

$(".side_user_nav").on("click", function(){
  $(".short_header_menu").toggleClass("header_slide");
});

$(function(){
	if(window.matchMedia('(min-width: 440px)').matches){
    $("#platform").children("option").eq(0).addClass("fab fa-youtube");
  }
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

$(document).on("click", function(event){
  if (!$(event.target).closest(".video").length
    && !$(event.target).hasClass("fa-plus-square")){
      $(".video").removeClass("show");
  }
});

$(document).on("click", function(event){
  if (!$(event.target).closest(".layout").length
    && !$(event.target).hasClass("fa-th-large")){
      $(".layout").removeClass("show");
  }
});

$(document).on("click", function(event){
  if (!$(event.target).closest(".side_user_nav").length){
    $(".short_header_menu").removeClass("header_slide");
  }
});

$(document).on("click", function(){
  if ($(".user_menu").hasClass("show")
    || $(".sidebar").hasClass("slide")
    || $(".whisper_box").hasClass("show")
    || $(".video").hasClass("show")
    || $(".layout").hasClass("show")
    || $(".short_header_menu").hasClass("header_slide")){
      $(".wrap").addClass("hide");
  }else{
    $(".wrap").removeClass("hide");
  }
});

// === SIDEBAR === //
$(".select_unfollow").on("click", function(){
  $(".select_unfollow").addClass("underline");
  $(".select_follow").removeClass("underline");
  $(".side_each_unfollow").removeClass("not_show");
  $(".follows").addClass("not_show");
  $(".sidebar_icon").removeClass("fa-heart");
  $(".sidebar_icon").addClass("fa-heart-broken");
});

$(".select_follow").on("click", function(){
  $(".select_follow").addClass("underline");
  $(".select_unfollow").removeClass("underline");
  $(".side_each_unfollow").addClass("not_show");
  $(".follows").removeClass("not_show");
  $(".sidebar_icon").addClass("fa-heart");
  $(".sidebar_icon").removeClass("fa-heart-broken");
});

// === FRIEND === //
$(".whisper_button").on("click", function(){
  const user_name = $(this).val();
  $(".whisper_box").addClass("show");
  $(".receive_user_name").val(user_name);
});
