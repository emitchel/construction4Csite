class ApplicationMailer < ActionMailer::Base
  default from: 'leads@4cconstruction.com'
  SEND_TO_EMAIL = 'elliot.r.mitchell@gmail.com'.freeze
  layout 'mailer'

  def lead_email(lead)
    @lead = lead
    mail(to: SEND_TO_EMAIL, subject: 'A new lead from website')
  end
end
