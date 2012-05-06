class Item
  attr_accessor :rank, :vote_count
  include DataMapper::Resource
  property :id, Serial
  property :title, Text, :index => true   
  property :summary, Text   
  property :source, Text
  property :url, Text
  property :published_at, Time  
  has n, :votes
  
  def self.magic
    @all = all(:published_at.lt => Time.now, :order => [:published_at.desc], :limit => 50)
    @all.each do |item|
      distance_in_hours = (((Time.now - item.published_at).abs)/3600)
      item.rank = item.votes.size + 1 / ((2 + distance_in_hours) ** 2)
      item.vote_count = item.votes.size
    end
    @all.sort{|x,y| y.rank <=> x.rank }
  end
  
end

class Vote
  include DataMapper::Resource  
  property :id, Serial
  property :session_id, Text
end