require 'json'
require 'net/http'
require 'redcarpet'
require 'etherpad-lite'
require 'pry'
require 'nokogiri'
require 'open-uri'



class TextsController < ApplicationController
  include TextsHelper
  caches_page :index
  # GET /glossaries
  def index

    @pads = get_list unless params[:id]
    @pads
  end
  
  def show 
    @pad = get if params[:id]
    index unless params[:id]
    render "index"
  end

  def get
    get_pad params[:id]
  end

end
