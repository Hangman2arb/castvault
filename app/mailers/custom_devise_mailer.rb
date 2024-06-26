class CustomDeviseMailer < Devise::Mailer
  layout 'mailer'

  def confirmation_instructions(record, token, opts={})
    super
  end

  def email_changed(record, opts = {})
    super
  end

  def reset_password_instructions(record, token, opts = {})
    super
  end

  def unlock_instructions(record, token, opts = {})
    super
  end

  def password_change(record, opts = {})
    super
  end

  def invitation_instructions(record, token, opts = {})
    @name = record.first_name
    super
  end
end
