// === HEADER === //
$(".user_icon").on("click", function(){
  $(".user_menu").toggleClass("show");
});

$(".side_nav").on("click", function(){
  $(".sidebar").toggleClass("slide");
});

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
