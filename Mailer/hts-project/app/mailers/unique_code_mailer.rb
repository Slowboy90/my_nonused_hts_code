class UniqueCodeMailer < ActionMailer::Base
  default from: "no_reply@100jaarhts.nl"
  # layout 'mailer'


  def code_email(person)
  	@person = person
  	@url = 'http://www.100jaarhts.nl/users/sign_up'
  	@unique_code_url = 'http://www.100jaarhts.nl/klassenfoto/#{@person.unique_code}'
  	mail(to: @person.email, subject: 'Uw unieke code')
  end
  
end

