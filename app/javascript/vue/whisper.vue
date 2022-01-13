<template>
  <div>
    <div>
      <button id="message_button" class="btn btn-primary" @click="whisper">{{ send }}</button>
    </div>
    <div class="send_receive">
      <div class="select_receive underline">
        <p>受信メッセージ</p>
      </div>
      <div>
        <button class="btn btn-danger clear_button" @click="delete_whisper">
          <p>クリア</p>
        </button>
      </div>
    </div>
    <div class="receive_box">
      <div v-for="(whisper,index) in whispers" :key="index">
        <div v-if="whispers[index - 1]
          && whispers[index].created_at != whispers[index - 1].created_at">
          <p>{{ whisper.created_at }}</p>
        </div>
        <div class="each_message">
          <div class="send_user">
            <p>{{ whisper.send_user_name }}:</p>
          </div>
          <div class="receive_message">
            <p>{{ whisper.message }}</p>
          </div>
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
      whispers: [],
      send: "送信"
    }
  },
  mounted(){
    axios.get("/api/v1/whispers").then((response) => { this.whispers = response.data })
  },
  methods: {
    whisper: function(){
      axios.post("/api/v1/whispers",{
        whisper: {
          receive_user_name: $(".receive_user_name").val(),
          send_user_id: $(".send_user_id").val(),
          send_user_name: $(".send_user_name").val(),
          message: $("#message").val(),
        }
      }).then(response => (
        this.whispers = response.data,
        this.send = "送信しました",
        $("#message").val(""),
        setTimeout(() => {this.send = "送信"}, 2000)
      )).catch(error => {
        $("#message_button").addClass("fas fa-exclamation-circle");
        $("#message_button").prop("disabled", true);
        setTimeout(() => {
          this.send = "送信",
          $("#message_button").removeAttr("disabled"),
          $("#message_button").removeClass("fas fa-exclamation-circle")
        }, 3000);
        switch(error.response.status){
          case 422:
            this.send = "メッセージエラーです";
            break;
          case 404:
            this.send = "ユーザーが見つかりません";
            break;
          case 500:
            this.send = "現在メッセージを送信できません";
            break;
        }
      })
    },
    delete_whisper: function(){
      if(window.confirm("メッセージを全て削除します。よろしいですか？")){
        axios.delete("/api/v1/whispers/destroy",{
        }).then(response => (this.whispers = response.data));
      }
    }
  },
};
</script>
