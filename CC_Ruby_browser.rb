#Browser Pirata: funcionalidades básicas de un navegador.

#Net::HTTP and Nokogiri libraries are required
require 'net/http'
require 'nokogiri'

#it shows values of a page
class Page
  
  #link with page is initialized with 'get' and 'HTML'
  def initialize(url)
  	@uri = URI(url)
  	res = Net::HTTP.get(@uri)
  	@doc = Nokogiri::HTML(res)
  end

  #values are displayed
  def fetch!
  	puts "url> #{@uri}"
  	puts "Fetching..."
  	puts "Título: #{title}"
  	puts "Links:"
  	puts "#{@value_links[0..3]}: #{@links[0]}"
  	puts "#{@value_links[4..23]}: #{@links[1]}"
  	puts "#{@value_links[24..27]}: #{@links[2]}"
  	puts "#{@value_links[28..37]}: #{@links[3]}"
  	puts "..."
  	puts "url>"
  end

  #links and values of 'link' are gotten
  def links
    @links = @doc.css('nav a').map { |link| link['href'] }
    @value_links = @doc.search('.nav li> a').inner_text
  end

  #title of page is gotten
  def title
    title = @doc.search("title").inner_text
  end

end

#it controls the program
class Browser
	#run program
	def run!
		puts "Da un link:"
    url_link = URI(ARGV.first)
		link = Page.new(url_link)
    link.links
    link.fetch!
  end
end

#Driver code

Browser.new.run!
