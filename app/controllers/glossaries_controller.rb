require 'json'
require 'net/http'
require 'redcarpet'
require 'etherpad-lite'
require 'pry'
require 'nokogiri'
require 'open-uri'



class GlossariesController < ApplicationController
  include GlossariesHelper 
  caches_page :index
  # GET /glossaries
  def index
    @padurl = "http://pad.congresointeractivo.org/"
    @apikey = "2064063a3291c4a32b47e9c636649dea83d918ff6a9a87467393d5bcb2bb7be8"

    @pads = get_list
    
    @pads
  end
  
  def show 
    index
    render "index"
  end

end
