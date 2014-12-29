module TextsHelper

  def get_pad padid = nil
    @pad = { id: params[:id] } 
    
    ether = EtherpadLite.connect ENV['pad_url'], ENV['pad_apikey'], '1.2.1'
    pad = ether.pad @pad[:id]
    
    @pad[:edit_url] = "#{ENV['pad_url']}p/#{@pad[:id]}"

    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, tables: true)

    @pad[:text] = markdown.render(pad.text)
    
    @pad
  end
	
  def get_list
   page = Nokogiri::HTML open "#{ENV['pad_url']}list"
   links = page.css "a"

   ether = EtherpadLite.connect ENV['pad_url'], ENV['pad_apikey'], '1.2.1'
   pad_text = ""
   pads = []
   links.sort_by { |f| f.text.downcase }.each do | link |
      excluded_pads = ['1OWQzCS7Ze', 'camilo', 'exSJB9uB71', 'link.text', 'my_first_etherpad_lite_pad', 'pads.html', 'pads', 'prueba_etherpad_ruby', 'test', 'AccionesPostMinka', 'Marco_civil_internet']
      unless excluded_pads.include?(link.text) or link.text.chr == "_"
        pads << {id: format(link.text), edit_url: "#{ENV['pad_url']}p/#{link.text}"}
      end
   end
   pads
  end

  def format text
    return text.capitalize.gsub("-"," ").gsub("_"," ")
  end
end
