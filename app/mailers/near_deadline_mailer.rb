class NearDeadlineMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.reset_password_email.subject
  #
  default from: 'from@example.com'
  def near_deadline(post)
    @post = post
    mail(to: post.user.email,
         subject: '本日締め切りになる投稿があります')
  end
end
