class FeedbackController < ApplicationController
  include Roar::Rails::ControllerAdditions
  caches_page :index

  # GET /feedback
  def create
    @feedback = params[:feedback_message] 
    @feedback = @feedback + " \n Referer: " + request.env["HTTP_REFERER"]
    @feedback = @feedback + " \n IP: " + request.env["REMOTE_ADDR"]
    @feedback = @feedback + " \n Date: " + Time.now.to_s

    FeedbackMailer.feedback_email(@feedback).deliver
  end
#  alias index
end
