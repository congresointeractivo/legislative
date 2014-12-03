module GlossariesHelper

  def get_pad padid = nil
    @pad = { id: params[:id] } 

    ether = EtherpadLite.connect ENV['padurl'], ENV['apikey'], '1.2.1'
    pad = ether.pad "metodologia"
    
    @pad[:edit_url] = "#{ENV['padurl']}p/metodologia"

    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, tables: true)

    @pad[:text] = markdown.render(pad.text)
    @pad
  end
	
  def get_list
   page = Nokogiri::HTML open "#{ENV['padurl']}list"
   links = page.css "a"

   ether = EtherpadLite.connect ENV['padurl'], ENV['apikey'], '1.2.1'
   pad_text = ""
   pads = []
   links.each do | link |
      pad = ether.pad link.text
      puts "Id:#{link.text} texto:#{pad.text}" unless pad.text
      pad_text = pad.text
      pads << {id: link.text, text: pad.text, edit_url: "#{ENV['padurl']}p/#{link.text}"}
   end
   pads
  end
end
