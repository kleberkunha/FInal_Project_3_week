require 'rubygems'
require 'nokogiri'
require 'open-uri'

def get_townhall_email(url)
  page = Nokogiri::HTML(URI.open("http://annuaire-des-mairies.com/#{url}"))
  page.css('td')[7].text
end

def getting_all_emails
  page = Nokogiri::HTML(URI.open('http://annuaire-des-mairies.com/val-d-oise.html'))
  list = page.css('a.lientxt') # #return an array of elements (a)
  final_result = list.map do |link| ## here i look in each element (a)
    url = link['href'] # #here i get the link of each (a)
    { link.text => get_townhall_email(url) } # ###here i put the  name of the "links" and the emails in a hash
  end
  puts final_result
end
getting_all_emails
