require 'billit_representers_argentina/models/bill_page'

class MainsController < ApplicationController
  caches_page :index, :sitemap

  # GET /mains
  def index
    @low_chamber_agenda = Array.new
    @high_chamber_agenda = Array.new
    @new_bill_count = get_new_bill_count;
    # @new_laws_count = get_new_laws_count;
  
    if !ENV['component_legislative_agendas'].blank? and !ENV['agendas_url'].blank? and !ENV['billit_url'].blank?
	    @low_chamber_agenda[0] = get_current_chamber_agenda ENV['low_chamber_name']
      if ! @low_chamber_agenda[0]['bill_list'].blank?
        @low_chamber_agenda[1] = get_bills_per_agenda JSON.parse(@low_chamber_agenda[0]['bill_list']).uniq
      end

	    @high_chamber_agenda[0] = get_current_chamber_agenda ENV['high_chamber_name']
      if ! @high_chamber_agenda[0]['bill_list'].blank?
        @high_chamber_agenda[1] = get_bills_per_agenda JSON.parse(@high_chamber_agenda[0]['bill_list']).uniq
      end
    end

    @hot_bills = {};

    if !ENV['billit_url'].blank?
      #@hot_bills = prioritize Billit::BillPage.get(ENV['billit_url'] + URI::escape("search?current_priority=Discusión inmediata|Suma|Simple&per_page=100"), 'application/json').bills
    end

    if (!ENV['writeit_base_url'].blank?)
	    @answers = LegislativeAnswerCollection.get()

	    if @answers.objects.length > 2
	      @answers.objects = @answers.objects[0..1]
	    end
    end
  end

  # GET last chamber agenda
  def get_current_chamber_agenda chamber
    query = sprintf("select * from data where chamber = '%s' order by date DESC limit 1", chamber)
    query = URI::escape(query)

    begin
      response = RestClient.get(ENV['agendas_url'] + query, :content_type => :json, :accept => :json, :"x-api-key" => ENV['morph_io_api_key'])
      response = JSON.parse(response).first
    rescue => e
      response = Hash.new
    end
  end

  def get_new_bill_count
    bills = Billit::BillPage.new;
    processing_date = Date.today();
    # begin
      while (!bills.total_entries or bills.total_entries == 0) do
        processing_date = processing_date.prev_month(1);
        @date_bills = processing_date.strftime("%d-%m-%Y");
        bills = Billit::BillPage.get(ENV['billit_url'] + "search/?creation_date_min=#{@date_bills}", 'application/json')
      end
      @last_update = Date.parse(bills.bills.last.creation_date).strftime("%d-%m-%Y");
      return bills.total_entries
    # rescue => e
    #   "-"
    # end
  end

  def get_new_laws_count
    begin
      laws = Billit::BillPage.get(ENV['billit_url'] + "search/?creation_date_min=#{@date_bills}&project_type=LEY", 'application/json')
      laws.total_entries;
    rescue => e
      "0"
    end
  end


  # GET the bills per agenda
  def get_bills_per_agenda bills_id
    @keywords = String.new
    bills_id.each do |bill_id|
      @keywords << bill_id + '|'
    end
    @keywords = URI::escape(@keywords)

    begin
      bills = Billit::BillPage.get(ENV['billit_url'] + "search/?uid=#{@keywords}", 'application/json')
    rescue => e
      bills = Hash.new
    end
  end

  def sitemap
    @congressmen = PopitPersonCollection.new
    @congressmen.get ENV['popit_persons']+'?per_page=200', 'application/json'
    @congressmen.persons.sort! { |x,y| x.name <=> y.name }
  end

  def prioritize bills
    priorities = {"Discusión inmediata" => 1, "Suma" => 2, "Simple" => 3}
    prioritized_bills = bills.sort {|x,y| priorities[x.current_priority] <=> priorities[y.current_priority]}
    prioritized_bills[0..7]
  end
end
