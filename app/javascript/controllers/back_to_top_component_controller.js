import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  connect() {
    // Get the button
    const mybutton = document.getElementById("btn-back-to-top");

    // When the user scrolls down 20px from the top of the document, show the button
    const scrollFunction = () => {
      if (
          document.body.scrollTop > 20 ||
          document.documentElement.scrollTop > 20
      ) {
        mybutton.classList.remove("hidden");
      } else {
        mybutton.classList.add("hidden");
      }
    };

    // When the user clicks on the button, scroll to the top of the document
    mybutton.addEventListener("click", this.backToTop.bind(this));

    window.addEventListener("scroll", scrollFunction);
  }

  backToTop() {
    window.scrollTo({ top: 0, behavior: "smooth" });
  }
}
