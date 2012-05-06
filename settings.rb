require 'dm-core'
require 'dm-validations'
require 'dm-timestamps'
require 'model'
require 'haml'
require 'sass'
require 'feedzirra'
require 'merb-helpers/date_time_helpers'

enable :sessions

helpers do
  include Merb::Helpers::DateAndTime  
end

configure :production do
  DataMapper.setup(:default, ENV['DATABASE_URL'] || "mysql://test:test@localhost/pdxlocal") 
end

configure :development do
  DataMapper.setup(:default, ENV['DATABASE_URL'] || "mysql://root:@localhost/pdxlocal") 
end

DataMapper.auto_upgrade!

configure do
  Feeds = [
    ['LocalCut', 'http://blogs.wweek.com/music/feed/'],
    ['WWire', 'http://blogs.wweek.com/news/feed/'],
    ['Blogtown, PDX', 'http://blogtown.portlandmercury.com/portland/Rss.xml?category=41935'],
    ['End Hits', 'http://endhits.portlandmercury.com/portland/Rss.xml?category=808763'],
    ['PORT', 'http://www.portlandart.net/index.xml'],
    ['BikePortland', 'http://feeds.feedburner.com/BikePortland'],
    ['Jack Bog', 'http://bojack.org/index.xml'],
    ['UrbanHonking', 'http://www.urbanhonking.com/urho/blogroll.xml'],
    ['Upcoming', 'http://upcoming.yahoo.com/syndicate/v2/search_all/?loc=portland&rt=1&sort=start-date-asc'], 
    ['Fox12', 'feed://www.kptv.com/news/topstory.rss'], 
    ['Around the Sun', 'http://feeds.feedburner.com/AroundTheSunBlog'], 
    ['Oregon Live', 'feed://blog.oregonlive.com/news_impact/atom.xml'], 
    ['PDXPipeline', 'http://pdxpipeline.com/feed/'], 
    ['OurPDX', 'http://feeds.feedburner.com/OurPdxNetwork'],      
  ]
end
