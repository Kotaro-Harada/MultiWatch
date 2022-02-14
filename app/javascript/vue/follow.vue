<template>
  <div>
    <div class="follow_form" v-if="!check_follow">
      <button id="follow_button" class="unfollow_button follow_unfollow" @click="follow_button(index)">
        <i class="fas fa-heart"> フォロー</i>
      </button>
    </div>
    <div class="unfollow_form" v-if="check_follow">
      <button id="follow_button" class="follow_button follow_unfollow" @click="unfollow_button(index)">
        <i class="fas fa-heart-broken"> フォロー解除</i>
      </button>
    </div>
  </div>
</template>

<script>
import axios from "axios"
import $ from 'jquery'
if(document.getElementsByName("csrf-token")[0]){
  const token = document.getElementsByName("csrf-token")[0].getAttribute("content")
  axios.defaults.headers.common["X-CSRF-Token"] = token
}

export default {
  data: function(){
    return {
      check_follow: "",
      follows: [],
      index: 0
    }
  },
  created(){
    this.index = $(".follow_unfollow").length
  },
  mounted(){
    axios.get("/follows/check",{
      params: {
        channel_id: $(`.channel_id${this.index}`).val()
      }
    }).then((response) => {
      this.check_follow = response.data
    })
  },
  methods: {
    follow_button: function(index){
      axios.post("/follows",{
        follow: {
          name: $(`.name${index}`).val(),
          display_name: $(`.display_name${index}`).val(),
          user_id: $(`.user_id${index}`).val(),
          platform: $(`.platform${index}`).val(),
          channel_id: $(`.channel_id${index}`).val()
        },
        image_url: $(`.image_url${index}`).val()
      }).then(response => {
        this.check_follow = response.data
      }).catch(error => {
        $("#follow_button i").text(" エラー"),
        $("#follow_button i").removeClass("fas fa-heart"),
        $("#follow_button i").addClass("fas fa-exclamation-circle"),
        $("#follow_button").prop("disabled", true)
      })
    },
    unfollow_button: function(index){
      axios.delete("/follows/destroy",{
        params: {
          channel_id: $(`.channel_id${index}`).val()
        }
      }).then(response => {
        this.check_follow = response.data
      }).catch(error => {
        $("#follow_button i").text(" エラー"),
        $("#follow_button i").removeClass("fas fa-heart-broken"),
        $("#follow_button i").addClass("fas fa-exclamation-circle"),
        $("#follow_button").prop("disabled", true)
      })
    }
  }
}

</script>
