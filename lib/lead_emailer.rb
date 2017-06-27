module LeadEmailer
  require 'sendgrid-ruby'
  include SendGrid

  LEAD_EMAIL_FROM = '4C_leads@4cconstruction.com'.freeze
  LEAD_EMAIL_TO = 'elliot.r.mitchell@gmail.com'.freeze

  def self.email_lead(lead)
    begin
      from = Email.new(email: LEAD_EMAIL_FROM)
      to = Email.new(email: LEAD_EMAIL_TO)
      subject = 'New 4C Lead'
      content = Content.new(type: 'html', value: LeadEmailer.value_from_lead(lead))
      mail = Mail.new(from, subject, to, content)
      sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
      response = sg.client.mail._('send').post(request_body: mail.to_json)
      puts response.status_code
      puts response.body
      puts response.headers
      true
    rescue Exception => e
      puts 'ERROR: ' + e.message
      false
    end
  end

  def self.value_from_lead(lead)
    value = 'New Lead for 4C Construction <br>'
    value += "Name: #{lead.name} <br>"
    value += "Email: #{lead.email} <br>"
    value += "How they found out about us: #{lead.source} <br>"
    value += "Message: #{lead.message} <br>"
    value + "Lead created at: #{lead.created_at} <br>"
  end

end