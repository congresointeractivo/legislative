module GlossariesHelper

  def get_pad padid = nil

    @pad = { id: params[:id] } 
    ether = EtherpadLite.connect @padurl, @apikey, '1.2.1'

    pad = ether.pad "metodologia"
    
    @pad[:edit_url] = "#{@padurl}p/metodologia"

    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, tables: true)

    @pad[:text] = markdown.render(pad.text)
    @pad
  end
	
  def getlist
   page = Nokogiri::HTML open "http://pad.congresointeractivo.org/list"
   links = page.css "a"

   pad_text = ""

   links.each do | link |
      pad = ether.pad link.text
      puts "Id:#{link.text} texto:#{pad.text}" unless pad.text
      pad_text = pad.text
    end
  end
end
