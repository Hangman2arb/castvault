import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="image-preview"
export default class extends Controller {
  static targets = ["source", "preview"]

  connect() {
    console.log("Image preview controller connected");
  }

  updatePreview() {
    const input = this.sourceTarget;
    const file = input.files[0];
    if (file) {
      const reader = new FileReader();
      reader.onload = (e) => this.previewTarget.src = e.target.result;
      reader.readAsDataURL(file);
    }
  }

  triggerUpload() {
    this.sourceTarget.click();
  }
}