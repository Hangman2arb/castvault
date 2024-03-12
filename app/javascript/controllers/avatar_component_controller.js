import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  showModal(event) {
    const imgUrl = event.currentTarget.src;

    const modalHtml = `
      <div class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50" data-controller="avatar-component" data-action="click->avatar-component#closeModal">
        <div class="bg-white rounded-lg p-5 relative max-h-screen overflow-y-auto" data-action="click->avatar-component#preventClose">
          <img src="${imgUrl}" alt="Zoomed Image" class="w-full h-auto max-h-[90vh] object-contain">
          <i class="bi bi-x absolute z-10 top-0 right-0 text-xl cursor-pointer" data-action="click->avatar-component#closeModalAndStopPropagation"></i>
        </div>
      </div>
    `;

    const modalFrame = document.getElementById('modal');
    modalFrame.innerHTML = modalHtml;
  }

  closeModal() {
    const modalFrame = document.getElementById('modal');
    modalFrame.innerHTML = '';
  }

  // Esto evita que el modal se cierre al hacer clic en el contenido principal.
  preventClose(event) {
    event.stopPropagation();
  }

  closeModalAndStopPropagation(event) {
    this.closeModal();
    event.stopPropagation();
  }
}
