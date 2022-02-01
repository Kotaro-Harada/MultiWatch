<template>
  <div>
    <div class="side_each_unfollow not_show" v-for="(follow, index) in follows" :key="`follow` + index">
      <div class="unfollow_image">
        <img :src="follow.image_url" class="icon_image" style="width: 35px; height:35px">
      </div>
      <div class="unfollow_content">
        <div class="unfollow_name">
          <p>{{ follow.name }}</p>
        </div>
        <div class="side_unfollow" @click="unfollow(follow.channel_id, index)">
          <i class="fas fa-heart-broken unfollow_channel"></i>
          <p class="unfollow_word">フォロー解除</p>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import axios from "axios";
const token = document.getElementsByName("csrf-token")[0].getAttribute("content");
axios.defaults.headers.common["X-CSRF-Token"] = token;

export default {
  data: function(){
    return{
      follows: []
    }
  },
  mounted(){
    axios.get("/follows").then(response => {
      this.follows = response.data
    })
  },
  methods: {
    unfollow: function(channel_id, index){
      axios.delete("/follows/destroy",{
        params: {
          channel_id: channel_id
        }
      }).then(response => {
        $(".unfollow_channel").eq(index).removeClass("fas fa-heart-broken")
        $(".unfollow_channel").eq(index).addClass("fas fa-check-circle")
        $(".unfollow_channel").eq(index).css({ "margin":"auto" })
        $(".unfollow_word").eq(index).text("")
      }).catch(error => {
        $(".unfollow_word").eq(index).text(" エラー")
        $(".unfollow_channel").eq(index).removeClass("fas fa-heart-broken")
        $(".unfollow_channel").eq(index).addClass("fas fa-exclamation-circle")
      })
    }
  }
}
</script>
