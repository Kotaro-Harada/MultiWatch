<template>
  <div>
    <div class="video_wrapper">
      <div v-for="(youtube, index) in youtubes" :key="`youtube` + index">
        <div class="youtube">
          <iframe class="video_frame" allowfullscreen="1"
            v-bind:src="`https://www.youtube.com/embed/` + youtube" title="YouTube video player"
            frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"></iframe>
          <button class="btn btn-danger delete_video" style="display:none;" @click="delete_youtube(youtube)"><i class="fas fa-trash"></i></button>
          <iframe class="chat_frame" frameborder="0"
            v-bind:src="`https://www.youtube.com/live_chat?v=` + youtube + `&embed_domain=localhost`"></iframe>
        </div>
      </div>
      <div v-for="(twitch, index) in twitches" :key="`twitch` + index">
        <div class="twitch">
          <iframe class="video_frame" frameborder="0" allowfullscreen="true" scrolling="no"
            v-bind:src="`https://player.twitch.tv/?channel=` + twitch + `&parent=localhost`"></iframe>
          <button class="btn btn-danger delete_video" style="display:none;" @click="delete_twitch(twitch)"><i class="fas fa-trash"></i></button>
          <iframe class="chat_frame" id="twitch-chat-embed" v-bind:src="`https://www.twitch.tv/embed/` + twitch + `/chat?parent=localhost`"
            sandbox="allow-storage-access-by-user-activation allow-scripts allow-same-origin allow-popups allow-popups-to-escape-sandbox allow-modals"></iframe>
        </div>
      </div>
      <div v-for="(niconico, index) in niconicos" :key="`niconico` + index">
        <div class="niconico">
          <iframe class="video_frame" allowfullscreen="allowfullscreen" allow="autoplay" v-bind:src="`https://embed.nicovideo.jp/watch/` + niconico + `?oldScript=1&referer=&from=0&allowProgrammaticFullScreen=1`"
            style="border: none;"></iframe>
          <button class="btn btn-danger delete_video" style="display:none;" @click="delete_niconico(niconico)"><i class="fas fa-trash"></i></button>
        </div>
      </div>
      <chat/>
      <select class="chats" v-model="chat1">
        <option value="CHAT 1">CHAT 1</option>
        <option value="CHAT 2">CHAT 2</option>
        <option value="CHAT 3">CHAT 3</option>
        <option value="CHAT 4">CHAT 4</option>
        <option value="CUSTOM">CUSTOM</option>
      </select>
      <select class="chats" v-model="chat2">
        <option value="CHAT 1">CHAT 1</option>
        <option value="CHAT 2">CHAT 2</option>
        <option value="CHAT 3">CHAT 3</option>
        <option value="CHAT 4">CHAT 4</option>
        <option value="CUSTOM">CUSTOM</option>
      </select>
    </div>
  </div>
</template>

<script>
import axios from "axios";
import Chat from "./chat"
const token = document.getElementsByName("csrf-token")[0].getAttribute("content");
axios.defaults.headers.common["X-CSRF-Token"] = token;

