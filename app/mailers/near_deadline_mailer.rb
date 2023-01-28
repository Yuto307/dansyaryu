class NearDeadlineMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.reset_password_email.subject
  #
  default from: 'from@example.com'
  def near_deadline(user)
    @user = User.find(user.id)
    mail(to: user.email,
         subject: t('defaults.password_reset'))
  end
end
