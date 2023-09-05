import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toggle"
export default class extends Controller {
  static targets = ["textarea", "modif", "regen"]

  connect() {
    console.log("toggle_controller.js prêt à toggle text area")
  }

  fireArea(event) {
    event.preventDefault();

    this.modifTarget.classList.toggle("d-none");
    this.regenTarget.classList.toggle("d-none");

    this.textareaTarget.classList.toggle("d-none");
  }

  cancelArea(event) {
    event.preventDefault();
    console.log("mon bouton cancel marche !");
    this.modifTarget.classList.toggle("d-none");
    this.regenTarget.classList.toggle("d-none");
    this.textareaTarget.classList.toggle("d-none");
  }

}
