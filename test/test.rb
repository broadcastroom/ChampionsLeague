require 'open-uri'
require 'kconv'
require 'nokogiri'
require '../lib/champions_league'

url = 'http://int.soccerway.com/international/europe/uefa-champions-league/20152016/group-stage/r31729/'

test_doc = Champions.crawl(url)
p Champions.get_team_name(test_doc)
p Champions.get_team_url(test_doc)
# team_url = Champions.get_team_url_odd(test_doc)
# p Champions.get_team_name(team_url)
