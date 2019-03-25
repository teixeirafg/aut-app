module Comercio
  def home
    Comercio::Home::Home.new
  end

  def registration
    Comercio::Register::Register.new
  end

  def account
    Comercio::Account::Account.new
  end


  def search
    Comercio::Search::Search.new
  end

  def product_details
    Comercio::ProductDetails::ProductDetails.new
  end

  def cart
    Comercio::Cart::Cart.new
  end

  def login
    Comercio::Login::Login.new
  end

  def address
    Comercio::Address::Address.new
  end

  def payment
    Comercio::Payment::Payment.new
  end

  def payment_credit_card
    Comercio::PaymentCreditCard::PaymentCreditCard.new
  end

  def payment_two_credit_cards
    Comercio::PaymentTwoCreditCards::PaymentTwoCreditCards.new
  end



  def payment_boleto
    Comercio::PaymentBoleto::PaymentBoleto.new
  end

  def confirmation_payment
    Comercio::ConfirmationPayment::ConfirmationPayment.new
  end

  def my_orders
    Comercio::MyOrders::MyOrders.new
  end

  def extended_warranty
    Comercio::ExtendedWarranty::ExtendedWarranty.new
  end
end
