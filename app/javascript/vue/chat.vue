<template>
  <div class="custom_chat">
    <div class="chat_title">
      <p>チャット</p>
      <div class="participants"><i class="fas fa-users"></i></div>
    </div>
    <div class="chat_box">
      <div class="comment">
        <p>{{ chat.user_name }}:{{ chat.comment }}</p>
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
      room: [],
      chat: {
        user_name: "",
        comment: ""
      }
    }
  }
}
</script>
