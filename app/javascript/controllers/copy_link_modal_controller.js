import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="copy-link-modal"
export default class extends Controller {
  showModal(event) {
    event.preventDefault();

    const locale = document.body.getAttribute('data-locale');
    const linkToCopy = event.currentTarget.getAttribute('href');
    const fullLink = `${window.location.origin}/forms/${linkToCopy}`;

    Swal.fire({
      title: I18n.t[locale]['js']['copy_link_modal']['title'],
      icon: "info",
      html: I18n.t[locale]['js']['copy_link_modal']['html'].replace('{link}', fullLink),
      showCloseButton: true,
      focusConfirm: false,
      confirmButtonText: I18n.t[locale]['js']['copy_link_modal']['confirm_button_text'],
      confirmButtonAriaLabel: I18n.t[locale]['js']['copy_link_modal']['confirm_button_aria_label'],
    }).then((result) => {
      if (result.isConfirmed) {
        navigator.clipboard.writeText(fullLink).then(() => {
          Swal.fire({
            title: I18n.t[locale]['js']['copy_link_modal']['copied_title'],
            text: I18n.t[locale]['js']['copy_link_modal']['copied_message'],
            icon: 'success',
            timer: 1500, // Cierra la alerta después de 3000ms (3 segundos)
            showConfirmButton: false, // No muestra el botón de confirmación
          });
        }).catch(err => {
          console.error(I18n.t[locale]['js']['copy_link_modal']['error_message'], err);
        });
      }
    });
  }
}
