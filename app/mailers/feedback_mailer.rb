class FeedbackMailer < ActionMailer::Base
  default from: "legislative@congresointeractivo.org"

  def feedback_email(feedback)
  	@message = feedback
    mail(to: "martin@congresointeractivo.org", subject: "Feedback en congresointeractivo")
  end

end
