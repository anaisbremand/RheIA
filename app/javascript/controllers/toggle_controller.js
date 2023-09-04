import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toggle"
export default class extends Controller {
  static targets = ["togglableElement", "dispare"]

  connect() {
    console.log("Hello from toggle_controller.js")
  }

  fire(event) {
    event.preventDefault();
    this.togglableElementTarget.classList.toggle("d-none");
    this.dispareTarget.classList.toggle("d-none");
  }

}
