class FeedbackController < ApplicationController
  include Roar::Rails::ControllerAdditions
  caches_page :index

  # GET /feedback
  def create
    if (is_spam(params[:feedback_message]))
      @feedback = "ERROR";
      return false;
    end

    if (params[:feedback_message] != "")

      @feedback = params[:feedback_message] 
      @feedback = @feedback + " \n Referer: " + request.env["HTTP_REFERER"]
      @feedback = @feedback + " \n IP: " + request.env["REMOTE_ADDR"]
      @feedback = @feedback + " \n Date: " + Time.now.to_s

      sent = FeedbackMailer.feedback_email(@feedback).deliver
    end
    if (!sent)
      @feedback = "ERROR";
    end
  end
#  alias index
  def is_spam(text)
    spam = false
    if text.include?("[url") 
      spam = true;
    end

    return spam;
  end
end
