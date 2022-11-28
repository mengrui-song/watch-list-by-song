import { Controller } from "@hotwired/stimulus"
import Typed from "typed.js"
// Connects to data-controller="typed-js"
export default class extends Controller {
  connect() {
    new Typed(this.element, {
      strings: ["I believe if there's any kind of God it wouldn't be in any of us, not you or me but just this little space in between.", "If there's any kind of magic in this world it must be in the attempt of understanding someone sharing something."],
      typeSpeed: 20,
      loop: true
    })
  }
}
