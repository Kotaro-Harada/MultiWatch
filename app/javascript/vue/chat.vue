<template>
  <div>
    <div v-if="!room">
      <div class="room custom_chat">
        <div class="room_button">
          <button class="btn btn-primary" @click="create_room">
            <p class="create_chat_room">ルームを作成</p>
          </button>
        </div>
      </div>
    </div>
    <div v-if="room">
      <div class="custom_chat">
        <div class="invite_index_user">
          <div class="toggle_users">
            <i class="fas fa-user-friends fa-lg participants_icon" @click="participants_friends"></i>
          </div>
          <div class="invite_exit not_show">
            <div class="user_in_chat">
              <p>チャット内のユーザー(最大10人)</p>
            </div>
            <div class="participants">
              <div v-for="(participant, index) in participants" :key="`participant` + index">
                <p>{{ participant.name }}</p>
              </div>
            </div>
            <div class="invite_user">
              <p>フレンドを招待する</p>
            </div>
            <div class="friends_list">
              <div v-for="(active_friend, index) in active_friends" :key="`active_friend` + index">
                <input type="checkbox" :value="active_friend.name" v-model="select_names">
                <label :for="active_friend.name">{{ active_friend.name }}</label>
              </div>
              <div v-for="(passive_friend, index) in passive_friends" :key="`passive_friend` + index">
                <input type="checkbox" :value="passive_friend.name" v-model="select_names">
                <label :for="passive_friend.name">{{ passive_friend.name }}</label>
              </div>
            </div>
            <div class="invite">
              <button class="btn btn-primary invite_button" @click="invite">
                <p class="invite_whisper">{{ invite_whisper }}</p>
              </button>
            </div>
            <p>チャットから退出する</p>
            <div class="exit">
              <button class="btn btn-danger exit_button" @click="exit">
                <p class="exit_word">{{ exit_word }}</p>
              </button>
            </div>
          </div>
        </div>
        <div class="chat_box">
          <div v-for="(chat, index) in chats" :key="index">
            <div class="each_chat">
              <div class="chat_user">
                <p>{{ chat.user }}:</p>
              </div>
              <div class="chat_comment">
                <p>{{ chat.message }}</p>
              </div>
            </div>
          </div>
        </div>
        <div class="comment_box">
          <div class="chat_message">
            <textarea class="chat_area" placeholder="メッセージ" rows="1" v-model="chat_message"
              v-on:keydown.enter.prevent="chat" @input="input_chat">
            </textarea>
          </div>
          <div>
            <button id="message_button" class="btn btn-primary chat_button"
              @click="chat">チャット
            </button>
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
      room: null,
      participants: [],
      invite_whisper: "招待",
      active_friends: [],
      passive_friends: [],
      select_names: [],
      exit_word: "退出",
      chat_message: "",
      chats: [],
      chatChannel: null
    }
  },
  mounted(){
    axios.get("/rooms").then(response => (
      this.room = response.data,
      this.chatChannel = this.$cable.subscriptions.create({
        channel: "ChatChannel",
        room_id: `${response.data.id}`
      },{ received: (data) => {
        this.chats.push(data)
      }})
    ))
  },
  methods: {
    create_room: function(){
      axios.post("/rooms").then(response => (
        this.room = response.data,
        this.chatChannel = this.$cable.subscriptions.create({
          channel: "ChatChannel",
          room_id: `${response.data.id}`
        },{ received: (data) => {
          this.chats.push(data)
        }})
      )).catch( error => {
        $(".create_chat_room").text("エラー")
        if(!$(".current_user_menu").children("p").text()){
          $(".create_chat_room").text("ログインして下さい")
        }
      })
    },
    participants_friends: function(){
      axios.get("/rooms/get_participants").then(response => (
        this.participants = response.data
      )),
      axios.get("/friendships/get_active_friends").then(response => (
        this.active_friends = response.data
      )),
      axios.get("/friendships/get_passive_friends").then(response => (
        this.passive_friends = response.data
      )),
      $(".invite_exit, .chat_box").toggleClass("not_show")
    },
    invite: function(){
      axios.post("/whispers/invite_chat", {
        whisper: {
          receive_user_name: this.select_names,
          message_type: "2",
        }
      }).then(response => (
        this.invite_whisper = "ウィスパーで招待しました",
        setTimeout(() => {this.invite_whisper = "招待"}, 2000)
      )).catch(error => {
        $("#message_button").prop("disabled", true),
        this.invite_whisper = "参加済みのユーザーがいます"
        setTimeout(() => {
          this.invite_whisper = "招待",
          $("#message_button").removeAttr("disabled")
        }, 3000)
      })
    },
    exit: function(){
      axios.delete("/user_room/destroy").then(() => (
        this.room = null,
        this.chatChannel = null,
        this.exit_word = "退出しました",
        setTimeout(() => {this.exit_word = "退出"}, 2000)
      )).catch(error => {
        this.exit_word = "チャットに参加していません",
        setTimeout(() => {this.exit_word = "退出"}, 3000)
      })
    },
    input_chat: function(){
      let rows = $(".chat_area").prop("rows")
      if($(".chat_area").outerHeight() < $(".chat_area")[0].scrollHeight){
        $(".chat_area").prop("rows", rows + 1)
      }
      if($(".chat_area").val() == ""){
        $(".chat_area").prop("rows", 1)
      }
    },
    chat: function(){
      this.chat_message = this.chat_message.replace(/\r?\n/g, "")
      if(this.chat_message && this.chat_message == $(".chat_area").val()){
        this.chatChannel.perform("speak", {
          user: $(".current_user_menu").children("p").text(),
          message: this.chat_message
        })
      }
      this.chat_message = "",
      $(".chat_area").prop("rows", 1)
    }
  }
}
</script>
