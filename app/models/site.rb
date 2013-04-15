require 'transitions'

class Site < ActiveRecord::Base
  SITE_SAMPLE_SIZE = 60 * 24

  include ActiveRecord::Transitions
  
  serialize :response_times, Array

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

  def add_response_time(time)
    self.last_response_time = time
    self.response_times.push(time)
    self.response_times.shift if self.response_times.count > SITE_SAMPLE_SIZE
    self
  end

  def self.find_or_create_with_url(url)
    Site.where(:url => url).first || Site.create(:url => url)
  end

end