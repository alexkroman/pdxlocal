require 'application'

task :cron do
  Feeds.each do |url|
    primary_url = url[1]
    title = url[0]
    begin
      feed = Feedzirra::Feed.fetch_and_parse(primary_url).sanitize_entries!
    rescue
      next
    end
    feed.entries.each do |entry|
      unless Item.first(:url => entry.url)
      p "Adding #{entry.title}"
      Item.create(:title => entry.title, :summary => entry.summary, :url => entry.url, :published_at => entry.published, :source => url[0])
      end
    end
  end
end
