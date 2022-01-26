<template>
  <div>
    <div class="video">
      <div class="add_video">
        <div class="add_by_url"><p class="underline">URL</p></div>
        <div class="add_by_follow"><p>フォロー</p></div>
      </div>
      <div class="search_by_url">
        <select id="platform" v-model="platform">
          <option>YouTube</option>
          <option>Twitch</option>
          <option>NicoNico</option>
        </select>
        <input id="url" size="40" v-model="url">
          <button class="url_button" @click="add_by_url(platform, url)">追加</button>
      </div>
      <div class="search_from_follows not_show">
        <div class="each_follow" v-for="(follow, index) in follows" :key="`follow` + index">
          <div class="follow_image">
            <img :src="follow.image_url" class="icon_image channel_icon" style="width: 35px; height:35px"
              @click="add_by_follow(follow.channel_id, follow.platform, follow.name)">
          </div>
        </div>
      </div>
    </div>
    <div class="layout">
      <div>
        <div class="change_layout"><p>レイアウト</p></div>
        <div class="layout_type" v-if="frames == 1">
          <div class="type" style="width: 150px; height:100px" @click="layout1">
            <div class="frame" style="top: 0; left: 0; width: 140px; height: 90px;"><i class="fas fa-video" style="line-height:90px"></i></div>
          </div>
          <div class="type" style="width: 150px; height:100px" @click="layout2">
            <div class="frame" style="top: 0; left: 0; width: 100px; height: 90px;"><i class="fas fa-video" style="line-height:90px"></i></div>
            <div class="chat" style="top: 0; right: 0; width: 30px; height: 90px;"><i class="fas fa-comment" style="line-height:90px"></i></div>
          </div>
        </div>
        <div class="layout_type" v-if="frames == 2">
          <div class="type" style="width: 150px; height:100px" @click="layout3">
            <div class="frame" style="top: 0; left: 0; width: 65px; height: 90px;"><i class="fas fa-video" style="line-height:90px"></i></div>
            <div class="frame" style="top: 0; left: 50%; width: 65px; height: 90px;"><i class="fas fa-video" style="line-height:90px"></i></div>
          </div>
          <div class="type" style="width: 150px; height:100px" @click="layout4">
            <div class="frame" style="top: 0; left: 0; width: 100px; height: 40px;"><i class="fas fa-video" style="line-height:40px"></i></div>
            <div class="frame" style="top: 50%; left: 0; width: 100px; height: 40px;"><i class="fas fa-video" style="line-height:40px"></i></div>
            <div class="chat" style="top: 0; right: 0; width: 30px; height: 90px;"><i class="fas fa-comment" style="line-height:90px"></i></div>
          </div>
          <div class="type" style="width: 150px; height:100px" @click="layout5">
            <div class="frame" style="top: 0; left: 0; width: 80px; height: 40px;"><i class="fas fa-video" style="line-height:40px"></i></div>
            <div class="frame" style="top: 50%; left: 0; width: 80px; height: 40px;"><i class="fas fa-video" style="line-height:40px"></i></div>
            <div class="chat" style="top: 0; right: 0; width: 20px; height: 90px;"><i class="fas fa-comment" style="line-height:90px"></i></div>
            <div class="chat" style="top: 0; right: 30px; width: 20px; height: 90px;"><i class="fas fa-comment" style="line-height:90px"></i></div>
          </div>
        </div>
        <div class="layout_type" v-if="frames == 3">
          <div class="rotate_video"><i class="fas fa-sync-alt fa-2x" @click="rotate"></i></div>
          <div class="type" style="width: 150px; height:100px" @click="layout6">
            <div class="frame" style="top: 0; left: 0; width: 65px; height: 90px;"><i class="fas fa-video" style="line-height:90px"></i></div>
            <div class="frame" style="top: 0; left: 50%; width: 65px; height: 40px;"><i class="fas fa-video" style="line-height:40px"></i></div>
            <div class="frame" style="top: 50%; left: 50%; width: 65px; height: 40px;"><i class="fas fa-video" style="line-height:40px"></i></div>
          </div>
          <div class="type" style="width: 150px; height:100px" @click="layout7">
            <div class="frame" style="top: 0; left: 0; width: 110px; height: 40px;"><i class="fas fa-video" style="line-height:40px"></i></div>
            <div class="frame" style="top: 50%; left: 0; width: 50px; height: 40px;"><i class="fas fa-video" style="line-height:40px"></i></div>
            <div class="frame" style="top: 50%; left: 60px; width: 50px; height: 40px;"><i class="fas fa-video" style="line-height:40px"></i></div>
            <div class="chat" style="top: 0; right: 0; width: 20px; height: 90px;"><i class="fas fa-comment" style="line-height:90px"></i></div>
          </div>
          <div class="type" style="width: 150px; height:100px" @click="layout8">
            <div class="frame" style="top: 0; left: 0; width: 80px; height: 40px;"><i class="fas fa-video" style="line-height:40px"></i></div>
            <div class="frame" style="top: 50%; left: 0; width: 35px; height: 40px;"><i class="fas fa-video" style="line-height:40px"></i></div>
            <div class="frame" style="top: 50%; left: 45px; width: 35px; height: 40px;"><i class="fas fa-video" style="line-height:40px"></i></div>
            <div class="chat" style="top: 0; right: 0; width: 20px; height: 90px;"><i class="fas fa-comment" style="line-height:90px"></i></div>
            <div class="chat" style="top: 0; right: 30px; width: 20px; height: 90px;"><i class="fas fa-comment" style="line-height:90px"></i></div>
          </div>
        </div>
        <div class="layout_type" v-if="frames == 4">
          <div class="type" style="width: 150px; height:100px" @click="layout9">
            <div class="frame" style="top: 0; left: 0; width: 65px; height: 40px;"><i class="fas fa-video" style="line-height:40px"></i></div>
            <div class="frame" style="top: 0; left: 50%; width: 65px; height: 40px;"><i class="fas fa-video" style="line-height:40px"></i></div>
            <div class="frame" style="top: 50%; left: 0; width: 65px; height: 40px;"><i class="fas fa-video" style="line-height:40px"></i></div>
            <div class="frame" style="top: 50%; left: 50%; width: 65px; height: 40px;"><i class="fas fa-video" style="line-height:40px"></i></div>
          </div>
          <div class="type" style="width: 150px; height:100px" @click="layout10">
            <div class="frame" style="top: 0; left: 0; width: 50px; height: 40px;"><i class="fas fa-video" style="line-height:40px"></i></div>
            <div class="frame" style="top: 0; left: 60px; width: 50px; height: 40px;"><i class="fas fa-video" style="line-height:40px"></i></div>
            <div class="frame" style="top: 50%; left: 0; width: 50px; height: 40px;"><i class="fas fa-video" style="line-height:40px"></i></div>
            <div class="frame" style="top: 50%; left: 60px; width: 50px; height: 40px;"><i class="fas fa-video" style="line-height:40px"></i></div>
            <div class="chat" style="top: 0; right: 0; width: 20px; height: 90px;"><i class="fas fa-comment" style="line-height:90px"></i></div>
          </div>
          <div class="type" style="width: 150px; height:100px" @click="layout11">
            <div class="frame" style="top: 0; left: 0; width: 35px; height: 40px;"><i class="fas fa-video" style="line-height:40px"></i></div>
            <div class="frame" style="top: 0; left: 45px; width: 35px; height: 40px;"><i class="fas fa-video" style="line-height:40px"></i></div>
            <div class="frame" style="top: 50%; left: 0; width: 35px; height: 40px;"><i class="fas fa-video" style="line-height:40px"></i></div>
            <div class="frame" style="top: 50%; left: 45px; width: 35px; height: 40px;"><i class="fas fa-video" style="line-height:40px"></i></div>
            <div class="chat" style="top: 0; right: 0; width: 20px; height: 90px;"><i class="fas fa-comment" style="line-height:90px"></i></div>
            <div class="chat" style="top: 0; right: 30px; width: 20px; height: 90px;"><i class="fas fa-comment" style="line-height:90px"></i></div>
          </div>
        </div>
      </div>
    </div>
    <watch v-bind:youtube_url="this.youtube" v-bind:twitch_url="this.twitch"
      v-bind:niconico_url="this.niconico" @number_of_frames=count_frames v-bind:frames="this.frames" />
  </div>
