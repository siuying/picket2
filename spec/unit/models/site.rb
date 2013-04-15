describe Site do
  describe "#add_response_time" do
    it "should add to last_response_time" do
      subject.add_response_time 3.14
      subject.last_response_time.should == 3.14
    end

    it "should add to response_times" do
      subject.add_response_time 3.14
      subject.response_times.last.should 3.14
      subject.response_times.should be_include(3.14)
    end
  end
end