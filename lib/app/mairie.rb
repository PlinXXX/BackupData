require 'open-uri'
require 'nokogiri'


class Scrapper

  def get_townhall_urls
    urls_townhall = []

    doc = Nokogiri::HTML(open("http://annuaire-des-mairies.com/val-d-oise.html"))
    doc.xpath('//*[@class="lientxt"]').each { |ele| urls_townhall << ele.values[1] }
    
    return urls_townhall.each { |url| url.delete_prefix!(".").insert(0, 'http://annuaire-des-mairies.com') }
  end #get_townhall_urls


  def get_townhall_email(townhall_url)
    doc = Nokogiri::HTML(open(townhall_url))
    doc.xpath('/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]').text
  end #get_townhall_email


  def emails_townhall
    emails_townhall = []
    n = 0

    (get_townhall_urls.length).times do
      emails_townhall << get_townhall_email(get_townhall_urls[n])
      n += 1
    end

    return emails_townhall
  end #emails_townhall


  def names_townhall
    names_townhall = []
    doc = Nokogiri::HTML(open("http://annuaire-des-mairies.com/val-d-oise.html"))
    doc.xpath('//*[@class="lientxt"]').each { |ele| names_townhall << ele.text }
    return names_townhall
  end #names_townhall


  def townhall_emails_scrapper
    array = []

    names = names_townhall
    emails = emails_townhall

    n = 0
    (names.length).times do
      puts "Getting #{Hash[names[n].to_s, emails[n].to_s]}"
      array << Hash[names[n].to_s, emails[n].to_s]
      n += 1
    end
  
    return array
  end #townhall_emails_scrapper


  def save_as_JSON
    list = townhall_emails_scrapper
    json = File.new('db/email.json', 'w')
      list.each do |name_email|
        json.puts name_email
      end
    json.close
  end #save_as_JSON


  def save_as_spreadsheet
    
  end #save_as_spreadsheet


  def save_as_CSV
    
    list = townhall_emails_scrapper

    #Exporter chaque element de la list vers email.css
    CSV.open("db/email.csv", "a+") { |csv| list.each { |name| csv << name } }
    
    #Afficher le fichier
      csv = CSV.open("db/email.csv", "r") 
      csv.each do |line| 
        print line
        puts
      end
    #Afficher le fichier

  end #save_as_CSV

end
