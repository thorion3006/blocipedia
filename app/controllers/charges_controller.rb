class ChargesController < ApplicationController
  include ApplicationHelper

  skip_before_action :authenticate_user!

  def create
    current_user ||= @@temp_user
    customer = Stripe::Customer.create(
      email: current_user.email,
      card: params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      customer: customer.id,
      amount: ChargesHelper::Amount.default,
      description: "Blocipedia Membership - #{current_user.email}",
      currency: 'usd'
    )

    flash[:notice] = "Thanks for all the money, #{current_user.email}! Feel free to pay me again."
    change

  rescue Stripe::CardError => e
    flash[:alert] = e.message
    render new_charge_path
  end

  def new
    @@temp_user = User.find_by email: @@temp_email
    current_user ||= @@temp_user
    @stripe_btn_data = {
      key: "#{ Rails.configuration.stripe[:publishable_key] }",
      description: "Blocipedia Membership - #{current_user.name}",
      amount: ChargesHelper::Amount.default
    }
  end

  def change
    current_user ||= @@temp_user
    if current_user.account_active
      if current_user.role == 'standard'
        current_user.role = 'premium'
      elsif current_user.role == 'premium'
        current_user.role = 'standard'
      end
      current_user.save
      redirect_to user_path(current_user)
    else
      current_user.account_active = true
      current_user.save
      redirect_to root_path
    end
  end
end