</template>

<script>
import Watch from "./watch"
import axios from "axios"
const token = document.getElementsByName("csrf-token")[0].getAttribute("content")
axios.defaults.headers.common["X-CSRF-Token"] = token

export default ({
  components: {
    watch: Watch
  },
  data: function(){
    return{
      youtube: "",
      twitch: "",
      niconico: "",
      platform: "YouTube",
      url: "",
      follows: [],
      frames: 0,
      first: 0,
      second: 1,
      third: 2,
      chat_type: 2
    }
  },
  mounted(){
    axios.get("/follow").then(response => {
      this.follows = response.data
    }),
    this.$nextTick(function () {
      this.frames = $(".video_frame").length
    }),
    $(".add_by_follow p").on("click", function(){
      $(".add_by_follow p").addClass("underline")
      $(".search_by_url").addClass("not_show")
      $(".add_by_url p").removeClass("underline")
      $(".search_from_follows").removeClass("not_show")
    }),

    $(".add_by_url p").on("click", function(){
      $(".add_by_url p").addClass("underline")
      $(".search_from_follows").addClass("not_show")
      $(".add_by_follow p").removeClass("underline")
      $(".search_by_url").removeClass("not_show")
    })
  },
  methods: {
    add_by_url: function(platform, url){
      if(platform == "YouTube"){
        let clipped_url = url.split("v=")
        this.youtube = clipped_url[1]
      }else if(platform == "Twitch"){
        let clipped_url = url.split("tv/")
        this.twitch = clipped_url[1]
      }else{
        let clipped_url = url.split("watch/")
        this.niconico = clipped_url[1]
      }
      this.url = ""
      $(".delete_video").removeClass("show")
      this.$nextTick(function () {
        this.frames = $(".video_frame").length
      })
    },
    add_by_follow: function(id, platform, name){
      if(platform){
        axios.get("/follow/get_stream", {
          params: {
            channel_id: id
          }
        }).then(response => {
          this.youtube = response.data
        })
      }else{
        this.twitch = name
      }
      $(".delete_video").removeClass("show")
      this.$nextTick(function () {
        this.frames = $(".video_frame").length
      })
    },
    count_frames: function(frames){
      this.frames = frames
    },
    layout1: function(){
      $(".chat_frame, .chats").addClass("not_show")
      $(".video_frame").css({"width":"100vw"})
      $(".delete_video").css({"right":"2vw"})
    },
    layout2: function(){
      $(".chat_frame").removeClass("not_show")
      $(".chats").eq(0).removeClass("not_show")
      $(".video_frame").css({"width":"80vw"})
      $(".delete_video").css({"right":"22vw"})
      $(".chats").eq(0).css({"top":"2vh", "right":"2vw"})
    },
    layout3: function(){
      $(".chat_frame, .chats").addClass("not_show")
      $(".video_frame").eq(0).css({"top":"0", "left":"0", "width":"50vw", "height":"100vh"})
      $(".video_frame").eq(1).css({"top":"0", "left":"50vw", "width":"50vw", "height":"100vh"})
      $(".delete_video").eq(0).css({"top":"90vh", "right":"52vw"})
      $(".delete_video").eq(1).css({"right":"2vw"})
    },
    layout4: function(){
      $(".chat_frame").eq(0).removeClass("not_show")
      $(".chats").eq(0).removeClass("not_show")
      $(".chat_frame").eq(1).addClass("not_show")
      $(".chats").eq(1).addClass("not_show")
      $(".chat_frame").eq(0).css({"top":"0", "right":"0", "width":"20vw", "height":"100vh"})
      $(".video_frame").eq(1).css({"top":"50vh", "left":"0"})
      $(".video_frame").css({"width":"80vw", "height":"50vh"})
      $(".delete_video").css({"right":"22vw"})
      $(".chats").eq(0).css({"top":"2vh", "right":"6vw"})
    },
    layout5: function(){
      $(".chat_frame, .chats").removeClass("not_show")
      $(".video_frame").eq(1).css({"top":"50vh", "left":"0"})
      $(".video_frame").css({"width":"60vw", "height":"50vh"})
      $(".chat_frame").eq(0).css({"top":"0", "right":"20vw", "width":"20vw", "height":"100vh"})
      $(".chat_frame").eq(1).css({"top":"0", "right":"0", "width":"20vw", "height":"100vh"})
      $(".delete_video").eq(0).css({"top":"40vh", "right":"42vw"})
      $(".delete_video").eq(1).css({"top":"90vh", "right":"42vw"})
      $(".chats").eq(0).css({"top":"2vh", "right":"26vw"})
      $(".chats").eq(1).css({"top":"2vh", "right":"6vw"})
    },
    layout6: function(){
      $(".chat_frame, .chats").addClass("not_show")
      $(".video_frame").eq(0).css({"top":"0", "left":"0", "width":"50vw", "height":"100vh"})
      $(".video_frame").eq(1).css({"top":"0", "left":"50vw", "width":"50vw", "height":"50vh"})
      $(".video_frame").eq(2).css({"top":"50vh", "left":"50vw", "width":"50vw", "height":"50vh"})
      $(".delete_video").eq(0).css({"top":"90vh", "right":"52vw"})
      $(".delete_video").eq(1).css({"top":"40vh", "right":"2vw"})
      $(".delete_video").eq(2).css({"top":"90vh", "right":"2vw"})
      this.chat_type = 0
    },
    layout7: function(){
      $(".chat_frame, .chats").addClass("not_show")
      $(".chats").eq(0).removeClass("not_show")
      $(".chats").eq(0).css({"top":"2vh", "right":"6vw"})
      $(".chat_frame").css({"top":"0", "right":"0", "width":"20vw", "height":"100vh"})
      $(".video_frame").eq(0).css({"top":"0", "left":"0", "width":"80vw", "height":"50vh"})
      $(".video_frame").eq(1).css({"top":"50vh", "left":"0", "width":"40vw", "height":"50vh"})
      $(".video_frame").eq(2).css({"top":"50vh", "left":"40vw", "width":"40vw", "height":"50vh"})
      $(".delete_video").eq(0).css({"top":"40vh", "right":"22vw"})
      $(".delete_video").eq(1).css({"top":"90vh", "right":"62vw"})
      $(".delete_video").eq(2).css({"top":"90vh", "right":"22vw"})
      this.chat_type = 1
    },
    layout8: function(){
      $(".chats").removeClass("not_show")
      $(".video_frame").eq(0).css({"top":"0", "left":"0", "width":"60vw", "height":"50vh"})
      $(".video_frame").eq(1).css({"top":"50vh", "left":"0", "width":"30vw", "height":"50vh"})
      $(".video_frame").eq(2).css({"top":"50vh", "left":"30vw", "width":"30vw", "height":"50vh"})
      $(".chat_frame").eq(0).css({"top":"0", "right":"20vw", "width":"20vw", "height":"100vh"})
      $(".chat_frame").eq(1).css({"top":"0", "right":"0", "width":"20vw", "height":"100vh"})
      $(".delete_video").eq(0).css({"top":"40vh", "right":"42vw"})
      $(".delete_video").eq(1).css({"top":"90vh", "right":"72vw"})
      $(".delete_video").eq(2).css({"top":"90vh", "right":"42vw"})
      $(".chats").eq(0).css({"top":"2vh", "right":"26vw"})
      $(".chats").eq(1).css({"top":"2vh", "right":"6vw"})
      this.chat_type = 2
    },
    layout9: function(){
      $(".chat_frame, .chats").addClass("not_show")
      $(".video_frame").eq(0).css({"top":"0", "width":"50vw", "height":"50vh"})
      $(".video_frame").eq(1).css({"top":"0", "left":"50vw", "width":"50vw", "height":"50vh"})
      $(".video_frame").eq(2).css({"top":"50vh", "left":"0", "width":"50vw", "height":"50vh"})
      $(".video_frame").eq(3).css({"top":"50vh", "left":"50vw", "width":"50vw", "height":"50vh"})
      $(".delete_video").eq(0).css({"top":"40vh", "right":"52vw"})
      $(".delete_video").eq(1).css({"top":"40vh", "right":"2vw"})
      $(".delete_video").eq(2).css({"top":"90vh", "right":"52vw"})
      $(".delete_video").eq(3).css({"top":"90vh", "right":"2vw"})
    },
    layout10: function(){
      $(".chat_frame, .chats").addClass("not_show")
      $(".chats").eq(0).removeClass("not_show")
      $(".chats").eq(0).css({"top":"2vh", "right":"6vw"})
      $(".chat_frame").css({"top":"0", "right":"0", "width":"20vw", "height":"100vh"})
      $(".video_frame").eq(0).css({"top":"0", "width":"40vw", "height":"50vh"})
      $(".video_frame").eq(1).css({"top":"0", "left":"40vw", "width":"40vw", "height":"50vh"})
      $(".video_frame").eq(2).css({"top":"50vh", "left":"0", "width":"40vw", "height":"50vh"})
      $(".video_frame").eq(3).css({"top":"50vh", "left":"40vw", "width":"40vw", "height":"50vh"})
      $(".delete_video").eq(0).css({"top":"40vh", "right":"62vw"})
      $(".delete_video").eq(1).css({"top":"40vh", "right":"22vw"})
      $(".delete_video").eq(2).css({"top":"90vh", "right":"62vw"})
      $(".delete_video").eq(3).css({"top":"90vh", "right":"22vw"})
    },
    layout11: function(){
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
    },
    rotate: function(){
      if(this.chat_type == 0){
        $(".video_frame").eq(this.first).css({"top":"50vh", "left":"50vw", "width":"50vw", "height":"50vh"})
        $(".video_frame").eq(this.second).css({"top":"0", "left":"50vw", "width":"50vw", "height":"50vh"})
        $(".video_frame").eq(this.third).css({"top":"0", "left":"0", "width":"50vw", "height":"100vh"})
        $(".delete_video").eq(this.first).css({"top":"40vh", "right":"2vw"})
        $(".delete_video").eq(this.second).css({"top":"90vh", "right":"2vw"})
        $(".delete_video").eq(this.third).css({"top":"90vh", "right":"52vw"})
      }else if(this.chat_type == 1){
        $(".video_frame").eq(this.first).css({"top":"50vh", "left":"40vw", "width":"40vw", "height":"50vh"})
        $(".video_frame").eq(this.second).css({"top":"0", "left":"0", "width":"80vw", "height":"50vh"})
        $(".video_frame").eq(this.third).css({"top":"50vh", "left":"0", "width":"40vw", "height":"50vh"})
        $(".delete_video").eq(this.first).css({"top":"90vh", "right":"22vw"})
        $(".delete_video").eq(this.second).css({"top":"40vh", "right":"22vw"})
        $(".delete_video").eq(this.third).css({"top":"90vh", "right":"62vw"})
      }else{
        $(".video_frame").eq(this.first).css({"top":"50vh", "left":"30vw", "width":"30vw", "height":"50vh"})
        $(".video_frame").eq(this.second).css({"top":"0", "left":"0", "width":"60vw", "height":"50vh"})
        $(".video_frame").eq(this.third).css({"top":"50vh", "left":"0", "width":"30vw", "height":"50vh"})
        $(".delete_video").eq(this.first).css({"top":"90vh", "right":"42vw"})
        $(".delete_video").eq(this.second).css({"top":"40vh", "right":"42vw"})
        $(".delete_video").eq(this.third).css({"top":"90vh", "right":"72vw"})
      }
      this.first++
      this.second++
      this.third++
      if(this.first == 3){
        this.first = 0
      }
      if(this.second == 3){
        this.second = 0
      }
      if(this.third == 3){
        this.third = 0
      }
    }
  }
})
</script>
