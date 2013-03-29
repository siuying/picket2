require_relative "../models/site"
require_relative "../models/settings"

class SitesMailer < ActionMailer::Base
  default :from => Settings.email.sender

  def notify_error(site_id)
    @site     = Site.find(site_id)
    @subject  = "Error detected for #{@site.url}"
    mail(:to => Settings.email.receiver, :subject => @subject)
  end

  def notify_resolved(site_id)
    @site     = Site.find(site_id)
    @downtime = @site.failed_at
    @subject  = "Error resolved for #{@site.url}"
    mail(:to => Settings.email.receiver, :subject => @subject)
  end  
end
