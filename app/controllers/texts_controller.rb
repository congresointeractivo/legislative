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
    @pads = get_list
    @pads
  end
  
  def show 
    index
    render "index"
  end

end
