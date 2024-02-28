class Stripe::BillingPortalController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]
  def create
    session = Stripe::BillingPortal::Session.create({
                                                      customer: current_user.stripe_customer_id,
                                                      return_url: manager_settings_url
                                                    })
    redirect_to session.url, allow_other_host: true
  end
end