import { Controller } from "@hotwired/stimulus";
import flatpickr from "flatpickr";


export default class extends Controller {

  connect() {

    console.log("connecté!");
    console.log(this.element.tagName);
    flatpickr(this.element, {
      enableTime: true,
      locale: "fr",

    });
  }
}
