class SiteWatcher
  def initialize(site)
    @site = site
    @http_timeout = Settings.http_timeout
  end
  
  def watch
    response = get_url(@site.url)

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

    @site.save!
    @site
  end
  
  private
  def get_url(url)
    request = Typhoeus::Request.new(url, :method => :get, :timeout => @http_timeout * 1000, :followlocation => true)
    hydra = Typhoeus::Hydra.hydra
    hydra.queue(request)
    hydra.run
    request.response    
  end
end