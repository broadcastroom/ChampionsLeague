module Champions
  require 'open-uri'
  require 'kconv'
  require 'nokogiri'

  def self.crawl(start_url)
    doc = Nokogiri::HTML(open(start_url, &:read))
    return doc
  end
     
  def self.get_team_url(url_doc)
    team_url_odd_array = []
    team_url_even_array = []
    team_url =[]

    team_url_odd = url_doc.xpath('//table[@class="leaguetable sortable table detailed-table"]/tbody/tr[@class="odd   team_rank"]/td[@class="text team large-link"]/a/@href').text.split(/[0-9]+\//)
    for i in 0..(team_url_odd.size-1)
      team_url_odd_array.push(team_url_odd[i])
    end
    
    team_url_even = url_doc.xpath('//table[@class="leaguetable sortable table detailed-table"]/tbody/tr[@class="even   team_rank"]/td[@class="text team large-link"]/a/@href').text.split(/[0-9]+\//)
    for i in 0..(team_url_even.size-1)
      team_url_even_array.push(team_url_even[i])
    end

    team_url = team_url_odd_array.concat(team_url_even_array)
    return team_url
  end

  def self.get_team_name(url_doc)
    team_name = []
    team_name_odd_array = []
    team_name_even_array = []

    team_name_odd = url_doc.xpath('//table[@class="leaguetable sortable table detailed-table"]/tbody/tr[@class="odd   team_rank"]/td[@class="text team large-link"]/a/@title')
    for i in 0..(team_name_odd.size-1)
      team_name_odd_array.push(team_name_odd[i].text)
    end

    team_name_even = url_doc.xpath('//table[@class="leaguetable sortable table detailed-table"]/tbody/tr[@class="even   team_rank"]/td[@class="text team large-link"]/a/@title')
    for i in 0..(team_name_even.size-1)
      team_name_even_array.push(team_name_even[i].text)
    end
    
    team_name = team_name_odd_array.concat(team_name_even_array)
    return team_name
  end

  def self.get_team_national(team_url)
    dd_doc = []
    for i in 0..(team_url.size-1)
      team_doc = self.crawl('http://int.soccerway.com'+team_url[i])
      dd_doc.push(team_doc.xpath('//div[@class="clearfix"]/dl/dd')[2].text) 
    end
    
    return dd_doc
  end
end

