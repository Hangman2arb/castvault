import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="glightbox"
export default class extends Controller {
  connect() {
    this.glightbox = GLightbox({
      selector: '.glightbox'
    });
  }

  disconnect() {
    if (this.glightbox) {
      this.glightbox.destroy();
    }
  }
}