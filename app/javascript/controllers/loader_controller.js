import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="loader"
export default class extends Controller {
  static targets = ["togglableElement", "chargement", "breadcrumb"]

  connect() {
    console.log("je suis connecté")
  }

  fire() {
    this.togglableElementTarget.classList.toggle("d-none");
    this.chargementTarget.classList.toggle("d-none");
    this.breadcrumbTarget.classList.toggle("d-none");
  }
}
