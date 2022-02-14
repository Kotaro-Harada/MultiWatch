import TurbolinksAdapter from 'vue-turbolinks'
import ActionCable from 'actioncable'
import Vue from 'vue/dist/vue.esm'
import Whisper from '../vue/whisper.vue'
import Edit from '../vue/edit.vue'
import Chat from '../vue/chat.vue'
import Unfollow from '../vue/unfollow.vue'
import Follow from '../vue/follow.vue'

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
      template: "<follow/>",
      components: { Follow }
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

document.addEventListener('turbolinks:load', () => {
  new Vue({
    name: 'UnfollowComponent',
    el: '#unfollow',
    template: "<unfollow/>",
    components: { Unfollow },
  })
})
