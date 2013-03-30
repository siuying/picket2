require 'typhoeus'
require_relative '../mailers/sites_mailer'
require_relative './site'

class SiteWatcher
  attr_reader :site, :mailer, :hydra, :http_timeout

  def initialize(site, timeout, mailer, hydra)
    @hydra = hydra
    @site = site
    @http_timeout = timeout
    @mailer = mailer
  end

  # use typhoeus to make a request and wait for response
  #
  # Return the request
  def watch
    # Create a request and on complete, update site status
    request = Typhoeus::Request.new(site.url, :method => :get, :timeout => http_timeout * 1000, :followlocation => true)
    request.on_complete  do |response|
      last_failed = site.failed?

      # update status
      if response.success?
        site.ok!
      elsif response.timed_out?
        site.failed!
        site.message = "Could not get a response from the server before timing out (#{http_timeout} seconds)."
      elsif response.code == 0
        site.failed!
        site.message = "Could not get an http response, something's wrong."    
      else
        site.failed!
        site.message = "Server returned: #{response.code.to_s} #{response.status_message}"
      end
      site.last_response_time = response.total_time
      site.save!

      # email notification
      if last_failed && site.ok?
        mailer.notify_resolved(site.id).deliver
      elsif !last_failed && site.failed?
        mailer.notify_error(site.id).deliver
      end

      site
    end
    hydra.queue(request)
    request
  end

  # Watch set of URLS, update their status in db, and send notification if needed
  # 
  # urls - array of url, if not in db, create a Site object
  # timeout - (optional) http timeout in seconds, default 15s
  # mailer - (optional) notification email sender
  # hydra - (optional) typhoeus hydra object to manage concurrent connections
  # 
  # Return array of sites
  def self.watch_urls(urls, timeout=15, mailer=SitesMailer, hydra=Typhoeus::Hydra.new)
    requests = urls.collect do |url|
      site = Site.find_or_create_with_url(url)
      request = SiteWatcher.new(site, timeout, mailer, hydra).watch
    end
    hydra.run
    requests.collect do |r|
      r.response.handled_response
    end
  end
end