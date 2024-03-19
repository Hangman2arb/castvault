import { Controller } from "@hotwired/stimulus"
import Rails from "@rails/ujs"

// Connects to data-controller="profiles-form"
export default class extends Controller {
  static targets = ["modal", "overlay", "globalTabContent", "habilitiesTabContent",
                    "globalTab", "habilitiesTab", "profileModal", "profileOverlay"]

  open() {
    this.overlayTarget.classList.remove("hidden");
    // Usar setTimeout para asegurar que la clase se añade después de que el elemento se vuelve visible.
    setTimeout(() => {
      this.modalTarget.classList.remove("translate-x-full");
      this.modalTarget.classList.add("translate-x-0");
    }, 10);
  }

  close() {
    this.modalTarget.classList.remove("translate-x-0");
    this.modalTarget.classList.add("translate-x-full");

    // Esperar a que termine la transición antes de ocultar el overlay
    // La duración debe coincidir con la duración de la transición del panel (1000ms en este caso)
    setTimeout(() => {
      this.overlayTarget.classList.add("hidden");
    }, 1000);  // Asegúrate de que este tiempo coincida con la duración de la transición en tu CSS
  }


  closeProfileModal() {
    this.profileModalTarget.classList.add("hidden")
    this.profileOverlayTarget.classList.add("hidden")
  }

  switchToGlobal(event) {
    event.preventDefault()
    this.globalTabContentTarget.classList.remove("hidden")
    this.habilitiesTabContentTarget.classList.add("hidden")
    this.globalTabTarget.classList.add("bg-gray-200")
    this.globalTabTarget.classList.remove("text-gray-200")
    this.habilitiesTabTarget.classList.remove("bg-gray-200")
    this.habilitiesTabTarget.classList.remove("text-gray-800")
    this.habilitiesTabTarget.classList.add("text-gray-200")
  }

  switchToHabilities(event) {
    event.preventDefault()
    this.globalTabContentTarget.classList.add("hidden")
    this.habilitiesTabContentTarget.classList.remove("hidden")
    this.habilitiesTabTarget.classList.add("bg-gray-200")
    this.habilitiesTabTarget.classList.remove("text-gray-200")
    this.globalTabTarget.classList.remove("bg-gray-200")
    this.globalTabTarget.classList.remove("text-gray-800")
    this.globalTabTarget.classList.add("text-gray-200")
  }

  openModal(event) {
    event.preventDefault();
    // const profileId = event.currentTarget.getAttribute('data-profile-id');
    // const url = `/manager/profiles/modal?id=${profileId}`;
    // Rails.ajax({
    //   url: url,
    //   type: 'GET',
    //   dataType: 'html',
    //   success: (data) => {
    //     console.log(data);
    //     //this.modalTarget.innerHTML = data
    //   }
    // })

  }
}