class AuthorMailer < ApplicationMailer
  default from: 'projekt@rails.pl'

  def welcome_author(author)
    @author = author
    mail(to: @author.email, subject: 'Witaj na naszej stronie')
  end

  def notify_author(author)
    @author = author
    mail(to: @author.email, subject: 'Dokonano zmian na twoim koncie')
  end
end
