<template>
  <div>
    <div class="whisper_box">
      <div class="send_receive">
        <div class="select_whisper">
          <p class="underline">ウィスパー</p>
        </div>
      </div>
      <div class="send_box">
        <div class="whisper_form">
          <input type="text" class="receive_user_name" placeholder="ユーザー名">
          <div class="send_message">
            <div class="message">
              <p class="underline">メッセージ</p>
            </div>
            <textarea id="message" v-model="message" placeholder="メッセージは50字までです" rows=2></textarea>
          </div>
        </div>
      </div>
      <div>
        <button id="message_button" class="btn btn-primary" @click="whisper(message)">{{ send_message }}</button>
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
        <div>
          <button class="btn btn-primary reload_button" @click="reload">
            <i class="fas fa-redo-alt"></i>
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
            <div class="send_user" v-if="!whisper.message_type">
              <p>{{ whisper.send_user_name }}</p><p>:</p>
            </div>
            <div class="receive_message">
              <p>{{ whisper.message }}</p>
            </div>
            <div class="confirm" v-if="whisper.message_type == 1">
              <button class="btn btn-success confirm_button" @click="confirm(whisper.send_user_id, index, whisper.id)">
                <p class="confirm_message">許可</p>
              </button>
            </div>
            <div class="join" v-else-if="whisper.message_type == 2">
              <button class="btn btn-success join_button" @click="join(whisper.send_user_id, index, whisper.id)">
                <p class="join_message">参加</p>
              </button>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import axios from "axios";
import $ from 'jquery'
if(document.getElementsByName("csrf-token")[0]){
  const token = document.getElementsByName("csrf-token")[0].getAttribute("content")
  axios.defaults.headers.common["X-CSRF-Token"] = token
}

export default {
  data: function(){
    return{
      whispers: [],
      send_message: "送信",
      message: ""
    }
  },
  mounted(){
    axios.get("/api/v1/whispers").then(response => { this.whispers = response.data })
  },
  methods: {
    whisper: function(message){
      axios.post("/api/v1/whispers",{
        whisper: {
          receive_user_name: $(".receive_user_name").val(),
          message: message
        }
      }).then(response => (
        this.send_message = "送信しました",
        this.message = "",
        setTimeout(() => {this.send_message = "送信"}, 2000)
      )).catch(error => {
        $("#message_button").addClass("fas fa-exclamation-circle"),
        $("#message_button").prop("disabled", true),
        setTimeout(() => {
          this.send_message = "送信",
          $("#message_button").removeAttr("disabled"),
          $("#message_button").removeClass("fas fa-exclamation-circle")
        }, 3000)
        switch(error.response.status){
          case 422:
            this.send_message = "メッセージエラーです";
            break;
          case 404:
            this.send_message = "ユーザーが見つかりません";
            break;
          case 500:
            this.send_message = "現在メッセージを送信できません";
            break;
        }
      })
    },
    delete_whisper: function(){
      if(window.confirm("メッセージを全て削除します。よろしいですか？")){
        axios.delete("/api/v1/whispers/destroy", {
        }).then(response => (this.whispers = response.data));
      }
    },
    confirm: function(user_id, index, whisper_id){
      axios.post("/friendships", {
        friendship: {
          from_user_id: user_id
        },
        id: whisper_id,
      }).then(function(){
        $(".each_message").eq(index).find(".confirm_button").prop("disabled", true),
        $(".each_message").eq(index).find(".confirm_button").addClass("fas fa-check"),
        $(".each_message").eq(index).find(".confirm_message").text("")
      }).catch(error => {
        $(".each_message").eq(index).find(".confirm_button").addClass("fas fa-exclamation-circle"),
        $(".each_message").eq(index).find(".confirm_message").text(""),
        $(".confirm_button").prop("disabled", true)
        setTimeout(() => {
          $(".each_message").eq(index).find(".confirm_message").text("許可"),
          $(".confirm_button").removeClass("fa-exclamation-circle"),
          $(".confirm_button").removeAttr("disabled")
        }, 3000)
      })
    },
    join: function(user_id, index, whisper_id){
      axios.post("/rooms/add_user", {
        user_id: user_id,
        whisper_id: whisper_id
      }).then(response => (
        $(".each_message").eq(index).find(".join_button").prop("disabled", true),
        $(".each_message").eq(index).find(".join_button").addClass("fas fa-check"),
        $(".each_message").eq(index).find(".join_message").text(""),
        console.log(response.data),
        this.chatChannel = this.$cable.subscriptions.create({ channel: "ChatChannel_", room: response.data.id })
      )).catch(error => {
        $(".each_message").eq(index).find(".join_button").addClass("fas fa-exclamation-circle"),
        $(".each_message").eq(index).find(".join_message").text(""),
        $(".join_button").prop("disabled", true)
        setTimeout(() => {
          $(".each_message").eq(index).find(".join_message").text("参加"),
          $(".join_button").removeClass("fa-exclamation-circle"),
          $(".join_button").removeAttr("disabled")
        }, 3000)
      })
    },
    reload: function(){
      axios.get("/api/v1/whispers").then((response) => {
        this.whispers = response.data,
        $(".reload_button").prop("disabled", true),
        $(".receive_box").scrollTop(350),
        setTimeout(() => {this.send_message = "送信"}, 2000),
        setTimeout(() => { $(".reload_button").removeAttr("disabled")}, 2000)
      })
    }
  }
}
</script>
