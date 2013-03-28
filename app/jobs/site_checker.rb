require_relative "../models/site"
require_relative "../models/site_watcher"

class SiteChecker
  # Check status of a site, if the status changed from anything to FAILED, or changed 
  # from FAILED to OK, send an email notification.
  #
  # site_id - id for the site to be fetched
  def self.perform(url)
    site = Site.where(:url => url).first
    unless site
      site = Site.create(:url => url)
    end
    SiteWatcher.new(site).watch
  end
end