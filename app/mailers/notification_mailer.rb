class NotificationMailer < ApplicationMailer
  default from: "projekt@rails.pl"

  def notify(email, post)
    @post = post
    mail(to: email, subject: "Powiadomienie")
  end
end