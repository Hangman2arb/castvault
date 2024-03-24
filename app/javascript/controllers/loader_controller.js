import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="loader"
export default class extends Controller {
  connect() {
    // Escuchar el evento de envío del formulario
    this.element.addEventListener('submit', (event) => {
      // Mostrar el loader solo si el envío no es por turbo (Turbo tomará el control de mostrar el loader)
      if (!this.usesTurbo(event.target)) {
        this.showLoader();
      }
    });

    // Escuchar los eventos específicos de Turbo para formularios
    document.addEventListener('turbo:submit-start', () => this.showLoader());
    document.addEventListener('turbo:submit-end', () => this.hideLoader());
  }

  usesTurbo(formElement) {
    return formElement.hasAttribute('data-turbo') && formElement.getAttribute('data-turbo') !== 'false';
  }

  showLoader() {
    const loader = document.getElementById('loader-overlay');
    if (loader) {
      loader.classList.remove('hidden');
    }
  }

  hideLoader() {
    const loader = document.getElementById('loader-overlay');
    if (loader) {
      loader.classList.add('hidden');
    }
  }
}
