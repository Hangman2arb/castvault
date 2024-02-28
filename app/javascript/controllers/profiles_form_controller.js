import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="profiles-form"
export default class extends Controller {
  static targets = ["modal", "overlay", "globalTabContent", "habilitiesTabContent", "globalTab", "habilitiesTab"]

  open() {
    this.modalTarget.classList.remove("hidden")
    this.overlayTarget.classList.remove("hidden")
  }

  close() {
    this.modalTarget.classList.add("hidden")
    this.overlayTarget.classList.add("hidden")
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
}