export default ({
  components: {
    chat: Chat
  },
  data: function(){
    return{
      youtubes: [],
      twitches: [],
      niconicos: [],
      frames: 0,
      chat1: "CHAT 1",
      chat2: "CHAT 2"
    }
  },
  props: {
    youtube_url: {
      default: "youtube_url"
    },
    twitch_url: {
      default: "twitch_url"
    },
    niconico_url: {
      default: "niconico_url"
    },
    frames: {
      default: "frames"
    }
  },
  mounted(){
    this.youtubes = rails_youtube,
    this.twitches = rails_twitch,
    this.niconicos = rails_niconico,
    this.$nextTick(function(){
      this.frames = $(".video_frame").length
    })
  },
  methods: {
    delete_youtube: function(youtube){
      let delete_index = this.youtubes.indexOf(youtube);
      if(delete_index >= 0){
        this.youtubes.splice(delete_index, 1)
      }
      this.$nextTick(function () {
        this.frames = $(".video_frame").length
        this.$emit("number_of_frames", this.frames)
      })
    },
    delete_twitch: function(twitch){
      let delete_index = this.twitches.indexOf(twitch)
      if(delete_index >= 0){
        this.twitches.splice(delete_index, 1)
      }
      this.$nextTick(function () {
        this.frames = $(".video_frame").length
        this.$emit("number_of_frames", this.frames)
      })
    },
    delete_niconico: function(niconico){
      let delete_index = this.niconicos.indexOf(niconico)
      if(delete_index >= 0){
        this.niconicos.splice(delete_index, 1)
      }
      this.$nextTick(function(){
        this.frames = $(".video_frame").length
        this.$emit("number_of_frames", this.frames)
      })
    }
  },
  watch:{
    youtube_url: function(){
      this.youtubes.push(this.youtube_url)
    },
    twitch_url: function(){
      this.twitches.push(this.twitch_url)
    },
    niconico_url: function(){
      this.niconicos.push(this.niconico_url)
    },
    chat1: function(index){
      $(".chats").eq(1).children().removeAttr("disabled")
      if($(".chats").eq(1).hasClass("not_show")){
        $(".custom_chat").addClass("not_show")
        $(".chat_frame").addClass("not_show")
        if(index == "CHAT 1"){
          $(".chat_frame").eq(0).removeClass("not_show")
        }else if(index == "CHAT 2"){
          $(".chat_frame").eq(1).removeClass("not_show")
        }else if(index == "CHAT 3"){
          $(".chat_frame").eq(2).removeClass("not_show")
        }else if(index == "CHAT 4"){
          $(".chat_frame").eq(3).removeClass("not_show")
        }else if(index == "CUSTOM"){
          $(".custom_chat").css({"top":"0", "right":"0", "width":"20vw", "height":"100vh"})
          $(".custom_chat").removeClass("not_show")
        }
      }else{
        for(let chat_index = 0; chat_index <= 4; chat_index++){
          if(this.chat2 == `CHAT ${chat_index + 1}`){
            $(`.chat_frame:not(:eq(${chat_index}))`).addClass("not_show")
            $(".chats").eq(0).children().eq(chat_index).prop("disabled", true)
            $(".custom_chat").addClass("not_show")
          }else if(this.chat2 == "CUSTOM"){
            $(".chat_frame").addClass("not_show")
          }
        }
        if(index == "CHAT 1"){
          $(".chat_frame").eq(0).css({"top":"0", "right":"20vw", "width":"20vw", "height":"100vh"})
          $(".chat_frame").eq(0).removeClass("not_show")
          $(".chats").eq(1).children().eq(0).prop("disabled", true)
        }else if(index == "CHAT 2"){
          $(".chat_frame").eq(1).css({"top":"0", "right":"20vw", "width":"20vw", "height":"100vh"})
          $(".chat_frame").eq(1).removeClass("not_show")
          $(".chats").eq(1).children().eq(1).prop("disabled", true)
        }else if(index == "CHAT 3"){
          $(".chat_frame").eq(2).css({"top":"0", "right":"20vw", "width":"20vw", "height":"100vh"})
          $(".chat_frame").eq(2).removeClass("not_show")
          $(".chats").eq(1).children().eq(2).prop("disabled", true)
        }else if(index == "CHAT 4"){
          $(".chat_frame").eq(3).css({"top":"0", "right":"20vw", "width":"20vw", "height":"100vh"})
          $(".chat_frame").eq(3).removeClass("not_show")
          $(".chats").eq(1).children().eq(3).prop("disabled", true)
        }else if(index == "CUSTOM"){
          $(".custom_chat").css({"top":"0", "right":"20vw", "width":"20vw", "height":"100vh"})
          $(".custom_chat").removeClass("not_show")
          $(".chats").eq(1).children().eq(4).prop("disabled", true)
        }
      }
    },
    chat2: function(index){
      $(".chats").eq(0).children().removeAttr("disabled")
      for(let chat_index = 0; chat_index <= 4; chat_index++){
        if(this.chat1 == `CHAT ${chat_index + 1}`) {
          $(`.chat_frame:not(:eq(${chat_index}))`).addClass("not_show")
          $(".custom_chat").addClass("not_show")
        }else if(this.chat1 == "CUSTOM"){
          $(".chat_frame").addClass("not_show")
        }
      }
      if(index == "CHAT 1"){
        $(".chat_frame").eq(0).css({"top":"0", "right":"0", "width":"20vw", "height":"100vh"})
        $(".chat_frame").eq(0).removeClass("not_show")
        $(".chats").eq(0).children().eq(0).prop("disabled", true)
      }else if(index == "CHAT 2"){
        $(".chat_frame").eq(1).css({"top":"0", "right":"0", "width":"20vw", "height":"100vh"})
        $(".chat_frame").eq(1).removeClass("not_show")
        $(".chats").eq(0).children().eq(1).prop("disabled", true)
      }else if(index == "CHAT 3"){
        $(".chat_frame").eq(2).css({"top":"0", "right":"0", "width":"20vw", "height":"100vh"})
        $(".chat_frame").eq(2).removeClass("not_show")
        $(".chats").eq(0).children().eq(2).prop("disabled", true)
      }else if(index == "CHAT 4"){
        $(".chat_frame").eq(3).css({"top":"0", "right":"0", "width":"20vw", "height":"100vh"})
        $(".chat_frame").eq(3).removeClass("not_show")
        $(".chats").eq(0).children().eq(3).prop("disabled", true)
      }else if(index == "CUSTOM"){
        $(".custom_chat").css({"top":"0", "right":"0", "width":"20vw", "height":"100vh"})
        $(".custom_chat").removeClass("not_show")
        $(".chats").eq(0).children().eq(4).prop("disabled", true)
      }
    },
    frames: function(frame){
      if(frame == 1){
        $(".video_frame").css({"top":"0", "width":"80vw", "height":"100vh"})
        $(".chat_frame").css({"top":"0", "right":"0", "width":"20vw", "height":"100vh"})
        $(".delete_video").css({"top":"90vh", "right":"22vw"})
        $(".chats").eq(0).css({"top":"2vh", "right":"6vw"})
        $(".chats").eq(1).addClass("not_show")
        $(".custom_chat").addClass("not_show")
      }else if(frame == 2){
        $(".chats").removeClass("not_show")
        $(".video_frame").eq(0).css({"top":"0", "left":"0"})
        $(".video_frame").eq(1).css({"top":"50vh", "left":"0"})
        $(".video_frame").css({"width":"60vw", "height":"50vh"})
        $(".chat_frame").eq(0).css({"top":"0", "right":"20vw", "width":"20vw", "height":"100vh"})
        $(".chat_frame").eq(1).css({"top":"0", "right":"0", "width":"20vw", "height":"100vh"})
        $(".delete_video").eq(0).css({"top":"40vh", "right":"42vw"})
        $(".delete_video").eq(1).css({"top":"90vh", "right":"42vw"})
        $(".chats").eq(0).css({"top":"2vh", "right":"26vw"})
        $(".chats").eq(1).css({"top":"2vh", "right":"6vw"})
        $(".custom_chat").addClass("not_show")
      }else if(frame == 3){
        $(".chats").removeClass("not_show")
        $(".chat_frame").removeClass("not_show")
        $(".video_frame").eq(0).css({"top":"0", "width":"60vw", "height":"50vh"})
        $(".video_frame").eq(1).css({"top":"50vh", "left":"0", "width":"30vw", "height":"50vh"})
        $(".video_frame").eq(2).css({"top":"50vh", "left":"30vw", "width":"30vw", "height":"50vh"})
        $(".chat_frame").eq(0).css({"top":"0", "right":"20vw", "width":"20vw", "height":"100vh"})
        $(".chat_frame").eq(1).css({"top":"0", "right":"0", "width":"20vw", "height":"100vh"})
        $(".delete_video").eq(0).css({"top":"40vh", "right":"42vw"})
        $(".delete_video").eq(1).css({"top":"90vh", "right":"72vw"})
        $(".delete_video").eq(2).css({"top":"90vh", "right":"42vw"})
        $(".chats").eq(0).css({"top":"2vh", "right":"26vw"})
        $(".chats").eq(1).css({"top":"2vh", "right":"6vw"})
        $(".custom_chat").addClass("not_show")
      }else if(frame == 4){
        $(".chats").removeClass("not_show")
        $(".chat_frame").removeClass("not_show")
        $(".video_frame").eq(0).css({"top":"0", "width":"30vw", "height":"50vh"})
        $(".video_frame").eq(1).css({"top":"0", "left":"30vw", "width":"30vw", "height":"50vh"})
        $(".video_frame").eq(2).css({"top":"50vh", "left":"0", "width":"30vw", "height":"50vh"})
        $(".video_frame").eq(3).css({"top":"50vh", "left":"30vw", "width":"30vw", "height":"50vh"})
        $(".chat_frame").eq(0).css({"top":"0", "right":"20vw", "width":"20vw", "height":"100vh"})
        $(".chat_frame").eq(1).css({"top":"0", "right":"0", "width":"20vw", "height":"100vh"})
        $(".delete_video").eq(0).css({"top":"40vh", "right":"72vw"})
        $(".delete_video").eq(1).css({"top":"40vh", "right":"42vw"})
        $(".delete_video").eq(2).css({"top":"90vh", "right":"72vw"})
        $(".delete_video").eq(3).css({"top":"90vh", "right":"42vw"})
        $(".chats").eq(0).css({"top":"2vh", "right":"26vw"})
        $(".chats").eq(1).css({"top":"2vh", "right":"6vw"})
        $(".custom_chat").addClass("not_show")
      }
    }
  }
})
</script>
