class FeedbackController < ApplicationController
  include Roar::Rails::ControllerAdditions
  caches_page :index

  # GET /feedback
  def create
    @feedback = params[:feedback_message] 
    @feedback = @feedback + " \n <br/> \n " + request.env["HTTP_REFERER"]
    @feedback = @feedback + " \n <br/> \n " + request.env["REMOTE_ADDR"]
    FeedbackMailer.feedback_email(@feedback).deliver
  end
end
