require_relative "../models/site"
require_relative "../models/site_watcher"

class SiteChecker
  # Check status of a site
  # 
  # url - url for the site to be fetched
  # hydra - Typhoeus Hydra object, by default create a new hydra
  # 
  # Returns hydra request, caller should run the hydra to fire the check
  def self.check_url(url, timeout=15, hydra=Typhoeus::Hydra.new)
    site = Site.where(:url => url).first || Site.create(:url => url)
    SiteWatcher.new(site, timeout, hydra).watch
  end

  # Check all status
  def self.check_urls(urls, timeout=15, concurrency=20)
    hydra = Typhoeus::Hydra.new(:max_concurrency => concurrency)
    requests = Settings.sites.collect do |url|
      SiteChecker.check_url(url, timeout, hydra)
    end
    hydra.run
    requests.collect do |r|
      r.response.handled_response
    end
  end
end