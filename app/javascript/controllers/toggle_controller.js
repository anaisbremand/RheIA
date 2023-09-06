import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toggle"
export default class extends Controller {
  static targets = ["textarea", "modif", "regen"]

  connect() {
  }

  fireArea(event) {
    event.preventDefault();

    this.modifTarget.classList.toggle("d-none");
    this.regenTarget.classList.toggle("d-none");

    this.textareaTarget.classList.toggle("d-none");
  }

  cancelArea(event) {
    event.preventDefault();
    this.modifTarget.classList.toggle("d-none");
    this.regenTarget.classList.toggle("d-none");
    this.textareaTarget.classList.toggle("d-none");
  }

}
