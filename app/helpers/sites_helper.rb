module SitesHelper
  def icon_for_site(site)
    case site.state
    when "unknown"
      %{<img src="icons/help.png" />}
    when "ok"
      %{<img src="icons/accept.png" />}
    when "failed"
      %{<img src="icons/exclamation.png" />}
    else
      raise "unexpected state: #{site.state}"
    end
  end

  def message_for_site(site)
    site_name = site.url.gsub(%r{^http://}, "")
    site_link = %{<a href="#{site.url}" target="_BLANK">#{site_name}</a>}
    case site.state
    when "unknown"
      "#{site_link} will be watched soon"
    when "ok"
      "#{site_link} is running"
    when "failed"
      "#{site_link} is down since #{site.failed_at}"
    else
      raise "unexpected state: #{site.state}"
    end
  end  
end
