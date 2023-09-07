import { Controller } from "@hotwired/stimulus"
import  Swal from "sweetalert2"

export default class extends Controller {
  static values = {
    icon: String,
    alertTitle: String,
    alertHtml: String,
    confirmButtonText: String,
    showCancelButton: Boolean,
    cancelButtonText: String
  }

  connect() {
    console.log("cucou")
  }

  fetchDeletePost(event) {
    const url = event.currentTarget.baseURI
    const csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content");
    fetch(url, {
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": csrfToken,
      },
      method: "DELETE"
    }).then(response => response.text())
    .then(data => console.log(data))
  }

  initSweetalert(event) {
    event.preventDefault(); // Prevent the form to be submited after the submit button has been clicked
    this.fetchDeletePost(event)
    Swal.fire({
      title: 'Etes-vous sûr de vouloir supprimer ce post?',
      icon: 'warning',
      showCancelButton: true,
      confirmButtonColor: '#e4c8e41',
      cancelButtonColor: '#bc78bc',
      confirmButtonText: 'Yes, supprimer!'
    }).then((result) => {
      if (result.isConfirmed) {
        Swal.fire(
          'Supprimé!',
          'Votre post a été supprimé.',
          'success'
        ).then(() => {
          window.location.href="/drafts"
        });
      }
    })
  }

}
