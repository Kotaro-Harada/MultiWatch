import TurbolinksAdapter from 'vue-turbolinks'
import ActionCable from 'actioncable'
import Vue from 'vue/dist/vue.esm'
import Whisper from '../vue/whisper.vue'
import Edit from '../vue/edit.vue'
import Chat from '../vue/chat.vue'
import axios from "axios"

const cable = ActionCable.createConsumer('ws:localhost:3000/cable');
Vue.prototype.$cable = cable;
Vue.use(TurbolinksAdapter);

document.addEventListener('turbolinks:load', () => {
  const app = new Vue({
    name: 'WhisperComponent',
    el: '#whisper',
    template: "<whisper/>",
    components: { Whisper },
  })
})

for(let i = 0; i <= 4; i++ ){
  document.addEventListener('turbolinks:load', () => {
    new Vue({
      name: 'FollowComponent',
      el: `#follow${i}`,
      template: `
        <div>
          <div class="follow_form" v-if="!check_follow">
            <button id="follow_button" class="unfollow_button" @click="follow_button">
              <i class="fas fa-heart"> フォロー</i>
            </button>
          </div>
          <div class="unfollow_form" v-if="check_follow">
            <button id="follow_button" class="follow_button" @click="unfollow_button">
              <i class="fas fa-heart-broken"> フォロー解除</i>
            </button>
          </div>
        </div>
      `,
      data: {
        check_follow: "",
        follows: []
      },
      mounted(){
        axios.get("/follow/check",{
          params: {
            channel_id: $(`.channel_id${i}`).val()
          }
        }).then((response) => {
          this.check_follow = response.data;
        })
      },
      methods: {
        follow_button: function(){
          axios.post("/follow",{
            follow: {
              name: $(`.name${i}`).val(),
              display_name: $(`.display_name${i}`).val(),
              user_id: $(`.user_id${i}`).val(),
              platform: $(`.platform${i}`).val(),
              channel_id: $(`.channel_id${i}`).val()
            },
            image_url: $(`.image_url${i}`).val()
          }).then(response => {
            this.check_follow = response.data;
          }).catch(error => {
            $("#follow_button i").text(" エラー");
            $("#follow_button i").removeClass("fas fa-heart");
            $("#follow_button i").addClass("fas fa-exclamation-circle");
            $("#follow_button").prop("disabled", true);
          })
        },
        unfollow_button: function(){
          axios.delete("/follow/destroy",{
            params: {
              channel_id: $(`.channel_id${i}`).val()
            }
          }).then(response => {
            this.check_follow = response.data;
          }).catch(error => {
            $("#follow_button i").text(" エラー");
            $("#follow_button i").removeClass("fas fa-heart-broken");
            $("#follow_button i").addClass("fas fa-exclamation-circle");
            $("#follow_button").prop("disabled", true);
          })
        }
      },
    })
  })
}

document.addEventListener('turbolinks:load', () => {
  new Vue({
    name: 'EditComponent',
    el: '#edit',
    template: "<edit/>",
    components: { Edit },
  })
})

document.addEventListener('turbolinks:load', () => {
  new Vue({
    name: 'ChatComponent',
    el: '#chat',
    template: "<chat/>",
    components: { Chat },
  })
})
