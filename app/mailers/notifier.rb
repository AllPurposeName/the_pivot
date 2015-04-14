class Notifier < ApplicationMailer

  def purchase_notification(user)
    @user = user
    @url = "handmeups.herokuapp.com/login"
    mail(to: @user.email, subject: 'Congrats on your newest Order!')
  end

  def item_sold_notification(seller, user)
    @seller = seller
    @user = user
    @url = "handmeups.herokuapp.com/login"
    mail(to: @seller.user.email, subject: 'Congrats on your newest sale!')
  end
end
