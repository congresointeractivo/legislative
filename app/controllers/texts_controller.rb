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
    @title = t("texts.title") + " - "
    @pads
  end
  
  def show 
    @pad = get if params[:id]
    @pad_title = format(params[:id])
    @title = format(params[:id]) + " - "
  end

  def get
    get_pad params[:id]
  end

end
