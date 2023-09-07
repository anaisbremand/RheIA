import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="show-imgs"
export default class extends Controller {
  static targets = ["image"];

  connect() {
    this.loadImages();
  }

  loadImages() {
    console.log("loadImages called");
    this.imageTargets.forEach((imageElement) => {
      let img = new Image();
      console.log("Setting image src to ", imageElement.dataset.src); // Pour le debug
      img.src = imageElement.dataset.src; // On utilise dataset pour récupérer l'URL de l'image

      img.addEventListener("load", () => {
        console.log("Image loaded");
        imageElement.src = img.src;
        imageElement.classList.remove("img-loading"); // Retirer la classe CSS "loading"
      });

      imageElement.classList.add("img-loading"); // Ajouter une classe CSS "loading" pour l'animation
    });
  }
}
