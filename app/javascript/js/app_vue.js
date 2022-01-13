import TurbolinksAdapter from 'vue-turbolinks'
import Vue from 'vue/dist/vue.esm'
import Whisper from '../vue/whisper.vue'

Vue.use(TurbolinksAdapter)

document.addEventListener('turbolinks:load', () => {
  const app = new Vue({
    name: 'WhisperComponent',
    el: '#whisper',
    template: "<whisper/>",
    components: { Whisper },
  })
})
