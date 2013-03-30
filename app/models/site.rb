require 'transitions'

class Site < ActiveRecord::Base
  include ActiveRecord::Transitions

  def self.find_or_create_with_url(url)
    Site.where(:url => url).first || Site.create(:url => url)
  end

  state_machine do
    state :unknown
    state :ok
    state :failed
    
    event :ok, :timestamp => true do
      transitions :from => [:ok, :failed, :unknown], :to => :ok
    end

    event :failed, :timestamp => true do
      transitions :from => [:ok, :failed, :unknown], :to => :failed      
    end
    
    event :reset do
      transitions :from => [:ok, :failed, :unknown], :to => :unknown
    end
  end
end