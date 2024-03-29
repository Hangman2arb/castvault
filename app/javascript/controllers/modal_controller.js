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

    this.containerTarget.innerHTML = "";
  }


  close(event) {
    event.preventDefault();
    this.element.style.display = 'none';
  }

  stopPropagation(event) {
    event.stopPropagation();
  }

}
