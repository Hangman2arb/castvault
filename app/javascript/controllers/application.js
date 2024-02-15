import { Application } from "@hotwired/stimulus"
import Clipboard from "stimulus-clipboard"
import Notification from 'stimulus-notification'
import PasswordVisibility from 'stimulus-password-visibility'
import Dropdown from 'stimulus-dropdown'
import NestedForm from 'stimulus-rails-nested-form'
import TextareaAutogrow from 'stimulus-textarea-autogrow'
import Autosave from 'stimulus-rails-autosave'

const application = Application.start()

application.register('clipboard', Clipboard)
application.register('notification', Notification)
application.register('password-visibility', PasswordVisibility)
application.register('dropdown', Dropdown)
application.register('nested-form', NestedForm)
application.register('textarea-autogrow', TextareaAutogrow)
application.register('autosave', Autosave)
// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }
