import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="upload-file-component"
export default class extends Controller {
  static targets = ['input', 'image', 'preview', 'imageUploadArea', 'removePhoto', 'checkbox'];

  connect() {
    const imageUrl = this.element.dataset.imageUrl;
    if (imageUrl) {
      this.imageTarget.src = imageUrl;
      this.previewTarget.classList.remove('hidden');
      this.imageUploadAreaTarget.classList.add('hidden');
    }
  }

  preview() {
    let input = this.inputTarget;
    let fileSize = input.files[0].size / 1024 / 1024;
    let maxFileSize = parseFloat(input.dataset.maxSize);

    if (fileSize > maxFileSize) {
      alert(`File size should not exceed ${maxFileSize}MB.`);
      input.value = '';
      return;
    }

    if (input.files && input.files[0]) {
      let reader = new FileReader();

      reader.onload = (e) => {
        if (!this.hasImageTarget) {
          const img = document.createElement('img');
          img.classList.add('object-cover', 'w-full', 'h-full', 'rounded-lg', 'border', 'border-dashed');
          img.setAttribute('data-upload-file-component-target', 'image');
          this.previewTarget.appendChild(img);
        }

        this.imageTarget.src = e.target.result;
        this.previewTarget.classList.remove('hidden');
        this.imageUploadAreaTarget.classList.add('hidden');

        this.unmarkCheckbox();
      }

      reader.readAsDataURL(input.files[0]);
    }
  }

  removePhoto(event) {
    event.preventDefault();
    this.inputTarget.value = '';
    this.imageTarget.src = '';

    this.previewTarget.classList.add('hidden');
    this.imageUploadAreaTarget.classList.remove('hidden');

    this.markCheckbox();
  }

  markCheckbox() {
    if (this.hasCheckboxTarget) {
      this.checkboxTarget.checked = true;
    }
  }

  unmarkCheckbox() {
    if (this.hasCheckboxTarget) {
      this.checkboxTarget.checked = false;
    }
  }

  dragover(event) {
    event.preventDefault();
    event.currentTarget.classList.add('bg-indigo-100');
  }

  dragleave(event) {
    event.currentTarget.classList.remove('bg-indigo-100');
  }


  drop(event) {
    event.preventDefault();
    event.currentTarget.classList.remove('bg-indigo-100');

    let droppedFiles = event.dataTransfer.files;

    if (droppedFiles.length > 0) {
      this.inputTarget.files = droppedFiles;
      this.preview();
    }
  }
}
