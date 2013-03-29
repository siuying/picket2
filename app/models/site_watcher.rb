class SiteWatcher
  def initialize(site, hydra=Typhoeus::Hydra.hydra)
    @hydra = hydra
    @site = site
    @http_timeout = Settings.http_timeout
  end

  # use typhoeus to make a request and wait for response
  #
  # Return the request
  def watch
    # Create a request and on complete, update site status
    @request = Typhoeus::Request.new(@site.url, :method => :get, :timeout => @http_timeout * 1000, :followlocation => true)
    @request.on_complete  do |response|
      if response.success?
        @site.ok!
      elsif response.timed_out?
        @site.failed!
        @site.message = "Could not get a response from the server before timing out (#{@http_timeout} seconds)."
      elsif response.code == 0
        @site.failed!
        @site.message = "Could not get an http response, something's wrong."    
      else
        @site.failed!
        @site.message = "Server returned: #{response.code.to_s} #{response.status_message}"
      end
      @site.last_response_time = response.total_time
      @site.save!
      @site
    end
    @hydra.queue(@request)
    @request
  end

end