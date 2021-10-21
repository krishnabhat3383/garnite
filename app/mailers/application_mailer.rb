# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: "no-reply@garnite.com"
  layout "mailer"
end
