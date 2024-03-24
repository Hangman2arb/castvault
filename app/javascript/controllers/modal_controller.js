import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="modal"
export default class extends Controller {
  static targets = ["overlay", "container"]

  connect() {
    console.log("Modal controller connected");
  }

  closeModal() {
    this.overlayTarget.classList.add("hidden");
    this.containerTarget.classList.add("hidden");

    // Opcionalmente, podrías querer eliminar el contenido del modal
    // para asegurarte de que no se muestren datos antiguos si se vuelve a abrir.
    this.containerTarget.innerHTML = "";
  }

  stopPropagation(event) {
    event.stopPropagation();
  }

}
