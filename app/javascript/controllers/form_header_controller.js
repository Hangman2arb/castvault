import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="form-header"
export default class extends Controller {
  static targets = ["image"]

  connect() {
    this.resizeImage()
  }

  resizeImage() {
    const image = this.imageTarget;
    if (image.offsetWidth > window.innerWidth / 2) {
      image.classList.add('w-full');
      image.classList.add('md:w-1/2');
    } else {
      image.classList.remove('w-full');
      image.classList.remove('md:w-1/2');
    }
  }

  disconnect() {
    window.removeEventListener('resize', () => this.resizeImage());
  }
}