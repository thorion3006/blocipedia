class ChargesController < ApplicationController

  def create
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
    @stripe_btn_data = {
      key: "#{ Rails.configuration.stripe[:publishable_key] }",
      description: "Blocipedia Membership - #{current_user.name}",
      amount: ChargesHelper::Amount.default
    }
  end

  def change
    if current_user.role == 'standard'
      current_user.role = 'premium'
    elsif current_user.role == 'premium'
      current_user.role = 'standard'
    end
    current_user.save
    redirect_to user_path(current_user)
  end
end
