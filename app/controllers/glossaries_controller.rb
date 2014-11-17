require 'json'
require 'net/http'
require 'redcarpet'

class GlossariesController < ApplicationController
  caches_page :index
  # GET /glossaries
  def index
  	@padurl = "http://pad.congresointeractivo.org/";
  	@apikey = "2064063a3291c4a32b47e9c636649dea83d918ff6a9a87467393d5bcb2bb7be8";

  	if !params["id"] 
  		raise "A text id must be provided."
  	end

    @padtext = getpad params["id"] 
    @title = ActionView::Base.full_sanitizer.sanitize(@padtext.split("<br>")[0]);
  end
  
  def show 
  	index
  	render "index"
  end

  def getpad padid
  	@padediturl = @padurl + "p/"+padid;
  	padrequesturl = @padurl + "api/1/getHTML?apikey=" + @apikey + "&padID=" + padid;

   	padresp = Net::HTTP.get_response(URI.parse(padrequesturl));
  	result = JSON.parse(padresp.body);
  	if result.has_key? 'Error'
      raise "error getting pad contents";
   	end
  	if result["code"] != 0
      raise "error getting pad contents JSON: " + result["message"];
   	end

    text = result["data"]["html"].gsub("<!DOCTYPE HTML><html><body>","");
    p text;
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, tables: true);
    markdown.render(text);
  end

  def getlist
  	listrequesturl = @padurl + "/api/1/listPads?apikey=" + @apikey + "&groupID=0";

   	listresp = Net::HTTP.get_response(URI.parse(listrequesturl));
  	result = JSON.parse(listresp.body);
  	if result.has_key? 'Error'
      raise "error getting pad list";
   	end
  	if result["code"] != 0
      raise "error getting pad list JSON: " + result["message"];
   	end

    text = result["data"]["text"];

  	p text
  end
end
