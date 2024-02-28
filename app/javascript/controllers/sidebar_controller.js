import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["backdrop", "mobileMenu", "mobileMenuContainer", "mobileMenuButtonClose"]

  showMobileMenu() {
    this.mobileMenuContainerTarget.classList.remove("hidden");
    this.backdropTarget.classList.remove("hidden");

    requestAnimationFrame(() => {
      this.backdropTarget.classList.replace("opacity-0", "opacity-100");
      this.mobileMenuTarget.classList.replace("-translate-x-full", "translate-x-0");
      this.mobileMenuButtonCloseTarget.classList.replace("opacity-0", "opacity-100");
    });
  }

  hideMobileMenu() {
    this.backdropTarget.classList.replace("opacity-100", "opacity-0");
    this.mobileMenuTarget.classList.replace("translate-x-0", "-translate-x-full");
    this.mobileMenuButtonCloseTarget.classList.replace("opacity-100", "opacity-0");

    setTimeout(() => {
      this.mobileMenuContainerTarget.classList.add("hidden");
      this.backdropTarget.classList.add("hidden");
    }, 300);
  }


}
