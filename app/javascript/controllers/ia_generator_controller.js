import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="ia-generator"
export default class extends Controller {
  static targets = ["prompt", "text"]

  connect() {
    console.log("Controller Stimulus bien démarré !");

  }

  blur() {
    if (this.promptTarget.value === "") {
      this.promptTarget.classList.add("is-invalid")
      this.textTarget.classList.remove("d-none")
    }
  else {
    this.promptTarget.classList.remove("is-invalid")
    this.textTarget.classList.add("d-none")
  }

  }

}
