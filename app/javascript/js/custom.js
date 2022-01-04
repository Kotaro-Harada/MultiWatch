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

// === FOLLOW === //
$(".follow_form").on("submit", function(e){
  e.preventDefault();
  let image_url = $(this).children("input:nth-child(2)").val();
  let name = $(this).children("input:nth-child(3)").val();
  let display_name = $(this).children("input:nth-child(4)").val();
  let user_id = $(this).children("input:nth-child(5)").val();
  let platform = $(this).children("input:nth-child(6)").val();
  let channel_id = $(this).children("input:nth-child(7)").val();
  let url = $(this).attr("action");
  $.ajax({
    url: url,
    type: "POST",
    data: {
      follow: {
        name: name,
        display_name: display_name,
        user_id: user_id,
        platform: platform,
        channel_id: channel_id
      },
      image_url: image_url
    },
  })
  .fail(function(){
    $("#follow_button i").text(" エラー");
    $("#follow_button i").removeClass("fas fa-heart");
    $("#follow_button i").addClass("fas fa-exclamation-circle");
  });
});

$(".unfollow_form").on("submit", function(e){
  e.preventDefault();
  let channel_id = $(this).children("input:nth-child(3)").val();
  let user_id = $(this).children("input:nth-child(4)").val();
  let platform = $(this).children("input:nth-child(5)").val();
  let url = $(this).attr("action");
  $.ajax({
    url: url,
    type: "DELETE",
    data: {
      follow: {
        channel_id: channel_id,
        user_id: user_id,
        platform: platform,
      },
    },
  })
  .fail(function(){
    $("#unfollow_button i").text(" エラー");
    $("#unfollow_button i").removeClass("fas fa-heart-broken");
    $("#unfollow_button i").addClass("fas fa-exclamation-circle");
  });
});

