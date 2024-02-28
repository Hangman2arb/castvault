import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="form-show"
export default class extends Controller {

  connect() {
    const agencyCheckbox = document.getElementById('profile_agency');

    if (agencyCheckbox) {
      agencyCheckbox.addEventListener('change', () => {
        this.toggleElements();
      });

      this.toggleElements();
    }
  }

  toggleAgency(event) {
    this.toggleElements();
  }

  toggleElements() {
    const agencyChecked = this.element.querySelector("#profile_agency").checked;
    const elementsToToggle = [
      "label_profile_agent_name", "profile_agent_name",
      "label_profile_agent_email", "profile_agent_email",
      "label_profile_agent_phone", "profile_agent_phone"
    ];

    elementsToToggle.forEach(id => {
      const element = document.getElementById(id);
      if (element) {
        if (agencyChecked) {
          element.classList.remove("hidden");
        } else {
          element.classList.add("hidden");
        }
      }
    });

    const slimSelectContainer = document.querySelector("[class='ss-main']");
    if (slimSelectContainer) {
      if (agencyChecked) {
        slimSelectContainer.style.display = "";
      } else {
        slimSelectContainer.style.display = "none";
      }
    }
  }
}