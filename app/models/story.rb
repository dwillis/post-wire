class Story < ActiveRecord::Base
  
  has_many :versions
  
  def self.load_feeds(feed_urls)
    urls = []
    feeds = Feedzirra::Feed.fetch_and_parse(feed_urls)
    feeds.each do |url, feed|
      feed.entries.each do |entry|
        begin
          article = PostHaste::Article.create_from_url(entry.entry_id)
          story = Story.find_or_create_by_url(article.permalink)
          story.update_attributes(:title => article.title, :section => article.section.gsub('/','').titleize, :type => article.type, :byline => article.byline, :post_created => article.created_datetime, :post_updated => article.updated_datetime, :post_published => article.published_datetime, :tags => article.tags, :updated => false)
          doc = Nokogiri::HTML(open(entry.entry_id).read)
          body = doc.search('article').inner_html
          article.updated_datetime > story.post_updated ? updated = true : updated = false
          if updated
            story.update_attribute(:updated, true)
            version = Version.where(:story_id => story.id).order('version_number desc').first
            if version
              next_version = version.dup
              next_version.update_attributes(:body => body, :version_number => version.version_number + 1)
            else
              version.update_attribute(:body, body)
            end
          else
            version = story.versions.create(:body => body, :version_number => 1)
            version.save
          end
        rescue # skip inline ads
          next
        end
      end
    end
  end

end
