# test/mailers/previews/devise_mailer_preview.rb
class DeviseMailerPreview < ActionMailer::Preview
  def confirmation_instructions
    user = User.first
    token = user.confirmation_token || 'some_token'
    CustomDeviseMailer.confirmation_instructions(user, token)
  end

  def reset_password_instructions
    user = User.first
    token = user.confirmation_token || 'some_token'
    CustomDeviseMailer.reset_password_instructions(user, token)
  end

  def email_changed
    user = User.first
    CustomDeviseMailer.email_changed(user)
  end

  # def unlock_instructions
  #   user = User.first
  #   token = user.unlock_token || 'some_token'
  #   CustomDeviseMailer.unlock_instructions(user, token)
  # end

  def password_change
    user = User.first
    CustomDeviseMailer.password_change(user)
  end

  def invitation_instructions
    user = User.first
    token = user.confirmation_token || 'some_token'
    CustomDeviseMailer.invitation_instructions(user, token)
  end

end
