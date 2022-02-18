import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "./channels"
import "../js/custom"
import "../js/app_vue"

Rails.start()
Turbolinks.start()
ActiveStorage.start()
