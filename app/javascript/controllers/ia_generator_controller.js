import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="ia-generator"
export default class extends Controller {

static targets = ["prompt"]
  connect() {
    console.log("coucou")
    console.log(this.promptTarget)
  }

  generate(){
    console.log("salut")
  }
}
