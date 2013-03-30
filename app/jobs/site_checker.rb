require_relative "../models/site"
require_relative "../models/site_watcher"

class SiteChecker
  # Check all status
  # urls - array of URL
  # timeout - http timeout, in second, default 15
  # concurrency - http concurrency, defautl 20
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

  private
  # Check status of a site
  # 
  # url - url for the site to be fetched
  # hydra - Typhoeus Hydra object, by default create a new hydra
  # 
  # Returns hydra request, caller should run the hydra to fire the check
  def self.check_url(url, timeout=15, hydra=nil)
    site = Site.where(:url => url).first || Site.create(:url => url)
    request = SiteWatcher.new(site, timeout, hydra).watch
  end
end