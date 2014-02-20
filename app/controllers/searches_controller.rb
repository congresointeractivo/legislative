require 'net/http'
require 'httparty'
require 'popit_representers/models/organization_collection'

class SearchesController < ApplicationController
  def index

    @parliamentarians = PopitPersonCollection.new

    @organizations = Popit::OrganizationCollection.new
    @organizations.get ENV['popit_organizations'], 'application/json'

    if !params.nil? && params.length > 3 # default have 3 keys {'action'=>'index', 'controller'=>'searchs', "locale"=>"xx"}
      
      # make a redirect in case of someone pick just one filter in main page
      # redirect to bills advanced search
      if params[:bills] == '1' || params[:parliamentarians] == ''
        redirect_to searches_bills_path(params)
      end
      # redirect to parliamentarians advanced search
      if params[:parliamentarians] == '2' || params[:bills] == ''
        redirect_to searches_parliamentarians_path(params)
      end

      @keywords = String.new
      params.each do |param|
        if param[0] != 'utf8' && param[0] != 'commit' && param[0] != 'format' && param[0] != 'locale' && param[0] != 'action'  && param[0] != 'controller'
         @keywords << param[0] + '=' + param[1] + '&'
        end
      end

      @bills_query = BillCollectionPage.get(ENV['billit_url'] + "search.json/?#{URI.encode(@keywords)}&per_page=3", 'application/json')
      @parliamentarians.get ENV['popit_search'] + "#{URI.encode(@keywords)}per_page=3", 'application/json'
    else
      @bills_query = BillCollectionPage.get(ENV['billit_url'] + "search.json/?per_page=3", 'application/json')
      @parliamentarians.get ENV['popit_search'] + "per_page=3", 'application/json'
    end
    
    
  end
end
