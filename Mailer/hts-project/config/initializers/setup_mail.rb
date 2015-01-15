ActionMailer::Base.smtp_settings = {
  :address              => "localhost",
  :port                 => 25,
  :domain               => "100jaarhts.nl",
  :enable_starttls_auto => false
}