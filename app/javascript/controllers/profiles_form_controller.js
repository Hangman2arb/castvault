import { Controller } from "@hotwired/stimulus"
import Rails from "@rails/ujs"

// Connects to data-controller="profiles-form"
export default class extends Controller {
  static targets = ["modal", "overlay", "globalTabContent", "habilitiesTabContent",
                    "globalTab", "habilitiesTab", "profileModal", "profileOverlay"]

  open() {
    this.modalTarget.classList.remove("hidden")
    this.overlayTarget.classList.remove("hidden")
  }

  close() {
    this.modalTarget.classList.add("hidden")
    this.overlayTarget.classList.add("hidden")
  }

  close() {
    this.profileModalTarget.classList.add("hidden")
    this.profileOverlayTarget.classList.add("hidden")
  }

  switchToGlobal(event) {
    event.preventDefault()
    this.globalTabContentTarget.classList.remove("hidden")
    this.habilitiesTabContentTarget.classList.add("hidden")
    this.globalTabTarget.classList.add("text-indigo-400")
    this.habilitiesTabTarget.classList.remove("text-indigo-400")
  }

  switchToHabilities(event) {
    event.preventDefault()
    this.globalTabContentTarget.classList.add("hidden")
    this.habilitiesTabContentTarget.classList.remove("hidden")
    this.habilitiesTabTarget.classList.add("text-indigo-400")
    this.globalTabTarget.classList.remove("text-indigo-400")
  }

  openModal(event) {
    event.preventDefault();
    const profileId = event.currentTarget.getAttribute('data-profile-id');
    const url = `/manager/profiles/modal?id=${profileId}`;
    console.log('sae');
    Rails.ajax({
      url: url,
      type: 'GET',
      dataType: 'html',
      success: (data) => {
        this.modalTarget.innerHTML = data
        // Aquí podrías abrir el modal, por ejemplo, cambiando su clase CSS o usando una librería de modales
      }
    })

  }
}