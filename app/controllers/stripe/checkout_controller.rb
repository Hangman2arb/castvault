class Stripe::CheckoutController < ApplicationController

  before_action :authenticate_user!

  def pricing
    lookup_keys = %w[basic_monthly basic_yearly pro_monthly pro_yearly elite_monthly elite_yearly]
    @prices = Stripe::Price.list(lookup_keys: lookup_keys, active: true, expand: ['data.product']).data.sort_by(&:unit_amount)
  end

  def checkout
    session = Stripe::Checkout::Session.create({
                                                 customer: current_user.stripe_customer_id,
                                                 mode: 'subscription',
                                                 line_items: [{
                                                                quantity: 1,
                                                                price: params[:id]
                                                              }],
                                                 success_url: success_stripe_checkout_url,
                                                 cancel_url: cancel_stripe_checkout_url,
                                               })
    redirect_to session.url, allow_other_host: true
  end

  def success
    flash[:notice] = "success"
    redirect_to manager_root_path
  end

  def cancel
    flash[:alert] = "failure"
    redirect_to manager_root_path
  end
end
