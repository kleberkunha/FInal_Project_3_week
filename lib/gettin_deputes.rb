require 'rubygems'
require 'nokogiri'
require 'open-uri'

def get_townhall_email(url)
  page = Nokogiri::HTML(URI.open("https://www.nosdeputes.fr/#{url}"))
  li_list = page.xpath('//a[starts-with(@href, "mailto:")]') ## here i take every link href starting with mailto inside of <a>
  li_list[0].text unless li_list.empty? # Here i said, 'Print' unless if the list is empty
end

# get_townhall_email('/caroline-abadie')
def split_name(full_name)
  full_name.split(', ') # #Here i split the full name
end
# puts split_name('Abad, Damien')

def get_names_deput
  page = Nokogiri::HTML(URI.open('https://www.nosdeputes.fr/deputes'))
  list = page.css('div.liste a').reject do |link| # #Here i get the div with class liste and the <a>,
    link['href'].nil? || link['href'].start_with?('/deputes#') || get_townhall_email(link['href']).nil? || link.css('span.list_nom').nil? # and i say that if the url is empty reject
    # because some depute have two emails and other only 1 e-mail
  end
  list.map do |link| ## here i look in each element (a)
    email = get_townhall_email(link['href']) # here i call the link of the website of each depute
    full_name = link.css('span.list_nom').text # #here i have all the full names
    splited = split_name(full_name.strip!) ### here i take the split function and print
    { 'first_name' => splited[1], # here i print the splited[1] that is the 2 position of the hash
      'last_name' => splited[0], # #same but 1 positions of the hash
      'email' => email } # here i recover the links of each email.
  end
end
puts get_names_deput
