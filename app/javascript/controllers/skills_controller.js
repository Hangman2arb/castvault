import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="skills"
export default class extends Controller {
  static targets = ["category", "skills"]

  connect(){
    this.updateSkillsOptions();
  }

  updateSkillsOptions() {
    const category = this.categoryTarget.value;
    const skillsSelect = this.skillsTarget;
    skillsSelect.innerHTML = '';

    if (category) {
      const options = this.getOptionsForCategory(category);
      options.forEach((skill) => {
        const option = new Option(skill, skill);
        skillsSelect.options.add(option);
      });
    }
  }

  getOptionsForCategory(category) {
    const allOptions = JSON.parse(document.getElementById('skills-data').getAttribute("data-skills-options"));
    return allOptions[category] || [];
  }

}
