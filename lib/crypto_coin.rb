require 'rubygems'
require 'nokogiri'
require 'open-uri'

def getting_price
  page = Nokogiri::HTML(URI.open('https://coinmarketcap.com/all/views/all/'))
  list = page.css('tr.cmc-table-row').map do |row|
    currency = { row.children[2].text => row.children[4].text }
  end
  puts list
end
getting_price
