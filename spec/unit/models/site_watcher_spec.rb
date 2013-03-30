require "spec_helper"
require "models/site_watcher"
require "mailers/sites_mailer"

describe SiteWatcher do
  describe "+watch_urls" do
    it "should iterate though input URLS and check their url" do 
      stub_request(:any, "google.com.hk")
      stub_request(:any, "hk.yahoo.com")

      SiteWatcher.watch_urls(["http://google.com.hk", "http://hk.yahoo.com"])
      Site.where(url: "http://google.com.hk").first.ok?.should be_true
      Site.where(url: "http://hk.yahoo.com").first.ok?.should be_true
    end

    context "failed site" do
      before do
        stub_request(:any, "google.com.hk")
        stub_request(:any, "hk.yahoo.com").to_return(:status => 500)
      end

      it "should updated as failed when it failed" do
        SiteWatcher.watch_urls(["http://google.com.hk", "http://hk.yahoo.com"], 15, SitesMailer)
        yahoo = Site.where(url: "http://hk.yahoo.com").first
        yahoo.failed?.should be_true
      end

      it "should trigger email notification" do
        SiteWatcher.watch_urls(["http://hk.yahoo.com"], 15, SitesMailer)

        ActionMailer::Base.deliveries.empty?.should_not be_true
        email = ActionMailer::Base.deliveries.last
        email.to.should be_include(Settings.email.receiver)
        email.from.should be_include(Settings.email.sender)
        email.encoded.should be_include("hk.yahoo.com")
        email.encoded.should be_include("error")
      end
    end

    context "recovered site" do
      before do
        stub_request(:any, "hk.yahoo.com")
      end

      it "should trigger email notification" do
        Site.create(url: "http://hk.yahoo.com", state: "error")
        SiteWatcher.watch_urls(["http://hk.yahoo.com"], 15, SitesMailer)

        ActionMailer::Base.deliveries.empty?.should_not be_true
        email = ActionMailer::Base.deliveries.last
        email.to.should be_include(Settings.email.receiver)
        email.from.should be_include(Settings.email.sender)
        email.encoded.should be_include("hk.yahoo.com")
        email.encoded.should be_include("resolved")
      end
    end
  end
end