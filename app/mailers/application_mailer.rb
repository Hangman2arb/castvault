class ApplicationMailer < ActionMailer::Base
  default from: "no-reply@castvault.com"
  layout 'mailer'
end
